Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E095DDE2D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 03:45:52 +1000 (EST)
Message-ID: <46AA2F48.3020702@freescale.com>
Date: Fri, 27 Jul 2007 12:45:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pq2fads support...
References: <op.tv4h01apnhx3hy@phoenix>
	<20070727163529.GA26893@ld0162-tx32.am.freescale.net>
	<op.tv4vfiaunhx3hy@phoenix>
In-Reply-To: <op.tv4vfiaunhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> Thanks for your reply, Scott,
> 
> one question though: I am NOT using the bootwrapper, I'm instead 
> feeding  dtb and uImage directly to u-boot. This probably means that
> I should fill  in lots of stuff manually into dts, right?

No, u-boot should fill in the same stuff.  It may require the empty
fields to be there, though (it definitely requires it if you're using
the old, non-libfdt code -- if you are, you should also remove the 
/chosen node, or else you'll get two of them).

> But, (and please forgive my  ignorance) who does actually fill in
> stuff (like e.g. clock-frequency or  bus-frequency), except, of
> course, from the trivial modifications u-boot  does to dtb? The
> wrapper script seems to do nothing more that simply  running dtc on
> dts.

In the bootwrapper case, it's the code in cuboot-pq2.c and devtree.c. 
In the no-bootwrapper case, it's u-boot.

-Scott
