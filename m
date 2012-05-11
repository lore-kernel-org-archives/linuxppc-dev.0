Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 628ABB7010
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 03:06:07 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 May 2012 13:06:03 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A87DE38C806A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 13:06:00 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4BH5soe16121936
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 13:05:54 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4BMajl4018628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 18:36:46 -0400
Date: Fri, 11 May 2012 10:04:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/irq: Fix another case of lazy IRQ state
 getting out of sync
Message-ID: <20120511170439.GA19856@us.ibm.com>
References: <20120511002354.GA8895@us.ibm.com>
 <1336696621.3881.72.camel@pasglop>
 <1336702358.3881.77.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336702358.3881.77.camel@pasglop>
Cc: Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Wang Sheng-Hui <shhuiw@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt [benh@kernel.crashing.org] wrote:
| So we have another case of paca->irq_happened getting out of
| sync with the HW irq state. This can happen when a perfmon
| interrupt occurs while soft disabled, as it will return to a
| soft disabled but hard enabled context while leaving a stale
| PACA_IRQ_HARD_DIS flag set.
| 
| This patch fixes it, and also adds a test for the condition
| of those flags being out of sync in arch_local_irq_restore()
| when CONFIG_TRACE_IRQFLAGS is enabled.
| 
| This helps catching those gremlins faster (and so far I
| can't seem see any anymore, so that's good news).
| 
| Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
| ---
| 
| Please test ASAP as I need to send that to Linus today

Works for me. I was able to run my script over a 100 times. Without
the patch, it fails reliably first or second attempt.

Thanks for fixing it quickly.

Sukadev
