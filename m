Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 382626886E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 05:10:45 +1100 (EST)
Message-ID: <439F0E9B.30600@digis.net>
Date: Tue, 13 Dec 2005 11:10:35 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20051207195112.06457353A66@atlas.denx.de>
In-Reply-To: <20051207195112.06457353A66@atlas.denx.de>
Content-Type: multipart/mixed; boundary="------------080900010408090104080501"
Cc: linuxppc-embedded@ozlabs.org
Subject: MPC5200 RTC
Reply-To: Frank Bennett <bennett78@digis.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080900010408090104080501
Content-Type: multipart/alternative;
	boundary="------------070609030907020505070308"


--------------070609030907020505070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 *  The /dev/rtc interface will block on reads until an interrupt
 *  has been received. If a RTC interrupt has already happened,
 *  it will output an unsigned long and then block.

Paul Gortmaker's  rtctest (included below) works really well on my x86
machine  (driver/char/rtc.c) as a nice way for a user process to wait on 
ticks
of a programable frequency (via ioctl).

Under Denx linuxppc_2_4_devel MPC5200 I've tried:
    driver/char/rtc.c - kernel panics
       seems to need a RTC_IRQ to be defined
       include/linux/mc14681rtc.h mentions #define RTC_IRQ 8 ?
    CONFIG_PPC_RTC also panics
    driver/char/genrtc.c (with #define CONFIG_GEN_RTC_X)
       sort of works but I get the following:
       gen_rtc_interrupt: system delaying clock ticks?

The internal MPC5200 RTC doesn't seem supported.
I see a lot of references to external RTCs, probably because
the standby power for the 5200 is high. I would like to
use a timer as the RTC interrupt and add an external RTC
later as a time reference (none on Lite5200 dev brd).
How best can I assign a GPTx as an interrupt? other than re-write
genrtc.c?

thanks,
Frank Bennett




*//*


--------------070609030907020505070308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
&nbsp;*&nbsp; The /dev/rtc interface will block on reads until an interrupt<br>
&nbsp;*&nbsp; has been received. If a RTC interrupt has already happened,<br>
&nbsp;*&nbsp; it will output an unsigned long and then block. <br>
<br>
Paul Gortmaker's&nbsp; rtctest (included below) works really well on my x86 <br>
machine&nbsp; (driver/char/rtc.c) as a nice way for a user process to wait
on ticks<br>
of a programable frequency (via ioctl).<br>
<br>
Under Denx linuxppc_2_4_devel MPC5200 I've tried:<br>
&nbsp;&nbsp;&nbsp; driver/char/rtc.c - kernel panics <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; seems to need a RTC_IRQ to be defined<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; include/linux/mc14681rtc.h mentions #define RTC_IRQ 8 ?<br>
&nbsp;&nbsp;&nbsp; CONFIG_PPC_RTC also panics<br>
&nbsp;&nbsp;&nbsp; driver/char/genrtc.c (with #define CONFIG_GEN_RTC_X)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; sort of works but I get the following:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; gen_rtc_interrupt: system delaying clock ticks?<br>
<br>
The internal MPC5200 RTC doesn't seem supported.<br>
I see a lot of references to external RTCs, probably because<br>
the standby power for the 5200 is high. I would like to<br>
use a timer as the RTC interrupt and add an external RTC<br>
later as a time reference (none on Lite5200 dev brd).<br>
How best can I assign a GPTx as an interrupt? other than re-write <br>
genrtc.c?<br>
<br>
thanks,<br>
Frank Bennett<br>
<br>
<br>
<br>
<br>
<div class="moz-signature">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em></em></font></big></b>
</pre>
</div>
</body>
</html>

--------------070609030907020505070308--

--------------080900010408090104080501
Content-Type: text/x-c;
 name="rtctest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtctest.c"

/*
 *	Real Time Clock Driver Test/Example Program
 *
 *	Compile with:
 *		gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
 *
 *	Copyright (C) 1996, Paul Gortmaker.
 *
 *	Released under the GNU General Public License, version 2,
 *	included herein by reference.
 *
 */
#define spinlock_t int

#include <stdio.h>
#include <linux/mc146818rtc.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

void main(void) {

int i, fd, retval, irqcount = 0;
unsigned long tmp, data;
struct rtc_time rtc_tm;

fd = open ("/dev/rtc", O_RDONLY);

if (fd ==  -1) {
	perror("/dev/rtc");
	exit(errno);
}

fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");

/* Turn on update interrupts (one per second) */
retval = ioctl(fd, RTC_UIE_ON, 0);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

fprintf(stderr, "Counting 5 update (1/sec) interrupts from reading /dev/rtc:");
fflush(stderr);
for (i=1; i<6; i++) {
	/* This read will block */
	retval = read(fd, &data, sizeof(unsigned long));
	if (retval == -1) {
		perror("read");
		exit(errno);
	}
	fprintf(stderr, " %d",i);
	fflush(stderr);
	irqcount++;
}

fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
fflush(stderr);
for (i=1; i<6; i++) {
	struct timeval tv = {5, 0};	/* 5 second timeout on select */
	fd_set readfds;

	FD_ZERO(&readfds);
	FD_SET(fd, &readfds);
	/* The select will wait until an RTC interrupt happens. */
	retval = select(fd+1, &readfds, NULL, NULL, &tv);
	if (retval == -1) {
		perror("select");
		exit(errno);
	}
	/* This read won't block unlike the select-less case above. */
	retval = read(fd, &data, sizeof(unsigned long));
	if (retval == -1) {
		perror("read");
		exit(errno);
	}
	fprintf(stderr, " %d",i);
	fflush(stderr);
	irqcount++;
}

/* Turn off update interrupts */
retval = ioctl(fd, RTC_UIE_OFF, 0);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

/* Read the RTC time/date */
retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
	rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);

/* Set the alarm to 5 sec in the future, and check for rollover */
rtc_tm.tm_sec += 5;
if (rtc_tm.tm_sec >= 60) {
	rtc_tm.tm_sec %= 60;
	rtc_tm.tm_min++;
}
if  (rtc_tm.tm_min == 60) {
	rtc_tm.tm_min = 0;
	rtc_tm.tm_hour++;
}
if  (rtc_tm.tm_hour == 24)
	rtc_tm.tm_hour = 0;

retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

/* Read the current alarm settings */
retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);

/* Enable alarm interrupts */
retval = ioctl(fd, RTC_AIE_ON, 0);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

fprintf(stderr, "Waiting 5 seconds for alarm...");
fflush(stderr);
/* This blocks until the alarm ring causes an interrupt */
retval = read(fd, &data, sizeof(unsigned long));
if (retval == -1) {
	perror("read");
	exit(errno);
}
irqcount++;
fprintf(stderr, " okay. Alarm rang.\n");

/* Disable alarm interrupts */
retval = ioctl(fd, RTC_AIE_OFF, 0);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

/* Read periodic IRQ rate */
retval = ioctl(fd, RTC_IRQP_READ, &tmp);
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}
fprintf(stderr, "\nPeriodic IRQ rate was %ldHz.\n", tmp);

fprintf(stderr, "Counting 20 interrupts at:");
fflush(stderr);

/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
for (tmp=2; tmp<=64; tmp*=2) {

	retval = ioctl(fd, RTC_IRQP_SET, tmp);
	if (retval == -1) {
		perror("ioctl");
		exit(errno);
	}

	fprintf(stderr, "\n%ldHz:\t", tmp);
	fflush(stderr);

	/* Enable periodic interrupts */
	retval = ioctl(fd, RTC_PIE_ON, 0);
	if (retval == -1) {
		perror("ioctl");
		exit(errno);
	}

	for (i=1; i<21; i++) {
		/* This blocks */
		retval = read(fd, &data, sizeof(unsigned long));
		if (retval == -1) {
			perror("read");
			exit(errno);
		}
		fprintf(stderr, " %d",i);
		fflush(stderr);
		irqcount++;
	}

	/* Disable periodic interrupts */
	retval = ioctl(fd, RTC_PIE_OFF, 0);
	if (retval == -1) {
		perror("ioctl");
		exit(errno);
	}
}

fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
fprintf(stderr, "\nTyping \"cat /proc/interrupts\" will show %d more events on IRQ 8.\n\n",
								 irqcount);

close(fd);

} /* end main */


--------------080900010408090104080501--
