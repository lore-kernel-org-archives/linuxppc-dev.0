Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E54DC2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 06:30:53 +1100 (EST)
Message-ID: <1394825397.12479.75.camel@snotra.buserror.net>
Subject: Re: [PATCH 06/10] powerpc/booke64: Use SPRG_TLB_EXFRAME on bolted
 handlers
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Mar 2014 14:29:57 -0500
In-Reply-To: <1394755249-8856-7-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
 <1394755249-8856-7-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-13 at 19:00 -0500, Scott Wood wrote:
> @@ -444,6 +451,9 @@ _GLOBAL(kvmppc_resume_host)
>  	PPC_STD(r8, VCPU_SHARED_SPRG6, r11)
>  	mfxer	r3
>  	PPC_STD(r9, VCPU_SHARED_SPRG7, r11)
> +#ifdef CONFIG_64BIT
> +	mtspr	SPRN_SPRG_VDSO_WRITE, r3
> +#endif

Oops, this hunk was a patch shuffling accident.  v2 coming.

-Scott
