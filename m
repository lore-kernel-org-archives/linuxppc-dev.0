Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 13DFA2C0316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 13:56:17 +1000 (EST)
Message-ID: <1373601363.19894.134.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 12 Jul 2013 13:56:03 +1000
In-Reply-To: <20130712020749.GA32154@pek-khao-d1.corp.ad.wrs.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-3-git-send-email-haokexin@gmail.com>
 <1373546721.19894.90.camel@pasglop>
 <20130712020749.GA32154@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-12 at 10:07 +0800, Kevin Hao wrote:
> There are two invocations of do_mathemu() in the traps.c. The one in the
> function program_check_exception() doesn't call the PPC_WARN_EMULATED.
> This is also the one I try to fix. Of course my patch will definitely corrupt
> the one in function SoftwareEmulation(). I will respin a new patch to
> fix this. Sorry for my mistake.

Put the call in the caller (in program_check_exception). It keeps the code
in math-emu simpler and is consistent with what we do elsewhere.

Cheers,
Ben.
