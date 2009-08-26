Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 31F5FB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 05:20:52 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD833DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 05:20:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7QJKWsf022343
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 12:20:42 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n7QJLYaG022013
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 14:21:35 -0500 (CDT)
Date: Wed, 26 Aug 2009 14:20:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Can't write value into memory ?(E500 V2)
Message-ID: <20090826192030.GA17027@b07421-ec1.am.freescale.net>
References: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 26, 2009 at 10:39:24PM +0800, wilbur.chan wrote:
> In  an assemblely code ,   I invalided all the TLB entries except for
> the entry  we are executed in.
> 
> After that , I setuped a 1:1 TLB entry mapping of 1GB .

What is it you're trying to do?

> At last , I wrote value 30 into the physical address 0x0400,0000 (also
> the virtual address because of my 1:1 mapping).
> 
> However, it seemed failed to store the value '30' at address
> 0x400,0000. The following is my code:
> 
> //code start
> 
> // setup a 1:1 mapping of 1GB
> ...

"..." is not code. :-)

> //store '30' into address 0x0400,0000
> 
> li  r23, 30
> lis r22, 0x400
> ori r22,r22,0x0
> stb  r23,0(r22)
> 
> 
> //check if we successfully store value at 0x400,0000
> 
> lis r22, 0x400
> ori r22,r22,0x0
> lwz r23,0(r22)
> cmpw r23, 30

The values should not be equal, since you wrote a byte and read back a
word.

Furthermore, you are storing the constant 30, but are comparing r23 with
the register r30 (I never liked that aspect of ppc asm syntax -- too
error prone).  If you want to compare with the constant 30, use "cmpwi".

> beq  print_equal
> 
> 1: b 1b
> 
> print_equal:
>  ...
> //code end
> 
> I found that, print_equal was not called ,the whole code seemed  to
> enter an  infinite loop.

That's because you have an infinite loop in your code, right after "beq
print_equal".

-Scott
