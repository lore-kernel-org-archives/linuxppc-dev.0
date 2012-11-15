Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F9592C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 12:03:42 +1100 (EST)
Message-ID: <1352941406.23412.40.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc: Move branch instruction from
 ACCOUNT_CPU_USER_ENTRY to caller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2012 12:03:26 +1100
In-Reply-To: <1352940045.23412.38.camel@pasglop>
References: <1351666269.32304.12.camel@hbabu-laptop>
 <1352940045.23412.38.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, anton@au1.ibm.com,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-11-15 at 11:40 +1100, Benjamin Herrenschmidt wrote:
On Tue, 2012-10-30 at 23:51 -0700, Haren Myneni wrote:
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -159,8 +159,9 @@ exc_##n##_common:                                                       \
        std     r9,GPR9(r1);            /* save r9 in stackframe */         \
        std     r10,_NIP(r1);           /* save SRR0 to stackframe */       \
        std     r11,_MSR(r1);           /* save SRR1 to stackframe */       \
+       beq     1f                      /* if from kernel mode */

Missing semicolon 

Ok, that's not enough. Please test & fix & resend.

Cheers,
Ben.
