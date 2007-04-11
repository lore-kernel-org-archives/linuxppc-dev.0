Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08BEDDDF1B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 08:22:16 +1000 (EST)
Subject: Re: [RFC 1/3] cryptoapi: AES with AltiVec support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
In-Reply-To: <20070411165702.256910000@linux.vnet.ibm.com>>
References: <20070411164910.657151000@linux.vnet.ibm.com> >
	<20070411165702.256910000@linux.vnet.ibm.com>>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 08:22:06 +1000
Message-Id: <1176330126.8061.110.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> ==================================================================
> --- ps3-linux.orig/crypto/Makefile
> +++ ps3-linux/crypto/Makefile
> @@ -48,3 +48,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
>  obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
>  
>  obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
> +
> +CFLAGS_aes-altivec.o += -O3  -maltivec -mcpu=cell
> +aes_altivec-objs := aes-alti.o aes-altivec.o
> +obj-$(CONFIG_CRYPTO_AES_ALTIVEC) += aes_altivec.o

Ideally (and I know the RAID6 code isnt doing it), the
code that contains enable_kernel_altivec/disable_kernel_altivec should
-not- itself be compiled with -malitvec. You don't want the compiler to
"inadvertently" generate altivec instructions outside of those calls (in
the function prolog for example).

I noticed quite a bit of memcpy's around too... see if you can limit
usage of these.

Ben.
