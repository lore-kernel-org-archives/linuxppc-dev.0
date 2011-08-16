Return-Path: <dedekind1@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3465B6F72
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 01:05:00 +1000 (EST)
Received: by qwi4 with SMTP id 4so3090458qwi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 08:04:56 -0700 (PDT)
Subject: Re: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j
	command
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Tue, 16 Aug 2011 18:06:35 +0300
In-Reply-To: <1312350638-25566-1-git-send-email-b35362@freescale.com>
References: <1312350638-25566-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313507201.2679.2.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@linux.freescale.net, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-08-03 at 13:50 +0800, b35362@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> Flash_erase -j should fill discrete freeoob areas with required bytes
> of JFFS2 cleanmarker in jffs2_check_nand_cleanmarker(). Not just fill
> the first freeoob area.
> 
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

...

>  	/*
>  	 * Process user arguments
> @@ -197,15 +198,40 @@ int main(int argc, char *argv[])
>  			if (ioctl(fd, MEMGETOOBSEL, &oobinfo) != 0)
>  				return sys_errmsg("%s: unable to get NAND oobinfo", mtd_device);
>  
> +			cleanmarker.totlen = cpu_to_je32(8);
>  			/* Check for autoplacement */
>  			if (oobinfo.useecc == MTD_NANDECC_AUTOPLACE) {
> +				struct nand_ecclayout_user ecclayout;
>  				/* Get the position of the free bytes */
> -				if (!oobinfo.oobfree[0][1])
> +				if (ioctl(fd, ECCGETLAYOUT, &ecclayout) != 0)
> +					return sys_errmsg("%s: unable to get NAND ecclayout", mtd_device);
> +

Hmm, shouldn't we instead make MTD_OOB_AUTO be available for userspace
via an ioctl instead and make flash_eraseall use it instead?

-- 
Best Regards,
Artem Bityutskiy
