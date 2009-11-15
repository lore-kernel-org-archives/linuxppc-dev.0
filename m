Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD8BB1007D6
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 04:17:38 +1100 (EST)
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net
	[151.189.8.15]) by mx.arcor.de (Postfix) with ESMTP id 11D1C3CA71F
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 18:17:34 +0100 (CET)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id F0AC22D3128
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 18:17:33 +0100 (CET)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net
	[151.189.8.93])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id E2B8B2AEE9D
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 18:17:33 +0100 (CET)
Message-ID: <283847.1258305453891.JavaMail.ngmail@webmail10.arcor-online.net>
Date: Sun, 15 Nov 2009 18:17:33 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@ozlabs.org
Subject: [Q/RFC] mpc52xx gpt api
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I tried to use a '5200B internal timer for a very simple task - as pwm to m=
ake a led blink, but apparently the current gpt implementation from Grant's=
 tree does only support internal (cpu timer) modes which do not use the tim=
er io pin.

The first hurdle was to actually get the timer itself - mpc52xx_gpt_from_ir=
q() never returned something when I passed the timers (v)irq to it.  What i=
s the intended use of this function?  BTW, I do not need timer irq's, so I =
believe there should be an other way to grab a timer!

I made several changes to finally get the pwm timer running for me with the=
 current implementation, but IMO it might be interesting to have a more gen=
eric api.  Before digging into it, I would be interested in any comment abo=
ut the following approach, which could cover all possible gpt operating mod=
es:

* struct mpc52xx_gpt_priv *mpc52xx_gpt_grab(const char * name, mode)
  name: timer name, e.g. "f0000630.timer", or NULL for the next free cpu ti=
mer
  mode: CPU, PWM, IC or OC.  The latter three are only possible if the requ=
ested timer shall not be used as gpio (i.e. the device tree does not regist=
er it as such)
  The function shall mark the timer as being in use, to avoid access confli=
cts.
  It might also make sense to pass an irq callback function here.  The gpt =
module would catch the hw irq, clear the status flags, and then call this f=
unction.

* int mpc52xx_gpt_setup
  Configure period, continuous (cpu only), pwm width and polarity (pwm only=
).  Didn't look into the special IC/OC requirements yet.  Probably it makes=
 sense to provide different functions for the four different modes (mpc52xx=
_gpt_setup_internal, mpc52xx_gpt_setup_pwm, etc.).  We might then omit the =
mode parameter of the "grab" function, and shift the gpio vs. timer pin con=
flict check here.
  The function shall always change the timer registers, even if the timer i=
s already running, which is convenient if e.g. the pwm output waveform shal=
l be changed on the fly.

* int mpc52xx_gpt_runstate(struct mpc52xx_gpt_priv *, int running)
  Start/stop the timer

* int mpc52xx_gpt_release(struct mpc52xx_gpt_priv *)
  Release timer, so an other mpc52xx_gpt_grab() will succeed.

Opinions?

Cheers, Albrecht.

Jetzt NEU: Do it youself E-Cards bei Arcor.de!
Stellen Sie Ihr eigenes Unikat zusammen und machen Sie dem Empf=E4nger eine=
 ganz pers=F6nliche Freude!
E-Card Marke Eigenbau: HIER KLICKEN: http://www.arcor.de/rd/footer.ecard
