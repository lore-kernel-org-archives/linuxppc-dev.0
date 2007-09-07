Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A241DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 11:04:54 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8714ukT009176
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:04:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8714riY4419680
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:04:53 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8714rNH030485
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 11:04:53 +1000
Date: Fri, 7 Sep 2007 11:04:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding
Message-ID: <20070907010449.GL26079@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
	<143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
	<20070905025907.GG17189@localhost.localdomain>
	<a8b4282d0c58f1090c64591d387dae97@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a8b4282d0c58f1090c64591d387dae97@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 03:28:35PM +0200, Segher Boessenkool wrote:
> >>> +     - bank-width : Width (in bytes) of the flash bank.  Equal to 
> >>> the
> >>> +       device width times the number of interleaved chips.
> >>> +     - device-width : (optional) Width of a single flash chip.  If
> >>> +       omitted, assumed to be equal to 'bank-width'.
> >>
> >> Let's have bank-width optional instead, it's more natural
> >> that way for the common case of just one chip.  Or, you can
> >> say that either is optional.
> >
> > No, I'm disinclined to do that since bank-width is the primary bit of
> > information that the driver needs.
> 
> Bzzzzt.  That's not what the device tree is about; it should
> describe the hardware, it shouldn't be just a config file for
> the current Linux drivers.

Yes, yes, so you've said many times.

But where there are multiple ways of encoding exactly the same
information, I don't see that we can't use driver convenience as a
deciding factor.

> Besides, like I said, for the common case where your flash
> chips aren't interleaved, it makes way more sense to talk
> about device-width than it does to call it bank-width.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
