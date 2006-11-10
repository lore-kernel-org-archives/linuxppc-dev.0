Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F00C267D78
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 20:58:56 +1100 (EST)
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17748.19234.278295.476881@cargo.ozlabs.ibm.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<4553436D.30601@shadowen.org>
	<1163112227.4982.44.camel@localhost.localdomain>
	<17748.19234.278295.476881@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 20:58:44 +1100
Message-Id: <1163152724.4982.159.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Steve Fox <drfickle@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-10 at 20:49 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > > Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
> > > default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
> > > occured by default on my config then we end up with two module_init()
> > > calls, which is illegal.
> > > 
> > >   powerpc-add-of_platform-support-for-ohci-bigendian-hc
> > > 
> > > I am guessing that we are only meant to be able to have one of these
> > > defined at a time?  I changed the default to n for this and I could at
> > > least compile the kernel, but I am sure thats not the right fix.
> > 
> > Paul, which patch did you merge ? I rejected the initial one that was
> > doing 2 drivers/probe routines and Nicolas did a new one.. You may have
> > taken the wrong one.
> 
> I didn't merge either of them.

Ah, must be Andrew then. Andrew, can you drop this (along with the other
Efika/MPC5200) patches from -mm ? They'll get in via the powerpc merge
and I'll make sure Paulus gets the right versions.

Cheers,
Ben.
