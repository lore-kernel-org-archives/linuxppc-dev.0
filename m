Return-Path: <ken.kawakami@toshiba.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DD8EFB7C2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 14:22:11 +1000 (EST)
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id 83ECCDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 14:22:11 +1000 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id n6M4M9Mi010105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 13:22:10 +0900 (JST)
Received: from arc11.toshiba.co.jp ([133.199.90.127])
	by imx12.toshiba.co.jp  with ESMTP id n6M4M5d5018369
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 13:22:05 +0900 (JST)
Received: (from root@localhost) by arc11.toshiba.co.jp  id n6M4M5G5021745
	for linuxppc-dev@ozlabs.org; Wed, 22 Jul 2009 13:22:05 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id n6M4M4vJ002490
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 13:22:04 +0900 (JST)
Date: Wed, 22 Jul 2009 13:22:02 +0900 (JST)
Message-Id: <20090722.132202.783373790.kk@toshiba.co.jp>
To: roel.kluin@gmail.com
Subject: Re: [PATCH] powerpc/cell: replace strncpy by strlcpy
From: Ken Kawakami <ken.kawakami@toshiba.co.jp>
In-Reply-To: <4A6595AD.9000209@gmail.com>
References: <4A607185.6020302@gmail.com>
	<4A6595AD.9000209@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, cbe-oss-dev@ozlabs.org,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd-san, Roel-san,

It works fine. Thanks.

---
Regards,
Ken Kawakami

> Replace strncpy() and explicit null-termination by strlcpy()
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Arnd-san, Ken-san,
> 
> Thanks for reviewing,
> 
> > We prefer to take the patch which is replacing the two lines with one.
> 
> Doozo.
> 
> diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
> index 07c234f..e538455 100644
> --- a/arch/powerpc/platforms/cell/celleb_setup.c
> +++ b/arch/powerpc/platforms/cell/celleb_setup.c
> @@ -80,8 +80,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
>  
>  static int __init celleb_machine_type_hack(char *ptr)
>  {
> -	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> -	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
> +	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
>  	return 0;
>  }
>  
> 
