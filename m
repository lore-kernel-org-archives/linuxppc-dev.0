Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id B9BE8100D2D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 21:04:30 +1000 (EST)
Subject: [GIT/PATCH 0/4] Do not use IRQF_TIMER for non timer interrupts
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 11:54:05 +0100
Message-ID: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com,
	devicetree-discuss@lists.ozlabs.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

A small number of users of IRQF_TIMER are using it for the implied no
suspend behaviour on interrupts which are not timer interrupts.

Therefore the following series renames the IRQF_TIMER flag to
IRQF_NO_SUSPEND and updates the users which are not timer interrupts to
use the new name. IRQF_TIMER is retained as an alias for
IRQF_NO_SUSPEND.

The final patch in the series adds a new user the flag which disables
suspend of Xen IPI IRQs.

Ian.

The following changes since commit fc0f5ac8fe693d1b05f5a928cc48135d1c8b7f2e:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../ericvh/v9fs

are available in the git repository at:

  git://xenbits.xensource.com/people/ianc/linux-2.6.git for-irq/irqf-no-suspend

Ian Campbell (4):
      irq: rename IRQF_TIMER to IRQF_NO_SUSPEND
      ixp4xx-beeper: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer interrupt
      powerpc: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer interrupts
      xen: do not suspend IPI IRQs.

 arch/powerpc/platforms/powermac/low_i2c.c |    4 ++--
 drivers/input/misc/ixp4xx-beeper.c        |    2 +-
 drivers/macintosh/via-pmu.c               |    4 ++--
 drivers/xen/events.c                      |    1 +
 include/linux/interrupt.h                 |    8 ++++++--
 kernel/irq/manage.c                       |    2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)
