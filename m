Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0214DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 09:48:44 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1BMmeoL013000
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 15:48:40 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1BMmdAE020153
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:48:40 -0600 (CST)
Date: Wed, 11 Feb 2009 16:48:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: request_irq return errno 38
Message-ID: <20090211224839.GA13498@ld0162-tx32.am.freescale.net>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
	<f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 11, 2009 at 03:43:26PM +0530, Vijay Nikam wrote:
> Ok ... so that means if I am writing driver for any device I need to
> take care of this mapping ? ? ? I mean I should use virq ? ? ?
> 
> I read in LDD book,

The problem with dead-tree books on a volatile subject is they quickly
get out of date.

> they give directly irq no. they have given parallel port example, here
> they have set or said irq no. defaults to 7 and they have not done any
> irq_mapping so what is the difference ? ? ? I mean how I should know
> when to use irq_mapping and when not ? ? ?

That's for legacy ISA interrupts.  On powerpc, you generally will want to
get the interrupt from the device tree using irq_of_parse_and_map().

-Scott
