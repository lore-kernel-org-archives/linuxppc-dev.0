Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 63B1DB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 00:19:00 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20744-03 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  7 Mar 2012 13:18:55 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] powerpc/srio: Fix the compile errors when building
 with 64bit
Date: Wed, 7 Mar 2012 13:18:01 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E91@saturn3.aculab.com>
In-Reply-To: <1331124924-18838-1-git-send-email-Gang.Liu@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Liu Gang" <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <Alexandre.Bounine@idt.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>, r61911@freescale.com,
 linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
 akpm@linux-foundation.org, r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/sysdev/fsl_rmu.c
b/arch/powerpc/sysdev/fsl_rmu.c
> index 1548578..1bba6d1 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c

> @@ -657,7 +658,8 @@ fsl_add_outb_message(struct rio_mport=20
> *mport, struct rio_dev *rdev, int mbox,
>  	int ret =3D 0;
> =20
>  	pr_debug("RIO: fsl_add_outb_message(): destid %4.4x mbox %d
buffer " \
> -		 "%8.8x len %8.8x\n", rdev->destid, mbox, (int)buffer,
len);
> +		 "%8.8lx len %8.8zx\n", rdev->destid, mbox,
> +		(unsigned long)buffer, len);

Should 'buffer' be printed with %p ??

	David
