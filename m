Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B502DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 10:17:29 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3GNGU6F009993
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Apr 2007 19:16:30 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3H0HMjZ518438
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Apr 2007 20:17:22 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3H0H6H3025140
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Apr 2007 20:17:06 -0400
Date: Mon, 16 Apr 2007 19:24:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: PROBLEM: kernel 2.6.20.6 build failed for ppc board chestnut(ibm
	ppc 750GX/FX)
Message-ID: <20070417002402.GB23995@crusty.rchland.ibm.com>
References: <200704161313.04359.wangbj@lzu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704161313.04359.wangbj@lzu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2007 at 01:13:01PM +0800, Wang, Baojun wrote:
> PROBLEM: linux kernel 2.6.20.6 build failed for ppc board chestnut(ibm ppc 
> 750GX/FX)
> 

Confirmed.  arch/ppc isn't getting much love these days.

<snip>

> this brute force patch sould solve the problem:

This is missing a Signed-off-by: line.

> diff -Nru /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c \  
> linux-2.6.20.6/arch/ppc/platforms/chestnut.c
> 
> --- /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c   2007-04-07 
> 04:02:48.000000000 +0800
> +++ linux-2.6.20.6/arch/ppc/platforms/chestnut.c        2007-04-13 
> 17:09:03.000000000 +0800
> @@ -432,7 +432,9 @@
>         ptbl.name = "User FS";
>         ptbl.size = CHESTNUT_32BIT_SIZE;
> 
> -       physmap_map.size = CHESTNUT_32BIT_SIZE;
> +       // physmap_map.size = CHESTNUT_32BIT_SIZE;

Just remove this completely.  It's not needed any longer.

> +       physmap_configure(CHESTNUT_32BIT_BASE, CHESTNUT_32BIT_SIZE, 
> CONFIG_MTD_PHYSMAP_BANKWIDTH, NULL);

Technically, this call isn't needed.  The chestnut_defconfig already provides
the correct variables.

josh
