Return-Path: <livio@eecg.toronto.edu>
Received: from picton.eecg.toronto.edu (picton.eecg.toronto.edu
	[128.100.10.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "picton.eecg.toronto.edu",
	Issuer "picton.eecg.toronto.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 58F39DDDFC
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 03:30:46 +1100 (EST)
Received: from ouch.eecg.toronto.edu (ouch.eecg.toronto.edu [128.100.24.67])
	by picton.eecg.toronto.edu (8.13.6/8.13.6) with ESMTP id l0DFeUhg001698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 10:40:30 -0500 (EST)
Received: (from livio@localhost)
	by ouch.eecg.toronto.edu (8.13.6/8.13.6/Submit) id l0DFeTnR002213
	for linuxppc-dev@ozlabs.org; Sat, 13 Jan 2007 10:40:30 -0500
Date: Sat, 13 Jan 2007 10:40:29 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix performance monitor exception in 2.6.20-series
Message-ID: <20070113154029.GA32292@eecg.toronto.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Hi all,

[  I hope this is the correct mailing list for this sort of patch. Also, I am not
   subscribed; please Cc: with responses.  ]

  To the issue: some point  during 2.6.20 development, Paul Mackerras introduced
the  "lazy IRQ  disabling" patch  (very  cool work,  BTW).  In  that patch,  the
performance monitor unit exception was marked as "maskable", in the sense the if
interrupts were  soft-disabled, that exception  could be ignored. This  broke my
PowerPC  profiling code. The  sympton that  I see  is that  a varying  number of
interrupts  (from 0  to $n$,  typically  closer to  0) get  delivered, when,  in
reality, it should always be very close to $n$.

  The issue stems  from the way masking is being done.   Masking in this fashion
seems to  work well with the  decrementer and external  interrupts, because they
are raised  again until "really"  handled. For the  PMU, however, this  does not
apply  (at least on  my Xserver  machine with  a 970FX  processor).  If  the PMU
exception  is  not  handled,  it  will  _not_  be  re-raised  (at  least  on  my
machine). The documentation states  that the PMXE bit in MMCR0 is  set to 0 when
the PMU exception is raised. However,  software must re-set the bit to re-enable
PMU exceptions.   If the exception  is ignored (as  currently) not only  is that
interrupt lost, but because software does  not reset PMXE, the PMU registers are
"frozen" forever.

  Although I  do not use Oprofile  for performance monitoring, I  suspect it, as
well, will be affected. There are 2 options, as far as I can see, for fixing the
problem:

  1) Just let the PMU exception through, even with interrupts disabled. 

  2) When  hard-disabling   interrupts  (masked_interrupt:  in   head_64.S,  for
     example), if the  exception is a PMU exception, remember  to set PMXE back,
     so that the interrupt will be raised in the future.

     I don't like this option; specifically, I am pretty sure the actual bit for
     enabling PMU interrupts can vary from  one PowerPC chip to the next. Custom
     CPU code will be needed to make this work.

     However, I tested this option #2 on  my 970, and it made my profiling works
     again. 


  IMHO, option  #1 is very  nice, as long  as the PMU interrupt  handler behaves
itself.  One reason option #1 is desirable is, with PC-sampling, we are now able
to  sample  regions _inside_  interrupt-disabled  sections  (assuming an  actual
external interrupt  hasn't really occured yet). Before,  with hardware disabling
of  interrupts,  the  PMU  exceptions  were  necessarily  delivered  outside  of
interrupt disabled sections. 

  Anyways, does anyone see a problem with the following patch? 

  regards,


				Livio


--- linux-2.6.20-rc4/arch/powerpc/kernel/head_64.S	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/kernel/head_64.S	2007-01-13 10:28:49.894734542 -0500
@@ -613,7 +613,7 @@ system_call_pSeries:
 /*** pSeries interrupt support ***/
 
 	/* moved from 0xf00 */
-	MASKABLE_EXCEPTION_PSERIES(., performance_monitor)
+	STD_EXCEPTION_PSERIES(., performance_monitor)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
