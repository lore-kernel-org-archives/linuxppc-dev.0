Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 437D4DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:46:21 +1000 (EST)
In-Reply-To: <1179190345.3420.74.camel@zod.rchland.ibm.com>
References: <1179190345.3420.74.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12e512c4202fd5a407db5b4156f3ea56@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add -msoft-float to BOOTCFLAGS
Date: Tue, 15 May 2007 06:46:11 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  HOSTCC		:= gcc
>  BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
> -		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
> +		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC -msoft-float
>  BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc

While you're at it, could you get rid of the HOSTCFLAGS
inclusion here?  The host compiler has absolutely nothing
to do with the 32-bit powerpc compiler.

There are some more flags you might want to add btw
(-nostdlib, -mno-multiple, stuff like that -- just examples,
don't blindly add these).


Segher
