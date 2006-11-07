Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 9DB5967C7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 07:02:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: No RTC interrupt for PPC440EP board.
Date: Tue, 7 Nov 2006 11:49:57 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C74973C@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I have PPC440EP board, derived from AMCC Yosemite evaluation board. My
board has Dallas DS1743 NVRAM/RTC chip, connected to local bus (CS2). I
believe, I made necessary initializations for TODC structures (I had to
add CONFIG_GEN_RTC and CONFIG_GEN_RTC_X to my kernel configuration) - I
used bamboo board as an example. Initialization goes OK and I even can
access RTC via proc interface:

~ # cat /proc/driver/rtc
rtc_time        : -8:-1:-51
rtc_date        : 1970-01--14232
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 0
batt_status     : okay

However when I'm using RTC test application, suggested by Paul Gortmaker
in Documentation/rtc.txt, it gets blocked on read operation:

~ # rtctest

                        RTC Driver Test Example.

Counting 5 update (1/sec) interrupts from reading /dev/rtc:

Looks like interrupts don't arrive from device so I don't think this
device by itself would generate any interrupts. Any ideas what I'm doing
wrong? May be this test application is obsolete and I should use another
one? Some missing definitions in my kernel config file?

Thanks,

Leonid.
