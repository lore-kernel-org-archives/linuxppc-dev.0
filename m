Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B6D9DE067
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 04:00:38 +1100 (EST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/6] Proposal for a Generic PWM Device API
Date: Wed,  8 Oct 2008 11:43:11 -0500
Message-Id: <cover.1223482372.git.bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series proposes a "generic PWM" driver API.

This proposed API is motivated by the author's need to support
pluggable devices; a secondary objective is to consolidate the
existing PWM implementations behind an agreeable, consistent,
redundancy-reducing interface.

The code included in this patch draws heavily from the existing PWM
infrastructure and driver for the AT91SAM9263 PWMC.  The author is
grateful to Russell King, Eric Miao, David Brownell and others for
providing such tall "shoulders" to stand upon.  The proposed updates
to that code should not be interpreted as attempts to address
shortcomings, but rather to extend functionality in ways that were not
originally required.

The implementation of the proposed API is structurally similar to the
generic GPIO API, except that the PWM code uses platform bus_id
strings instead of integers to identify devices.  A configuration
structure is also provided, so that the API can be extended in a
source-code-compatible way to accomodate devices with features not
anticipated by the current code.

Pulse width modulated signals are used in an astounding number and
range of applications, and there is no "one true way" of either
realizing them or employing them to accomplish real work.  The current
proposal attempts to provide a useful feature set for the most basic
users, packaged in such a way as to allow the API to be extended in a
backwards-compatible way as new needs are identified.  Some of these
needs have already been identified.

The proposed code has been run-tested on a Cogent CSB737
(AT91SAM9263), mated to a custom circuit that drives multiple DC
motors and sensors.


Feedback is welcome!



b.g.
--
Bill Gatliff
<bgat@billgatliff.com>


==========================================================================

Bill Gatliff (6):
  [PWM] Generic PWM API implementation
  [PWM] Changes to existing pwm.h to adapt to generic PWM API
  [PWM] Documentation
  [PWM] Driver for Atmel PWMC peripheral
  [PWM] Install new Atmel PWMC driver in Kconfig, expunge old one
  [PWM] New LED driver and trigger that use PWM API

 Documentation/pwm.txt      |  258 +++++++++++++++++
 arch/arm/Kconfig           |    2 +
 drivers/Makefile           |    2 +
 drivers/leds/Kconfig       |   21 +-
 drivers/leds/Makefile      |    2 +
 drivers/leds/leds-pwm.c    |  141 ++++++++++
 drivers/leds/ledtrig-dim.c |   95 +++++++
 drivers/misc/Kconfig       |    9 -
 drivers/misc/Makefile      |    1 -
 drivers/misc/atmel_pwm.c   |  409 ---------------------------
 drivers/pwm/Kconfig        |   24 ++
 drivers/pwm/Makefile       |    6 +
 drivers/pwm/atmel-pwm.c    |  631 +++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm.c          |  667 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm-led.h    |   34 +++
 include/linux/pwm.h        |  168 ++++++++++--
 16 files changed, 2023 insertions(+), 447 deletions(-)
 create mode 100644 Documentation/pwm.txt
 create mode 100644 drivers/leds/leds-pwm.c
 create mode 100644 drivers/leds/ledtrig-dim.c
 delete mode 100644 drivers/misc/atmel_pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/atmel-pwm.c
 create mode 100644 drivers/pwm/pwm.c
 create mode 100644 include/linux/pwm-led.h
