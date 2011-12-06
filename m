Return-Path: <miche@google.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0ABD31007D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 04:05:42 +1100 (EST)
Received: by qcol42 with SMTP id l42so2509898qco.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2011 09:05:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111205105452.GB27683@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <20111123103852.GG16665@amit-x200.redhat.com>
 <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
 <20111129142149.GE2822@amit-x200.redhat.com>
 <CAB8RdapuPRym2dH_9mgmGdzpCxnP1KpS+hS8JJ-geVkga5fMcw@mail.gmail.com>
 <CAB8Rdapfuf5XH+X9gsUL+CJ9gTQcSNfq4Dj9DoYWQeFgD04ODQ@mail.gmail.com>
 <20111205105452.GB27683@amit-x200.redhat.com>
Date: Tue, 6 Dec 2011 09:05:38 -0800
Message-ID: <CAB8Rdar=qOokxZkjQVRmo=zN_f75jPwzU+6=WBRo0g+P7w+pAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
From: Miche Baker-Harvey <miche@google.com>
To: Amit Shah <amit.shah@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>,
 Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Greg Kroah-Hartman <gregkh@suse.de>, Eric Northrup <digitaleric@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Amit,

Ah, indeed.  I am not using MSI-X, so virtio_pci::vp_try_to_find_vqs()
calls vp_request_intx() and sets up an interrupt callback.  From
there, when an interrupt occurs, the stack looks something like this:

virtio_pci::vp_interrupt()
  virtio_pci::vp_vring_interrupt()
    virtio_ring::vring_interrupt()
      vq->vq.callback()  <-- in this case, that's virtio_console::control_i=
ntr()
        workqueue::schedule_work()
          workqueue::queue_work()
            queue_work_on(get_cpu())  <-- queues the work on the current CP=
U.

I'm not doing anything to keep multiple control message from being
sent concurrently to the guest, and we will take those interrupts on
any CPU. I've confirmed that the two instances of
handle_control_message() are occurring on different CPUs.

Should this work?  I don't see anywhere that QEMU is serializing the
sending of data to the control queue in the guest, and there's no
serialization in
the control_intr.  I don't understand why you are not seeing the
concurrent execution of handle_control_message().  Are you taking all
your interrupts on a single CPU, maybe?  Or is there some other
serialization in user space?

Miche


On Mon, Dec 5, 2011 at 2:54 AM, Amit Shah <amit.shah@redhat.com> wrote:
> On (Tue) 29 Nov 2011 [09:50:41], Miche Baker-Harvey wrote:
>> Good grief! =A0Sorry for the spacing mess-up! =A0Here's a resend with re=
formatting.
>>
>> Amit,
>> We aren't using either QEMU or kvmtool, but we are using KVM. =A0All
>
> So it's a different userspace? =A0Any chance this different userspace is
> causing these problems to appear? =A0Esp. since I couldn't reproduce
> with qemu.
>
>> the issues we are seeing happen when we try to establish multiple
>> virtioconsoles at boot time. =A0The command line isn't relevant, but I
>> can tell you the protocol that's passing between the host (kvm) and
>> the guest (see the end of this message).
>>
>> We do go through the control_work_handler(), but it's not
>> providing synchronization. =A0Here's a trace of the
>> control_work_handler() and handle_control_message() calls; note that
>> there are two concurrent calls to control_work_handler().
>
> Ah; how does that happen? =A0control_work_handler() should just be
> invoked once, and if there are any more pending work items to be
> consumed, they should be done within the loop inside
> control_work_handler().
>
>> I decorated control_work_handler() with a "lifetime" marker, and
>> passed this value to handle_control_message(), so we can see which
>> control messages are being handled from which instance of
>> the control_work_handler() thread.
>>
>> Notice that we enter control_work_handler() a second time before
>> the handling of the second PORT_ADD message is complete. The
>> first CONSOLE_PORT message is handled by the second
>> control_work_handler() call, but the second is handled by the first
>> control_work_handler() call.
>>
>> root@myubuntu:~# dmesg | grep MBH
>> [3371055.808738] control_work_handler #1
>> [3371055.809372] + #1 handle_control_message PORT_ADD
>> [3371055.810169] - handle_control_message PORT_ADD
>> [3371055.810170] + #1 handle_control_message PORT_ADD
>> [3371055.810244] =A0control_work_handler #2
>> [3371055.810245] + #2 handle_control_message CONSOLE_PORT
>> [3371055.810246] =A0got hvc_ports_mutex
>> [3371055.810578] - handle_control_message PORT_ADD
>> [3371055.810579] + #1 handle_control_message CONSOLE_PORT
>> [3371055.810580] =A0trylock of hvc_ports_mutex failed
>> [3371055.811352] =A0got hvc_ports_mutex
>> [3371055.811370] - handle_control_message CONSOLE_PORT
>> [3371055.816609] - handle_control_message CONSOLE_PORT
>>
>> So, I'm guessing the bug is that there shouldn't be two instances of
>> control_work_handler() running simultaneously?
>
> Yep, I assumed we did that but apparently not. =A0Do you plan to chase
> this one down?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Amit
>
