Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD6l83FphzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 04:39:16 +1000 (AEST)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 23 May 2016 19:39:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 666D217D805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 19:40:11 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4NId8v545416624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 18:39:08 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4NHdAbN016578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:39:10 -0600
Date: Mon, 23 May 2016 20:39:02 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Roth
 <mdroth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org
Subject: Re: powerpc/pseries: start rtasd before PCI probing
Message-ID: <20160523203902.37c5ab8b@bahia.huguette.org>
In-Reply-To: <57434A97.90501@redhat.com>
References: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
 <57434A97.90501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 May 2016 20:23:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 23.05.2016 10:28, Greg Kurz wrote:
> > A strange behaviour is observed when comparing PCI hotplug in QEMU, between
> > x86 and pseries. If you consider the following steps:
> > - start a VM
> > - add a PCI device via the QEMU monitor before the rtasd has started (for
> >   example starting the VM in paused state, or hotplug during FW or boot
> >   loader)
> > - resume the VM execution
> > 
> > The x86 kernel detects the PCI device, but the pseries one does not.
> > 
> > This happens because the rtasd kernel worker is currently started under
> > device_initcall, while PCI probing happens earlier under subsys_initcall.
> > 
> > As a consequence, if we have a pending RTAS event at boot time, a message
> > is printed and the event is dropped.
> > 
> > This patch moves all the initialization of rtasd to arch_initcall, which is
> > run before subsys_call: this way, logging_enabled is true when the RTAS
> > event pops up and it is not lost anymore.
> > 
> > The proc fs bits stay at device_initcall because they cannot be run before
> > fs_initcall.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/rtasd.c |   19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)  
> 
> By the way, same is true for device UNplugging: When unplugging devices
> in QEMU while the firmware is still running, they are never properly
> removed from the guest. I've checked it, and your patch fixes this
> problem as well! Great :-)
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> 

Indeed, all pending RTAS events were lost... now rtasd will log them, up
to 64 events, but I did not test that far :)

Thanks for testing !

Cheers.

--
Greg
