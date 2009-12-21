Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 69600B6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 09:30:35 +1100 (EST)
Received: by ywh11 with SMTP id 11so6041303ywh.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 14:30:33 -0800 (PST)
Message-ID: <4B2FF71E.10508@billgatliff.com>
Date: Mon, 21 Dec 2009 16:30:54 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Question on MPC52xx IRQ[123] pins
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


I think I already know the answer to this, having read most of the
MPC52xx manual.  But I'll ask anyway, just to be sure I'm not missing
something obvious...  :)

Is it possible to treat the external IRQ[123] pins on the MPC52xx as
GPIO inputs?  And if so, how do I tweak my dts file and other code, if
necessary, to make that happen?

Reason I ask is, I'm trying to enhance
drivers/input/misc/rotary-encoder.c to use device trees, and one of the
encoder inputs is on IRQ2.  My strategy so far is to just provide an
of_probe() function that builds a rotary_encoder_platform_data structure
and then calls platform_device_register().  And that ain't working.  :)

First off, the rotary-encoder driver assumes that both of its inputs are
both known to gpiolib, so that they can do both gpio_to_irq() and
gpio_get_value() on them.  There isn't any existing code that I can find
that allows you to read the states of IRQ pins, be it under gpiolib or
otherwise.  And I think the reason for that is that there's no way to
actually read the states of those pins at all--- the hardware just
doesn't work that way.

Or am I missing something?

Second, if I get all this working then my rotary encoders won't be
platform devices--- they'll be openfirmware devices, which means I'll
have to do other work in the code as well.  That's a subtle point I
know, but rotary-encoder's assumption that all rotary encoder devices
are also platform devices is kind of like mixing policy with
implementation, it turns out.  Almost like trying to reuse a PCI driver
as a platform driver.  I didn't spot how important that was until I
started hacking on the code itself...



Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
