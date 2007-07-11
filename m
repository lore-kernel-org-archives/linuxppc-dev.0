Return-Path: <albertcc@tw.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A006DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 12:45:49 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6B2jjBj021039
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:45:45 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6B2jjRZ257062
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 20:45:45 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6B2jij8032078
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 20:45:45 -0600
Message-ID: <4694444F.3050909@tw.ibm.com>
Date: Wed, 11 Jul 2007 10:45:35 +0800
From: Albert Lee <albertcc@tw.ibm.com>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
References: <200707102314.l6ANEWq2029195@harpo.it.uu.se>
In-Reply-To: <200707102314.l6ANEWq2029195@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dwm@enoyolf.org, jeff@garzik.org, linux-ide@vger.kernel.org,
	bahadir.balban@gmail.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
Reply-To: albertl@mail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikael Pettersson wrote:
> 
> 
> 2.6.22 + this prints the following on my G3:
> 
> pata_pdc2027x 0000:00:0e.0: version 0.9
> usec_elapsed for mdelay(37) [35431]
> start time: [1184112028]s [775333]us 
> end   time: [1184112028]s [810764]us 
> pata_pdc2027x 0000:00:0e.0: PLL input clock 1691741 kHz
> pata_pdc2027x: Invalid PLL input clock 1691741kHz, give up!
> 

My x86 box got this:
Jul 11 10:02:17 p4ht-s kernel: [  260.746980] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
Jul 11 10:02:17 p4ht-s kernel: [  260.882905] usec_elapsed for mdelay(37) [36734]
Jul 11 10:02:17 p4ht-s kernel: [  260.882911] start time: [1184119336]s [999802]us 
Jul 11 10:02:17 p4ht-s kernel: [  260.882914] end   time: [1184119337]s [36536]us 
Jul 11 10:02:17 p4ht-s kernel: [  260.882917] pata_pdc2027x 0000:02:05.0: PLL input clock 16829 kHz

So, it seems both mdelay(37) and do_gettimeofday() are working properly on PowerMac G3.
Maybe the calculated wrong PLL input is due to wrong reading of the counter register?
Could you please try the attached debug patch for more clue, thanks.

--
albert

diff -Nrup 00_libata-dev/drivers/ata/pata_pdc2027x.c 01_debug/drivers/ata/pata_pdc2027x.c
--- 00_libata-dev/drivers/ata/pata_pdc2027x.c	2007-07-07 09:58:55.000000000 +0800
+++ 01_debug/drivers/ata/pata_pdc2027x.c	2007-07-11 10:41:41.000000000 +0800
@@ -574,8 +574,8 @@ retry:
 
 	counter = (bccrh << 15) | bccrl;
 
-	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
-	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
+	printk(KERN_ERR "bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
+	printk(KERN_ERR "bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
 
 	/*
 	 * The 30-bit decreasing counter are read by 2 pieces.
@@ -584,7 +584,7 @@ retry:
 	 */
 	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
 		retry--;
-		PDPRINTK("rereading counter\n");
+		printk(KERN_ERR "rereading counter\n");
 		goto retry;
 	}
 
@@ -722,8 +722,21 @@ static long pdc_detect_pll_input_clock(s
 	pll_clock = (start_count - end_count) / 100 *
 		(100000000 / usec_elapsed);
 
-	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
-	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
+	printk(KERN_ERR "start[%ld] end[%ld] \n", start_count, end_count);
+	printk(KERN_ERR "usec_elapsed for mdelay(100) [%ld]\n", usec_elapsed);
+	printk(KERN_ERR "start time: [%ld]s [%ld]us \n", start_time.tv_sec, start_time.tv_usec);
+	printk(KERN_ERR "end   time: [%ld]s [%ld]us \n", end_time.tv_sec, end_time.tv_usec);
+	printk(KERN_ERR "PLL input clock[%ld]Hz\n", pll_clock);
+
+	/* mdelay(37) for comparison */
+	do_gettimeofday(&start_time);
+	mdelay(37);
+	do_gettimeofday(&end_time);
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
+		(end_time.tv_usec - start_time.tv_usec);
+	printk(KERN_ERR "usec_elapsed for mdelay(37) [%ld]\n", usec_elapsed);
+	printk(KERN_ERR "start time: [%ld]s [%ld]us \n", start_time.tv_sec, start_time.tv_usec);
+	printk(KERN_ERR "end   time: [%ld]s [%ld]us \n", end_time.tv_sec, end_time.tv_usec);
 
 	return pll_clock;
 }
