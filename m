Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23F1BB7BAE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 20:24:21 +1100 (EST)
Message-ID: <32482393.1258104254998.JavaMail.ngmail@webmail11.arcor-online.net>
Date: Fri, 13 Nov 2009 10:24:14 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] mpc5200/gpt: tiny fix for gpt period limitation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant:

Thanks a lot for pushing the stuff to 'test'.

> up patch 3.  BUT, you're on my shit list.  Patch 2 in your series
> conflicts with this patch.  I had to fix it up by hand.  This patch

I'm sorry for that confusion!  I actually merged this patch into <http://li=
sts.ozlabs.org/pipermail/linuxppc-dev/2009-November/077715.html>:

<quote>
Note: The patch does also include the tiny GPT api changes from
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-November/077647.html>.
</quote>

Actually, this was not *really* the truth...

> should have been part of the series, or at least base the series on
> this patch.  Take a look in my -test branch and make sure I fixed it
> right.

...because I now see the following diff between your test branch and my loc=
al version:

<snip>
adress@pc-adr2:/opt/eldk-4.2/usr/src/linux-2.6-secretlab$ diff -uBb arch/po=
werpc/platforms/52xx/mpc52xx_gpt.c ../linux-2.6-secretlab__/arch/powerpc/pl=
atforms/52xx/mpc52xx_gpt.c
--- arch/powerpc/platforms/52xx/mpc52xx_gpt.c   2009-11-13 09:31:40.0000000=
00 +0100
+++ ../linux-2.6-secretlab__/arch/powerpc/platforms/52xx/mpc52xx_gpt.c  200=
9-11-12 14:37:39.000000000 +0100
@@ -414,9 +414,10 @@
        /* Determine the number of clocks in the requested period.  64 bit
         * arithmatic is done here to preserve the precision until the valu=
e
         * is scaled back down into the u32 range.  Period is in 'ns', bus
-        * frequency is in Hz. */
+        * frequency is in Hz.  The maximum timeout @33MHz IPB clock is ~13=
0
+        * seconds*/
        clocks =3D period * (u64)gpt->ipb_freq;
-       do_div(clocks, 1000000000); /* Scale it down to ns range */
+       do_div(clocks, 1000000000ULL); /* Scale it down to ns range */
=20
        /* This device cannot handle a clock count greater than 32 bits */
        if (clocks > 0xffffffff)
@@ -460,7 +461,7 @@
 /**
  * mpc52xx_gpt_start_timer - Set and enable the GPT timer
  * @gpt: Pointer to gpt private data structure
- * @period: period of timer in ns; max. ~130s @ 33MHz IPB clock
+ * @period: period of timer in ns
  * @continuous: set to 1 to make timer continuous free running
  *
  * An interrupt will be generated every time the timer fires
</snip>

Again, I'm really sorry for the chaos!  Apparently, submitting patches afte=
r two glasses of red wine is a questionable idea... :-/

Thanks, Albrecht.

Jetzt NEU: Do it youself E-Cards bei Arcor.de!
Stellen Sie Ihr eigenes Unikat zusammen und machen Sie dem Empf=E4nger eine=
 ganz pers=F6nliche Freude!
E-Card Marke Eigenbau: HIER KLICKEN: http://www.arcor.de/rd/footer.ecard
