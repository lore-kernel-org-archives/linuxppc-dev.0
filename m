Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ2dL55SbzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 20:37:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of
 whole rewrite
In-Reply-To: <87lgpo8b91.fsf@concordia.ellerman.id.au>
References: <87wp9d5ekz.fsf@concordia.ellerman.id.au>
 <20170519154705.10504-1-ivan@de.ibm.com>
 <87lgpo8b91.fsf@concordia.ellerman.id.au>
Date: Fri, 26 May 2017 20:37:25 +1000
Message-ID: <87k2539a56.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Ivan Mikhaylov <ivan@de.ibm.com> writes:
>>
>> From my point of view it's possible. I've checked docu and on idea
>> it should be possible cause WP is only affecting watchdog ping time.
>
> The question is, is there any chance that leaving those bits set on
> another platform will cause a problem?
>
> ie. on existing machines we always clear those bits, is it OK that we
> will now start leaving those bits with whatever value they had.

I came up with the patch below (more or less your v2), if it breaks
something we can always fix it.

cheers

commit c80409358a9c91e1f6b18353dad939b851bb3522
Author: Ivan Mikhaylov <ivan@de.ibm.com>
Date:   Fri May 19 18:47:05 2017 +0300

    powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]
    
    Prevent a kernel panic caused by unintentionally clearing TCR watchdog
    bits. At this point in the kernel boot, the watchdog may have already
    been enabled by u-boot. The original code's attempt to write to the TCR
    register results in an inadvertent clearing of the watchdog
    configuration bits, causing the 476 to reset.
    
    Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2b33cfaac7b8..60714b8c9a2f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -739,12 +739,20 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
 static void start_cpu_decrementer(void)
 {
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	unsigned int tcr;
+
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
 
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
+	tcr = mfspr(SPRN_TCR);
+	/*
+	 * The watchdog may have already been enabled by u-boot. So leave
+	 * TRC[WP] (Watchdog Period) alone.
+	 */
+	tcr &= TCR_WP_MASK;	/* Clear all bits except for TCR[WP] */
+	tcr |= TCR_DIE;		/* Enable decrementer */
+	mtspr(SPRN_TCR, tcr);
+#endif
 }
 
 void __init generic_calibrate_decr(void)
