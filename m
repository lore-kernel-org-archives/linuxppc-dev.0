Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3D1A5B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 01:22:02 +1100 (EST)
Date: Tue, 29 Nov 2011 19:51:49 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Miche Baker-Harvey <miche@google.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
Message-ID: <20111129142149.GE2822@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <20111123103852.GG16665@amit-x200.redhat.com>
 <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
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

Hi,

On (Mon) 28 Nov 2011 [15:40:41], Miche Baker-Harvey wrote:
> Amit,
> 
> You said that the work would be serialized "due to port additions
> being on work items on the same workqueue".  I'm not seeing that.

You leave a lot of questions unanswered.  What's your environment?
Are you hot-plugging ports?  Are you using qemu?  What's your command
line?

> I've double checked this by using a mutex_trylock in
> hvc_console::hvc_alloc(), and here's the relevant output from dmesg:
> 
> root@myubuntu:~# dmesg | grep MBH
> [3307216.210274] MBH: got hvc_ports_mutex
> [3307216.210690] MBH: trylock of hvc_ports_mutex failed
> [3307216.211143] MBH: got hvc_ports_mutex
> 
> This is in a system with two virtio console ports, each of which is a
> console.  I think if the VIRTIO_CONSOLE_CONSOLE_PORT message handling
> were actually being serialized, the trylock should never fail.

Agreed.

> What's the source of the serialization for the workqueue items?  At
> first reading it looks like the control_work_handler gets called for
> each virtio interrupt?

It all depends on how you add ports.  If you're using qemu, they
happen via the control work handler.

		Amit
