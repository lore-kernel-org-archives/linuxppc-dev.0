Return-Path: <albertcc@tw.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86708DE03C
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 19:12:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6G9CbG6030237
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 05:12:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6G9CbfQ205980
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 03:12:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6G9Cam5006689
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 03:12:37 -0600
Message-ID: <469B3679.20804@tw.ibm.com>
Date: Mon, 16 Jul 2007 17:12:25 +0800
From: Albert Lee <albertcc@tw.ibm.com>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
References: <200707111026.l6BAQ5kh003472@harpo.it.uu.se>
In-Reply-To: <200707111026.l6BAQ5kh003472@harpo.it.uu.se>
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
> On Wed, 11 Jul 2007 10:45:35 +0800, Albert Lee wrote:
> 
>>So, it seems both mdelay(37) and do_gettimeofday() are working properly on PowerMac G3.
>>Maybe the calculated wrong PLL input is due to wrong reading of the counter register?
>>Could you please try the attached debug patch for more clue, thanks.
> 
> 
> This, supposedly debug-only, patch gives me much better PLL calibration:
> 
> pata_pdc2027x 0000:00:0e.0: version 0.9
> bccrh [0] bccrl [0]
> bccrhv[0] bccrlv[0]
> bccrh [7FCF] bccrl [15ED]
> bccrhv[7FCF] bccrlv[15D4]
> start[0] end[1072141805] 
> usec_elapsed for mdelay(100) [105500]
> start time: [1184152411]s [689475]us 
> end   time: [1184152411]s [794975]us 
> PLL input clock[-1563248254]Hz
> usec_elapsed for mdelay(37) [35432]
> start time: [1184152411]s [818033]us 
> end   time: [1184152411]s [853465]us 
> bccrh [7FC9] bccrl [1A4B]
> bccrhv[7FC9] bccrlv[1A4B]
> bccrh [7F98] bccrl [3038]
> bccrhv[7F98] bccrlv[301F]
> start[1071946315] end[1070346296] 
> usec_elapsed for mdelay(100) [103571]
> start time: [1184152411]s [874717]us 
> end   time: [1184152411]s [978288]us 
> PLL input clock[15440000]Hz
> usec_elapsed for mdelay(37) [35431]
> start time: [1184152411]s [997039]us 
> end   time: [1184152412]s [32470]us 
> pata_pdc2027x 0000:00:0e.0: PLL input clock 15440 kHz
> 
> and from then on things are fine.
> 
> Weird. I'll try with an older gcc later (been using gcc-4.2.0 so far).
> 

Is the problem reproducible with more reload loops? Maybe we could try
something like:

#!/bin/sh
while : ; do 
  rmmod pata_pdc2027x
  sleep 1
  modprobe pata_pdc2027x
done

and "tail -f /var/log/messages|grep PLL > pll_test.log" to check the
PLL clock.
--
albert
