Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id A4F70DE0BD
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 01:11:21 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id m2so1063757uge.14
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 08:11:18 -0700 (PDT)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 19 Sep 2008 17:11:15 +0200
In-Reply-To: <20080918112020.GA11584@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Thu\, 18 Sep 2008 15\:20\:20 +0400")
Message-ID: <87ej3gyxv0.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,

 >> It seems basically the same as my patch (gpio driver for
 >> mpc831x/mpc834x/mpc837x with OF bindings) from September 5th except
 >> you don't have any documentation

 Anton> Well, do we really need documentation for every trivial gpio
 Anton> controller? The bindings are the same, only different compatible
 Anton> entries...

Well, we need some way of knowing that atleast. Having people grepping
through arch/powerpc/boot/dts/ (and knowing that they should look for
8349 even though they might use 8313 or 8610) doesn't seem optimal to
me - I take it that's why we created
Documentation/powerpc/dts-bindings in the first place?

 Anton> If we do need the documentation for this, I can readily include it.

 >> and the Kconfig doesn't depend on
 >> 831x/834x/837x.

 Anton> This is purposely. We also need support for 8610, and maybe
 Anton> later we'll find another chip with the same unit. So, to not touch
 Anton> the Kconfig for every new chip I just made it PPC32-wide. Other
 Anton> option is to depend on FSL_SOC, but the driver really does not
 Anton> depend on any fsl_soc stuff...

Adding another symbol to the Kconfig once it is verified that a new
SoC is compatible doesn't seem like a big deal - Figuring out all the
knobs we already have is, without having options for stuff that is
known to be irrelevant for the SoC.

The other 83xx specific drivers also depend on PPC_83xx.

 >> Why do you need this when you have the lock?

 Anton> See this discussion:

 Anton> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg12299.html

Ahh, for open drain outputs. gpiolib doesn't actually provide an
interface to put the gpios in that mode, but it could ofcause have
been set up in the bootloader. I'll fix that and send an updated
patch.

-- 
Bye, Peter Korsgaard
