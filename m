Return-Path: <neko@genesi-usa.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.249])
	by ozlabs.org (Postfix) with ESMTP id 6F3C2DE229
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 08:08:16 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so304915agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 14:08:14 -0700 (PDT)
Message-ID: <48EE72C1.4040206@genesi-usa.com>
Date: Thu, 09 Oct 2008 16:08:17 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
References: <cover.1223482372.git.bgat@billgatliff.com>
In-Reply-To: <cover.1223482372.git.bgat@billgatliff.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm all for this if you manage it.

The code and API looks good. We have some projects which involve PWM
and having a nice clean standard API like the GPIO API was on the
wishlist.. this will make it so much easier to do fan control,
backlight control, drive motors, audio output, and the billion
other things..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Bill Gatliff wrote:
> This series proposes a "generic PWM" driver API.
> 
> This proposed API is motivated by the author's need to support
> pluggable devices; a secondary objective is to consolidate the
> existing PWM implementations behind an agreeable, consistent,
> redundancy-reducing interface.
> 
> The code included in this patch draws heavily from the existing PWM
> infrastructure and driver for the AT91SAM9263 PWMC.  The author is
> grateful to Russell King, Eric Miao, David Brownell and others for
> providing such tall "shoulders" to stand upon.  The proposed updates
> to that code should not be interpreted as attempts to address
> shortcomings, but rather to extend functionality in ways that were not
> originally required.
> 
> The implementation of the proposed API is structurally similar to the
> generic GPIO API, except that the PWM code uses platform bus_id
> strings instead of integers to identify devices.  A configuration
> structure is also provided, so that the API can be extended in a
> source-code-compatible way to accomodate devices with features not
> anticipated by the current code.
> 
> Pulse width modulated signals are used in an astounding number and
> range of applications, and there is no "one true way" of either
> realizing them or employing them to accomplish real work.  The current
> proposal attempts to provide a useful feature set for the most basic
> users, packaged in such a way as to allow the API to be extended in a
> backwards-compatible way as new needs are identified.  Some of these
> needs have already been identified.
> 
> The proposed code has been run-tested on a Cogent CSB737
> (AT91SAM9263), mated to a custom circuit that drives multiple DC
> motors and sensors.
> 
> 
> Feedback is welcome!
> 
> 
> 
> b.g.
> --
> Bill Gatliff
> <bgat@billgatliff.com>
> 
> 
> ==========================================================================
> 
> Bill Gatliff (6):
>   [PWM] Generic PWM API implementation
>   [PWM] Changes to existing pwm.h to adapt to generic PWM API
>   [PWM] Documentation
>   [PWM] Driver for Atmel PWMC peripheral
>   [PWM] Install new Atmel PWMC driver in Kconfig, expunge old one
>   [PWM] New LED driver and trigger that use PWM API
> 
>  Documentation/pwm.txt      |  258 +++++++++++++++++
>  arch/arm/Kconfig           |    2 +
>  drivers/Makefile           |    2 +
>  drivers/leds/Kconfig       |   21 +-
>  drivers/leds/Makefile      |    2 +
>  drivers/leds/leds-pwm.c    |  141 ++++++++++
>  drivers/leds/ledtrig-dim.c |   95 +++++++
>  drivers/misc/Kconfig       |    9 -
>  drivers/misc/Makefile      |    1 -
>  drivers/misc/atmel_pwm.c   |  409 ---------------------------
>  drivers/pwm/Kconfig        |   24 ++
>  drivers/pwm/Makefile       |    6 +
>  drivers/pwm/atmel-pwm.c    |  631 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm.c          |  667 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pwm-led.h    |   34 +++
>  include/linux/pwm.h        |  168 ++++++++++--
>  16 files changed, 2023 insertions(+), 447 deletions(-)
>  create mode 100644 Documentation/pwm.txt
>  create mode 100644 drivers/leds/leds-pwm.c
>  create mode 100644 drivers/leds/ledtrig-dim.c
>  delete mode 100644 drivers/misc/atmel_pwm.c
>  create mode 100644 drivers/pwm/Kconfig
>  create mode 100644 drivers/pwm/Makefile
>  create mode 100644 drivers/pwm/atmel-pwm.c
>  create mode 100644 drivers/pwm/pwm.c
>  create mode 100644 include/linux/pwm-led.h
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
