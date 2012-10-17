Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 562302C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 23:07:17 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 2/2] PPC_BOOK3E/KGDB: support kgdb kernel space
References: <1350471011-2478-1-git-send-email-tiejun.chen@windriver.com>
 <1350471011-2478-2-git-send-email-tiejun.chen__24766.2045098425$1350471081$gmane$org@windriver.com>
Date: Wed, 17 Oct 2012 14:07:07 +0200
In-Reply-To: <1350471011-2478-2-git-send-email-tiejun.chen__24766.2045098425$1350471081$gmane$org@windriver.com>
 (Tiejun Chen's message of "Wed, 17 Oct 2012 18:50:11 +0800")
Message-ID: <m28vb5s3o4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tiejun Chen <tiejun.chen@windriver.com> writes:

> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4684e33..ed5862d 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -539,11 +539,15 @@ kernel_dbg_exc:
>  	rfdi
>  
>  	/* Normal debug exception */
> +#ifndef CONFIG_KGDB
>  	/* XXX We only handle coming from userspace for now since we can't
>  	 *     quite save properly an interrupted kernel state yet
>  	 */
>  1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
>  	beq	kernel_dbg_exc;		/* if from kernel mode */
> +#else
> +1:
> +#endif

You could move the label before the conditional.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
