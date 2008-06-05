Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8B05DDFA8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 10:00:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5600Ce9013366
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 20:00:12 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m5600CDG165682
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 20:00:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5600BgC004211
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 20:00:12 -0400
Date: Thu, 5 Jun 2008 18:59:48 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605185948.3847436d@zod.rchland.ibm.com>
In-Reply-To: <48480B3C.9080101@freescale.com>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de> <4848036D.5060004@freescale.com>
	<484809D1.2070300@scram.de> <48480B3C.9080101@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Scott, Sean MacLennan <smaclennan@pikatech.com>,
	Wood <scottwood@freescale.com>,
	Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Jun 2008 10:50:20 -0500
Timur Tabi <timur@freescale.com> wrote:

> Jochen Friedrich wrote:
> > Hi Timur,
> > 
> >> In situations where it doesn't matter which I2C bus is #1 and which one is #2,
> >> then I think the code should just initialize idx based on the order the nodes
> >> are found in the tree.
> >>
> >> In situations where it does matter, then we should use cell-index.
> > 
> > that's what I did in i2c-cpm, as well. However, here I use the property
> > "linux,i2c-index" instead (see http://patchwork.ozlabs.org/linuxppc/patch?id=18603).
> 
> Well, I just don't see the point of having two different properties that say the
> same thing.  I'm not an IEE 1275 purist, so I don't think we should be hampered
> by old node definitions.  I especially don't like having a property specifically
> for indexing I2C nodes that can't be used to enumerate other nodes.

It's not about purity.  It's about overloading something that has
existing semantics just because you have one usecase that you _think_
needs it.

If everyone did that, this whole device tree concept is going to just
be one big cluster f*ck.  Get over it, fix your driver to use the
device model and aliases propertly, and move on.

josh
