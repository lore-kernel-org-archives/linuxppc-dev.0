Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61AFD1A0775
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 19:23:05 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E44441402A9
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 19:23:04 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org,  mikey@neuling.org,  imunsie@au.ibm.com
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
References: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
Date: Fri, 31 Jul 2015 11:16:52 +0200
In-Reply-To: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
 (Daniel Axtens's message of "Fri, 31 Jul 2015 16:35:08 +1000")
Message-ID: <87wpxg3cvv.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:

> Every time I build cxl I see the following warnings:
>
> /scratch/dja/linux-capi/drivers/misc/cxl/pci.c: In function ‘sanitise_afu_regs’:
> /scratch/dja/linux-capi/drivers/misc/cxl/pci.c:712:6: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
>    if (reg & CXL_PSL_DSISR_TRANS)
>       ^
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c: In function ‘fail_psl_irq’:
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:184:5: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
>   if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
>      ^

Why are they ambigous?  Why doesn't cxl_p2n_write(afu, CXL_PSL_TFC_An,
CXL_PSL_TFC_An_AE) expand to a proper statement?

#define cxl_p2n_write(afu, reg, val) \
	out_be64(_cxl_p2n_addr(afu, reg), val)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
