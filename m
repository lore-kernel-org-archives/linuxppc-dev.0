Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp10.mail.mci.yahoo.co.jp (ybbsmtp10.mail.mci.yahoo.co.jp
	[210.80.241.184]) by ozlabs.org (Postfix) with SMTP id 8E29B67CA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 23:56:53 +1000 (EST)
Message-ID: <42DE5695.50102@ybb.ne.jp>
Date: Wed, 20 Jul 2005 22:50:13 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Hiroyuki Machida <machida@sm.sony.co.jp>
References: <42DA05BD.3050403@sm.sony.co.jp>
In-Reply-To: <42DA05BD.3050403@sm.sony.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: swsusp for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

 > It seems to be stopped at console device.
 > Do anyone point out where and how to exclude system devices
 > like console and swap from device suspend procedure as
 > preparation of swsusp?
 >

As long as I think, what you want may be realized by changing the condition
to suspend serial device(this is written in serial8250_suspend function
in drivers/serial/8250.c, line: 2334).

Following trivial patch may help you(But I've not tried this patch on PowerPC actually, sorry).

Regards,


diff -Nupr linux-2.6.orig/drivers/serial/8250.c linux-2.6/drivers/serial/8250.c
--- linux-2.6.orig/drivers/serial/8250.c        2005-07-20 05:37:20.000000000 +0900
+++ linux-2.6/drivers/serial/8250.c     2005-07-20 22:07:36.000000000 +0900
@@ -2331,7 +2331,7 @@ static int serial8250_suspend(struct dev
  {
         int i;

-       if (level != SUSPEND_DISABLE)
+       if ( (level != SUSPEND_DISABLE) || (state == PMSG_FREEZE) )
                 return 0;

         for (i = 0; i < UART_NR; i++) {
