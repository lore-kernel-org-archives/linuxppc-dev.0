Return-Path: <miche@google.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 64EE5B6F7D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 04:04:33 +1100 (EST)
Received: by qyd20 with SMTP id 20so491505qyd.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 09:04:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111129142149.GE2822@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <20111123103852.GG16665@amit-x200.redhat.com>
 <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
 <20111129142149.GE2822@amit-x200.redhat.com>
Date: Tue, 29 Nov 2011 09:04:28 -0800
Message-ID: <CAB8RdapuPRym2dH_9mgmGdzpCxnP1KpS+hS8JJ-geVkga5fMcw@mail.gmail.com>
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
We aren't using either QEMU or kvmtool, but we are using KVM. =A0All
theissues we are seeing happen when we try to establish multiple
virtioconsoles at boot time. =A0The command line isn't relevant, but I
cantell you the protocol that's passing between the host (kvm) and
theguest (see the end of this message).
We do go through the control_work_handler(), but it's not
providingsynchronization. =A0Here's a trace of the
control_work_handler() andhandle_control_message() calls; note that
there are two concurrentcalls to control_work_handler().
I decorated control_work_handler() with a "lifetime" marker,=A0and
passedthis value to handle_control_message(), so we can see which
control
messages are being handled from which instance of
thecontrol_work_handler() thread.
Notice that we enter control_work_handler() a second time before
thehandling of the second PORT_ADD message is complete. The
firstCONSOLE_PORT message is handled by the second
control_work_handler()call, but the second is handled by the first
control_work_handler() call.

root@myubuntu:~# dmesg | grep MBH[3371055.808738]
control_work_handler #1[3371055.809372] + #1 handle_control_message
PORT_ADD[3371055.810169] - handle_control_message
PORT_ADD[3371055.810170] + #1 handle_control_message PORT_ADD
[3371055.810244] =A0control_work_handler #2[3371055.810245] + #2
handle_control_message CONSOLE_PORT[3371055.810246] =A0got
hvc_ports_mutex[3371055.810578] - handle_control_message
PORT_ADD[3371055.810579] + #1 handle_control_message
CONSOLE_PORT[3371055.810580] =A0trylock of hvc_ports_mutex
failed[3371055.811352] =A0got hvc_ports_mutex[3371055.811370] -
handle_control_message CONSOLE_PORT[3371055.816609] -
handle_control_message CONSOLE_PORT=A0=A0So, I'm guessing the bug is that
there shouldn't be two instances ofcontrol_work_handler() running
simultaneously?
Thanks,
Miche

Protocol:We set up the virtio console device registers during
initialization,specifying the multiport feature, and some number of
ports, n, where nis greater than 1.
In the guest, virtcons_probe() finds our device, and successfully
sendsthe VIRTIO_CONSOLE_DEVICE_READY=3D1 control message.
On the host, we receive the VIRTIO_CONSOLE_DEVICE_READY message,
andsend one VIRTIO_CONSOLE_PORT_ADD message via the Receive Control
queuefor each port in the number of ports. =A0These messages are
notserialized: they are all sent at once.
The VIRTIO_CONSOLE_PORT_ADD messages are received
inhandle_control_message() in virtio_console.c, and add_port() is
calledfor each. =A0After each port is added, the guest
sendsVIRTIO_CONSOLE_PORT_READY to the host, and in these messages, the
idof the port is included in the message.
On the host, in response to each VIRTIO_CONSOLE_PORT_READY=3D1
message,we may send a VIRTIO_CONSOLE_CONSOLE_PORT message.
On the guest, in response to each VIRTIO_CONSOLE_CONSOLE_PORT
message,init_port_console() is called on the individual port. =A0The
same id isused for these messages as was used for the PORT_READY
messages.
After each successful init_port_console(), the guest
sendsVIRTIO_CONSOLE_PORT_OPEN back to the host.

On Tue, Nov 29, 2011 at 6:21 AM, Amit Shah <amit.shah@redhat.com> wrote:
> Hi,
>
> On (Mon) 28 Nov 2011 [15:40:41], Miche Baker-Harvey wrote:
>> Amit,
>>
>> You said that the work would be serialized "due to port additions
>> being on work items on the same workqueue". =A0I'm not seeing that.
>
> You leave a lot of questions unanswered. =A0What's your environment?
> Are you hot-plugging ports? =A0Are you using qemu? =A0What's your command
> line?
>
>> I've double checked this by using a mutex_trylock in
>> hvc_console::hvc_alloc(), and here's the relevant output from dmesg:
>>
>> root@myubuntu:~# dmesg | grep MBH
>> [3307216.210274] MBH: got hvc_ports_mutex
>> [3307216.210690] MBH: trylock of hvc_ports_mutex failed
>> [3307216.211143] MBH: got hvc_ports_mutex
>>
>> This is in a system with two virtio console ports, each of which is a
>> console. =A0I think if the VIRTIO_CONSOLE_CONSOLE_PORT message handling
>> were actually being serialized, the trylock should never fail.
>
> Agreed.
>
>> What's the source of the serialization for the workqueue items? =A0At
>> first reading it looks like the control_work_handler gets called for
>> each virtio interrupt?
>
> It all depends on how you add ports. =A0If you're using qemu, they
> happen via the control work handler.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Amit
>
