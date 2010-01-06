Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2F02B6EF3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 07:53:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o06KrNTX022715
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 13:53:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o06KxSwS022250
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 14:59:28 -0600 (CST)
Message-ID: <4B44F7D2.4050909@freescale.com>
Date: Wed, 06 Jan 2010 14:51:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 6/8] fsldma: simplify IRQ probing and handling
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<1262326246-936-7-git-send-email-iws@ovro.caltech.edu>
	<20100106180226.GA27146@loki.buserror.net>
	<20100106183951.GC26426@ovro.caltech.edu>
In-Reply-To: <20100106183951.GC26426@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	dan.j.williams@intel.com, Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> I don't think this would break any existing hardware. The 83xx all
> shares one IRQ line, and the 85xx/86xx only have per-channel interrupts,
> right? (I'm not an 85xx/86xx guy, I've only got 83xx experience). This
> is what the device trees suggest, anyway.

Right.

>> It looks like the other problem is that the controller interrupt handler
>> is assuming only one bit will be set in the summary register.  It should
>> call the channel handler for each bit that is set.
>>
> 
> Ok. I thought about doing this, but my changed approach seemed easier.
> 
> On the 83xx, we should only need to call the per-channel handler once
> for each group of 8 bits. The original code used ffs(), which seems a
> little wrong. Why call the handler twice if both EOSI and EOCDI are set
> for a channel?

Sorry, I meant call it once per channel that has bits set.

> Should I use a loop + mask, or is there some other neat
> trick I can use?

After you process one channel, it shouldn't have any bits set (and if it 
does, it's a new event that needs to be processed), so you could use the 
current ffs approach with a while (summary reg != 0) loop around it.

> Ok. All of the in-tree 83xx device trees have 5 interrupts listed. With
> the changes described above, we'll only call request_irq() once in that
> case, and use the per-controller interrupt.
> 
> I'll leave the documentation alone, with the exception of marking the
> per-controller interrupt optional.

Hmm, that description is specific to 83xx, and such chips really should 
have the controller interrupt specified.  The per-channel interrupt 
should not be optional, though.

-Scott
