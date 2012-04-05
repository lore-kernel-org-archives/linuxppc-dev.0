Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E6A6BB706D
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2012 07:38:06 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/12] powerpc: Rework runlatch code
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
Date: Thu, 05 Apr 2012 23:38:01 +0200
In-Reply-To: <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
 (Benjamin Herrenschmidt's message of "Fri, 2 Mar 2012 20:35:13 +1100")
Message-ID: <m2vcldamh2.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This moves the inlines into system.h and changes the runlatch
> code to use the thread local flags (non-atomic) rather than
> the TIF flags (atomic) to keep track of the latch state.
>
> The code to turn it back on in an asynchronous interrupt is
> now simplified and partially inlined.

This breaks the X server in that it no longer receives SIGIO signals.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
