Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3F76DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:12:28 +1000 (EST)
In-Reply-To: <20070529032924.GA30266@localhost.localdomain>
References: <20070529032924.GA30266@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d35e07648ef5813bd9e3572eec36bfb3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Don't use HOSTCFLAGS in BOOTCFLAGS
Date: Tue, 29 May 2007 07:12:21 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  #	To this end we need to define BOOTCC, etc, as the tools
> -#	needed to build the 32 bit image.  These are normally HOSTCC,
> +#	needed to build the 32 bit image.
>  #	but may be a third compiler if, for example, you are cross

You've broken this comment, you should pay for it now :-)

> -HOSTCC		:= gcc
> -BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -fno-unit-at-a-time 
> -nostdinc -isystem \
> -		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
> +BOOTCFLAGS	:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> +		   -fno-strict-aliasing -O2 -msoft-float -pipe \

-Os instead?

> +		   -fomit-frame-pointer -fno-builtin -fno-unit-at-a-time \

Why -fno-unit-at-a-time ?

> +		   -fPIC -nostdinc \
> +		   -isystem $(shell $(CROSS32CC) -print-file-name=include)

Also, is there any reason why you can't simply use $(CC) -m32 with
the kernel $(CFLAGS) ?


Segher
