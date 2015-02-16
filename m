Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.182])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CA521A0FC9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 01:20:18 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Markus Stockhausen' <stockhausen@collogia.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v1 2/7] AES for PPC/SPE - aes tables
Date: Mon, 16 Feb 2015 14:19:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAE46B2@AcuExch.aculab.com>
References: <cfb098e9-69ae-47ff-afa7-08c922accd31@EXCHANGE.collogia.de>
In-Reply-To: <cfb098e9-69ae-47ff-afa7-08c922accd31@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From:  Markus Stockhausen
> 4K AES tables for big endian

I can't help feeling that you could give more information about how the
values are generated.

...
> + * These big endian AES encryption/decryption tables are designed to be =
simply
> + * accessed by a combination of rlwimi/lwz instructions with a minimum
> + * of table registers (usually only one required). Thus they are aligned=
 to
> + * 4K. The locality of rotated values is derived from the reduced offset=
s that
> + * are available in the SPE load instructions. E.g. evldw, evlwwsplat, .=
..
> + *
> + */
> +.data
> +.align 12
> +.globl PPC_AES_4K_ENCTAB
> +PPC_AES_4K_ENCTAB:
> +	.long 0xc66363a5,0xa5c66363,0x63a5c663,0x6363a5c6

These seem to be byte rotates (all down the table).
If so then use a CPP define to generate the rotated values.

I'd like to see a reference to where the values themselves come from.

> +	.long 0xf87c7c84,0x84f87c7c,0x7c84f87c,0x7c7c84f8
...
> +	.long 0x6dbbbbd6,0xd66dbbbb,0xbbd66dbb,0xbbbbd66d
> +	.long 0x2c16163a,0x3a2c1616,0x163a2c16,0x16163a2c
> +.globl PPC_AES_4K_DECTAB
> +PPC_AES_4K_DECTAB:
> +	.long 0x51f4a750,0x5051f4a7,0xa75051f4,0xf4a75051
...
> +	.long 0xd0b85742,0x42d0b857,0x5742d0b8,0xb85742d0

Some explanation of this third dataset is also needed.

> +	.byte 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38
...
> +	.byte 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d

	David
