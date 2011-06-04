Return-Path: <christian.dietrich@informatik.uni-erlangen.de>
Date: Sat, 4 Jun 2011 17:35:36 +0200
From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Venkatesh Pallipadi (Venki)" <venki@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Avi Kivity <avi@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	David Airlie <airlied@linux.ie>, Neil Brown <neilb@suse.de>,
	Doug Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Michael Ellerman <michael@ellerman.id.au>,
	Anton Blanchard <anton@samba.org>, Kumar Gala <galak@kernel.crashing.org>,
	Alexey Kardashevskiy <aik@au1.ibm.com>, Milton Miller <miltonm@bga.com>,
	Scott Wood <scottwood@freescale.com>, Meador Inge <meador_inge@mentor.com>,
	Kevin Tian <kevin.tian@intel.com>, Fengzhe Zhang <fengzhe.zhang@intel.com>,
	John Stultz <johnstul@us.ibm.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	=?iso-8859-15?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Richard Cochran <richard.cochran@omicron.at>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, lguest@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org, trivial@kernel.org
Subject: [PATCH 0/8] Use printk_ratelimited instead of printk_ratelimit
Message-ID: <cover.1307199715.git.christian.dietrich@informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
since printk_ratelimit() shouldn't be used anymore, I replaced it at several
points, where it was possible with printk_ratelimited(FMT,...). This shouldn't
change the behaviour in most cases, except that the printk will use an local
ratelimit instead of an global one shared with all other printk_ratelimit
calls.

I just must made patches for a few places where it is used. If you think that
it is worth converting all printk_ratelimits, i will send more patches. The 
changes where done against v3.0-rc1-106-g4f1ba49.

greetz chris

Christian Dietrich (8):
  powerpc/rtas-rtc: remove sideeffects of printk_ratelimit
  drivers/octeon: use printk_ratelimited instead of printk_ratelimit
  scsi/sg: use printk_ratelimited instead of printk_ratelimit
  md/raid: use printk_ratelimited instead of printk_ratelimit
  drivers/char/rtc: use printk_ratelimited instead of printk_ratelimit
  drivers/gpu/drm: use printk_ratelimited instead of printk_ratelimit
  arch/powerpc: use printk_ratelimited instead of printk_ratelimit
  arch/x86: use printk_ratelimited instead of printk_ratelimit

 arch/powerpc/kernel/rtas-rtc.c          |   29 +++++++++------
 arch/powerpc/kernel/signal_32.c         |   57 +++++++++++++++++--------------
 arch/powerpc/kernel/signal_64.c         |   17 +++++----
 arch/powerpc/kernel/traps.c             |   22 +++++------
 arch/powerpc/mm/fault.c                 |   10 +++---
 arch/powerpc/sysdev/mpic.c              |   11 +++---
 arch/x86/kernel/hpet.c                  |    6 ++--
 arch/x86/kernel/irq.c                   |    9 ++---
 arch/x86/kvm/i8259.c                    |    7 ++--
 arch/x86/lguest/boot.c                  |    6 ++--
 drivers/char/rtc.c                      |    7 ++--
 drivers/gpu/drm/drm_ioc32.c             |    9 +++--
 drivers/md/raid1.c                      |   22 ++++++-----
 drivers/md/raid10.c                     |   22 ++++++-----
 drivers/md/raid5.c                      |   39 ++++++++++-----------
 drivers/scsi/sg.c                       |   18 +++++----
 drivers/staging/octeon/ethernet-mdio.c  |   27 +++++++-------
 drivers/staging/octeon/ethernet-rgmii.c |   33 +++++++++---------
 drivers/staging/octeon/ethernet-rx.c    |   24 +++++++------
 drivers/staging/octeon/ethernet-sgmii.c |   14 ++++---
 drivers/staging/octeon/ethernet-tx.c    |   11 +++---
 drivers/staging/octeon/ethernet-util.h  |    4 --
 drivers/staging/octeon/ethernet-xaui.c  |   22 ++++++-----
 23 files changed, 221 insertions(+), 205 deletions(-)
