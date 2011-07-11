Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D3EBB6F54
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 07:06:54 +1000 (EST)
Date: Mon, 11 Jul 2011 16:06:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: RFC: top level compatibles for virtual platforms
Message-ID: <20110711160646.291e977e@schlenkerla.am.freescale.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150316FF6B@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
	<4E1B1AAB.8010301@freescale.com>
	<20110711112418.4db9f41e@schlenkerla.am.freescale.net>
	<9F6FE96B71CF29479FF1CDC8046E150316FBA5@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110711130430.4b3036f6@schlenkerla.am.freescale.net>
	<9F6FE96B71CF29479FF1CDC8046E150316FF6B@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Jul 2011 15:41:35 -0500
Yoder Stuart-B08248 <B08248@freescale.com> wrote:

> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Monday, July 11, 2011 1:05 PM
> > 
> > Just because Linux does it that way now doesn't mean it needs to.  The interrupt controller
> > has a compatible property.  Match on it like any other device.  You can find which one is the
> > root interrupt controller by looking for nodes with the interrupt-controller property that
> > doesn't have an explicit interrupt-parent (or an interrupts property?  seems to be a conflict
> > between ePAPR and the original interrupt mapping document).
> 
> This may be the right long term thing to do, but restructuring
> how Linux powerpc platforms work is a bigger effort.  I was looking
> for an incremental improvement over what we do now, which is pass
> a compatible of MPC8544DS and P4080DS for these virtual platforms.

A hack is usually easier than doing it right. :-)

Though often the effort required for the latter is overstated, and the
"right long term thing" never makes the jump to "short term plan".

There are a few things that need to be driven off the device tree that
currently aren't -- using some mechanism other than the standard
device model, if necessary (or as a first step) -- and then we need a
does-nothing default platform as the match of last resort.

> However, they _are_ compatible with MPC8544DS and P4080DS so maybe
> leaving the compatible string alone is ok for now.

The virtual platforms are not compatible with MPC8544DS or P4080DS.  Only a
subset of what is on those boards is provided.  And in the case of direct
device assignment, often the things that are present are incompatible (e.g.
different type of eTSEC).

-Scott
