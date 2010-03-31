Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 578F0B7BFA
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 14:04:32 +1100 (EST)
Received: by ywh34 with SMTP id 34so7436749ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 20:04:31 -0700 (PDT)
Message-ID: <4BB2BBDD.6050304@billgatliff.com>
Date: Tue, 30 Mar 2010 22:05:01 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Requesting a GPIO that hasn't been registered yet
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


I'm sure this is a FAQ, but I can't seem to find the answer.  I'm happy
to RTFM, if someone can please tell me where the FM is.  :)

I'm adding device table support to gpio_keys.  The target is an
MPC5200B.  I have statements in my dts file that look like this:

...
        i2c@3d40 {
            #address-cells = <1>;
            #size-cells = <0>;
            compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
            reg = <0x3d40 0x40>;
            interrupts = <2 16 0>;
...
            lext60: max7314@60 {
                compatible = "maxim,max7314","phillips,pca953x";
                reg = <0x60>;
                gpio-controller;
                #gpio-cells = <2>;
            };
        };
...
        gpio-keys {
              compatible = "gpio-keys";
              encoder_button {
                     gpios = <&lext60 12 0>;
                     code = <28>;
                     type = <1>;
                     active-low = <0>;
                     wakeup = <0>;
                     debounce-interval = <0>;
                     rep = <0>;
                     };
             };

In other words, the GPIO pin I'm using for the key is one of the bits on
my pca953x GPIO expander chip.

The above would all be great, except that I haven't come up with a way
to make sure that my encoder_button doesn't try to probe before lext60
is available.  In fact, I'm consistently getting initialization in the
wrong order!

Eventually the GPIO expander chip gets plugged in, because I can see it
show up in sysfs.  And what's really odd is, I recently made similar
mods to gpio_leds and they are working fine--- although the GPIO pin is
on a pca953x at address 20, instead of 60.  I'm at a loss to explain why
one works, but the other doesn't.  And I don't know how to really fix
this problem for good!

Any suggestions?  Thanks!!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
