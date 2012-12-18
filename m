Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C5B82C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 09:10:18 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/3] powerpc/book3e: load critical/machine/debug
 exception stack
Date: Tue, 18 Dec 2012 22:10:01 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7081D305D@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1351147410-17452-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1351147410-17452-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 25, 2012 at 1:43 AM, Tiejun Chen <tiejun.chen@windriver.com> wr=
ote:
> We always alloc critical/machine/debug check exceptions. This is
> different from the normal exception. So we should load these exception
> stack properly like we did for booke.

Tiejun,

I'm a little confused by these patches, because the actual critical
exception handlers are still commented out:

/* Critical Input Interrupt */
	START_EXCEPTION(critical_input);
	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
			      PROLOG_ADDITION_NONE)
//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
//	bl	special_reg_save_crit
//	CHECK_NAPPING();
//	addi	r3,r1,STACK_FRAME_OVERHEAD
//	bl	.critical_exception
//	b	ret_from_crit_except
	b	.

Are you working on fixing this?  I'm trying to fix it, too, but I
think you're way ahead of me.

--=20
Timur Tabi
Linux kernel developer at Freescale=
