Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A1E3DE026
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 05:31:46 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TJVhBQ028659
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:31:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TJVhhH473072
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:31:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TJVgfq024613
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:31:43 -0400
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 29 May 2007 14:29:39 -0500
Message-Id: <1180466979.3360.69.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 16:49 +0200, Segher Boessenkool wrote:
> >>> +			compatible = "tsi-mdio";
> >>
> >> Hrm, did I miss this before?  A more exact "compatible"
> >> property would be better ("tsi109-mdio" "tsi108-mdio" or
> >> something like that).
> >
> > If we must, then tsi108-mdio is what I would recommend.  They are the
> > same between 108, 109, and 110 as far as I know, so it's the lowest
> > common denominator.
> 
> [Assuming what is really on the board is a tsi109...]

For Holly, yes.  For Taiga, it's 108.  For Hackberry, it's 110.

> I recommend putting both 109 and 108 in the property, in
> that order; that way, if you need to do something special
> on the tsi109 implementation (something you might not yet
> know about perhaps, maybe a bug; or some extra feature on
> the tsi109 device that the driver doesn't handle yet), the
> driver has a chance to do that.  If the driver doesn't care
> and only uses tsi108 features, it obviously can probe for
> tsi108 only and all will be fine as well.

*shrug*  Either way works for me.

We're adding these compatible properties to DTS files and the drivers at
the same time.  Unless (until?) there are firmwares for these boards
that start specifying something else in a real device tree, it really
doesn't matter much.  Not that there's anything wrong with your
reasoning.  Just seems like we're trying really hard to define something
"correctly" when we control what's on both sides :).

josh
