Return-Path: <RA8135@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D27BA2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 02:42:52 +1100 (EST)
Date: Fri, 25 Oct 2013 10:25:26 -0500
From: James Yang <James.Yang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
In-Reply-To: <1382697373.3926.36.camel@aoeu.buserror.net>
Message-ID: <alpine.LRH.2.00.1310251020590.31001@ra8135-ec1.am.freescale.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <1382697373.3926.36.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 25 Oct 2013, Scott Wood wrote:

> Has anyone measured how much this slows things down with a typical
> userspace?

Not a measurement of the patch in question but an older similar patch 
on 3.0.51 (8572 running Debian 5.0.3):

$ ./test-lwsync 
cycles per emulated lwsync = 371
cycles per sync = 36

----------------------------------------------------------
#include <stdio.h>

int main (void) {
        unsigned long atb_start, atb_stop;
        unsigned long i;

        asm volatile ("mfspr %0,526" : "=r" (atb_start));
        for (i = 0; i < 100; i++) {
                asm volatile ("lwsync");
        }
        asm volatile ("mfspr %0,526" : "=r" (atb_stop));
        printf("cycles per emulated lwsync = %lu\n", (atb_stop - 
atb_start) / 100);

        asm volatile ("mfspr %0,526" : "=r" (atb_start));
        for (i = 0; i < 100; i++) {
                asm volatile ("sync");
        }
        asm volatile ("mfspr %0,526" : "=r" (atb_stop));

        printf("cycles per sync = %lu\n", (atb_stop - atb_start) / 
100);

        return 0;
}
----------------------------------------------------------
