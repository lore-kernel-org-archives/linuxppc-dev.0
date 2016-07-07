Return-Path: <groug@kaod.org>
Received: from 1.mo69.mail-out.ovh.net (1.mo69.mail-out.ovh.net
 [178.33.251.173])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rllrX4T9bzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 04:04:43 +1000 (AEST)
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 05E85100CC2B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 19:26:17 +0200 (CEST)
Date: Thu, 7 Jul 2016 19:26:07 +0200
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, Paul
 Mackerras <paulus@samba.org>, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-ppc] [PATCH v2] powerpc/pseries: start rtasd before PCI
 probing
Message-ID: <20160707192607.7820a67e@bahia.lan>
In-Reply-To: <20160621110201.38d8711c@bahia.lan>
References: <146602104462.23192.4267928292361711364.stgit@bahia.lan>
 <20160621110201.38d8711c@bahia.lan>
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

Ping ?

On Tue, 21 Jun 2016 11:02:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 15 Jun 2016 22:26:41 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> 
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
> > v2: - avoid behaviour change: don't create the proc entry if early init failed
> >   
> 
> I forgot to mention that Thomas had sent a Tested-by for v1, which I think is
> still valid for v2.
> 
> > Michael,
> > 
> > This was also tested under PowerVM: it doesn't fix anything there because the
> > HMC tells it won't honor DLPAR features as long as the RMC isn't here, which
> > happens later in the boot sequence. It hence seems impossible to have a pending
> > RTAS event at boot time.
> > 
> > It doesn't seem to break anything either, the kernel boots and hotplug works
> > okay once the RMC is up.
> > 
> > Cheers.
> > 
> > --
> > Greg
> > 
> > ---
> >  arch/powerpc/kernel/rtasd.c |   22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> > index e864b7c5884e..a26a02006576 100644
> > --- a/arch/powerpc/kernel/rtasd.c
> > +++ b/arch/powerpc/kernel/rtasd.c
> > @@ -526,10 +526,8 @@ void rtas_cancel_event_scan(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rtas_cancel_event_scan);
> >  
> > -static int __init rtas_init(void)
> > +static int __init rtas_event_scan_init(void)
> >  {
> > -	struct proc_dir_entry *entry;
> > -
> >  	if (!machine_is(pseries) && !machine_is(chrp))
> >  		return 0;
> >  
> > @@ -562,13 +560,27 @@ static int __init rtas_init(void)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	start_event_scan();
> > +
> > +	return 0;
> > +}
> > +arch_initcall(rtas_event_scan_init);
> > +
> > +static int __init rtas_init(void)
> > +{
> > +	struct proc_dir_entry *entry;
> > +
> > +	if (!machine_is(pseries) && !machine_is(chrp))
> > +		return 0;
> > +
> > +	if (!rtas_log_buf)
> > +		return -ENODEV;
> > +
> >  	entry = proc_create("powerpc/rtas/error_log", S_IRUSR, NULL,
> >  			    &proc_rtas_log_operations);
> >  	if (!entry)
> >  		printk(KERN_ERR "Failed to create error_log proc entry\n");
> >  
> > -	start_event_scan();
> > -
> >  	return 0;
> >  }
> >  __initcall(rtas_init);
> > 
> >   
> 
> 
