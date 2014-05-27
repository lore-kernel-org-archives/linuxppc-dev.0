Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072A1A05CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 06:31:09 +1000 (EST)
Message-ID: <1401222649.20915.83.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 May 2014 06:30:49 +1000
In-Reply-To: <1401214527.3289.611.camel@ul30vt.home>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-27 at 12:15 -0600, Alex Williamson wrote:

> > +/*
> > + * Reset is the major step to recover problematic PE. The following
> > + * command helps on that.
> > + */
> > +struct vfio_eeh_pe_reset {
> > +	__u32 argsz;
> > +	__u32 flags;
> > +	__u32 option;
> > +#define VFIO_EEH_PE_RESET_DEACTIVATE	0	/* Deactivate reset	*/
> > +#define VFIO_EEH_PE_RESET_HOT		1	/* Hot reset		*/
> > +#define VFIO_EEH_PE_RESET_FUNDAMENTAL	3	/* Fundamental reset	*/
> 
> How does a user know which of these to use?

The usual way is the driver asks for one or the other, this plumbs back
into the guest EEH code which itself plumbs into the PCIe error recovery
framework in Linux.

However I do have a question for Gavin here: Why do we expose an
explicit "deactivate" ? The reset functions should do the whole
reset sequence (assertion, delay, deassertion). In fact the firmware
doesn't really give you a choice for PERST right ? Or do we have
a requirement to expose both phases for RTAS? (In that case I'm
happy to ignore the deassertion there too).

Cheers,
Ben.
