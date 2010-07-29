Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id D43B3B70A9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 20:16:36 +1000 (EST)
Subject: [GIT/PATCH 0/4] Do not use IRQF_TIMER for non timer interrupts
From: Ian Campbell <Ian.Campbell@eu.citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
	<1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
	<alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Jul 2010 11:16:13 +0100
Message-ID: <1280398573.24292.1684.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-29 at 09:49 +0100, Thomas Gleixner wrote:
> On Wed, 28 Jul 2010, Ian Campbell wrote:
> 
> > Continue to provide IRQF_TIMER as an alias to IRQF_NO_SUSPEND since I
> > think it is worth preserving the nice self-documenting name (where it
> > is used appropriately). It also avoid needing to patch all the many
> > users who are using the flag for an actual timer interrupt.
> 
> I'm not happy about the alias. What about:
> 
> #define __IRQF_TIMER		0x00000200
> #define IRQF_NO_SUSPEND		0x00000400
> 
> #define IRQF_TIMER    (__IRQF_TIMER | IRQF_NO_SUSPEND)

Resending with this change. Plus I ran checkpatch on the whole lot (I
previously managed to run it only on the first patch) and fixed the
complaints.

Ian.

The following changes since commit fc0f5ac8fe693d1b05f5a928cc48135d1c8b7f2e:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../ericvh/v9fs

are available in the git repository at:

  git://xenbits.xensource.com/people/ianc/linux-2.6.git for-irq/irqf-no-suspend

Ian Campbell (4):
      irq: Add new IRQ flag IRQF_NO_SUSPEND
      ixp4xx-beeper: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer interrupt
      powerpc: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer interrupts
      xen: do not suspend IPI IRQs.

 arch/powerpc/platforms/powermac/low_i2c.c |    5 +++--
 drivers/input/misc/ixp4xx-beeper.c        |    3 ++-
 drivers/macintosh/via-pmu.c               |    9 +++++----
 drivers/xen/events.c                      |    1 +
 include/linux/interrupt.h                 |    7 ++++++-
 kernel/irq/manage.c                       |    2 +-
 6 files changed, 18 insertions(+), 9 deletions(-)
