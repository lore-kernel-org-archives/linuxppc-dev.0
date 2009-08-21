Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9AE7B7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 18:02:37 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C2C5DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 18:02:36 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC
	driver.
Date: Fri, 21 Aug 2009 10:02:15 +0200
References: <1250813957-1786-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1250813957-1786-1-git-send-email-fkan@amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908211002.15178.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 August 2009 02:19:17 Feng Kan wrote:
> Fix ECC Correction bug where the byte offset location were double
> fliped causing correction routine to toggle the wrong byte location
> in the ECC segment. The ndfc_calculate_ecc routine change the order
> of getting the ECC code.
>         /* The NDFC uses Smart Media (SMC) bytes order */
>         ecc_code[0] = p[2];
>         ecc_code[1] = p[1];
>         ecc_code[2] = p[3];
> But in the Correction algorithm when calculating the byte offset
> location, the b1 is used as the upper part of the address. Which
> again reverse the order making the final byte offset address
> location incorrect.
> 	byte_addr = (addressbits[b1] << 4) + addressbits[b0];
> The order is change to read it in straight and let the correction
> function to revert it to SMC order.
>
> Signed-off-by: Feng Kan <fkan@amcc.com>
> Acked-by: Victor Gallardo <vgallardo@amcc.com>
> Acked-by: Prodyut Hazarika <phazarika@amcc.com>

Acked-by: Stefan Roese <sr@denx.de>

Would be great if we could get this fix into 2.6.31.

Cheers,
Stefan
