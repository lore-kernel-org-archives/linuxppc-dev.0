Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CBCEDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 03:02:21 +1100 (EST)
In-Reply-To: <45DB1759.2010302@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com> <45DB1759.2010302@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Date: Tue, 20 Feb 2007 17:02:11 +0100
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +ps3)
> +    platformo="$object/head.o $object/ps3-hvcall.o $object/ps3.o"
> +    ;;
>
> Having those vectors makes a 4MB dead gap in the binary image.  The 
> ps3's
> loader supports a gziped image so there is no problem, but for the 
> general
> case of binary images, there is no way we can have those always in 
> there.

If this is an ELF file, you can put the exception vectors in a
separate segment.  Or if you don't need the entry point to
be in the low region, (and you don't need that unless your
boot loader ignores the entry point in the ELF header), you can
copy the vectors in at startup and have no code linked at 0 at
all.


Segher
