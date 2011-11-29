Return-Path: <miche@google.com>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
 [209.85.216.44]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 37DC1B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 04:50:44 +1100 (EST)
Received: by qao25 with SMTP id 25so641830qao.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 09:50:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB8RdapuPRym2dH_9mgmGdzpCxnP1KpS+hS8JJ-geVkga5fMcw@mail.gmail.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <20111123103852.GG16665@amit-x200.redhat.com>
 <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
 <20111129142149.GE2822@amit-x200.redhat.com>
 <CAB8RdapuPRym2dH_9mgmGdzpCxnP1KpS+hS8JJ-geVkga5fMcw@mail.gmail.com>
Date: Tue, 29 Nov 2011 09:50:41 -0800
Message-ID: <CAB8Rdapfuf5XH+X9gsUL+CJ9gTQcSNfq4Dj9DoYWQeFgD04ODQ@mail.gmail.com>
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

Good grief!  Sorry for the spacing mess-up!  Here's a resend with reformatting.

Amit,
We aren't using either QEMU or kvmtool, but we are using KVM.  All
the issues we are seeing happen when we try to establish multiple
virtioconsoles at boot time.  The command line isn't relevant, but I
can tell you the protocol that's passing between the host (kvm) and
the guest (see the end of this message).

We do go through the control_work_handler(), but it's not
providing synchronization.  Here's a trace of the
control_work_handler() and handle_control_message() calls; note that
there are two concurrent calls to control_work_handler().

I decorated control_work_handler() with a "lifetime" marker, and
passed this value to handle_control_message(), so we can see which
control messages are being handled from which instance of
the control_work_handler() thread.

Notice that we enter control_work_handler() a second time before
the handling of the second PORT_ADD message is complete. The
first CONSOLE_PORT message is handled by the second
control_work_handler() call, but the second is handled by the first
control_work_handler() call.

root@myubuntu:~# dmesg | grep MBH
[3371055.808738] control_work_handler #1
[3371055.809372] + #1 handle_control_message PORT_ADD
[3371055.810169] - handle_control_message PORT_ADD
[3371055.810170] + #1 handle_control_message PORT_ADD
[3371055.810244]  control_work_handler #2
[3371055.810245] + #2 handle_control_message CONSOLE_PORT
[3371055.810246]  got hvc_ports_mutex
[3371055.810578] - handle_control_message PORT_ADD
[3371055.810579] + #1 handle_control_message CONSOLE_PORT
[3371055.810580]  trylock of hvc_ports_mutex failed
[3371055.811352]  got hvc_ports_mutex
[3371055.811370] - handle_control_message CONSOLE_PORT
[3371055.816609] - handle_control_message CONSOLE_PORT

So, I'm guessing the bug is that there shouldn't be two instances of
control_work_handler() running simultaneously?

Thanks,

Miche

Protocol:
We set up the virtio console device registers during initialization,
specifying the multiport feature, and some number of
ports, n, where nis greater than 1.

In the guest, virtcons_probe() finds our device, and successfully
sends the VIRTIO_CONSOLE_DEVICE_READY=1 control message.
On the host, we receive the VIRTIO_CONSOLE_DEVICE_READY message,
and send one VIRTIO_CONSOLE_PORT_ADD message via the Receive Control
queuefor each port in the number of ports.  These messages are
not serialized: they are all sent at once.

The VIRTIO_CONSOLE_PORT_ADD messages are received
in handle_control_message() in virtio_console.c, and add_port() is
called for each.  After each port is added, the guest
sendsVIRTIO_CONSOLE_PORT_READY to the host, and in these messages, the
id of the port is included in the message.

On the host, in response to each VIRTIO_CONSOLE_PORT_READY=1
message, we may send a VIRTIO_CONSOLE_CONSOLE_PORT message.
On the guest, in response to each VIRTIO_CONSOLE_CONSOLE_PORT
message, init_port_console() is called on the individual port.  The
same id is used for these messages as was used for the PORT_READY
messages.

After each successful init_port_console(), the guest
sends VIRTIO_CONSOLE_PORT_OPEN back to the host.
