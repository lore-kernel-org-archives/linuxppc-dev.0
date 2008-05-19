Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C491EDE2CC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 04:37:11 +1000 (EST)
Date: Mon, 19 May 2008 22:37:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-ID: <20080519183709.GA5957@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Chen Gong <G.Chen@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Much thanks for the review, testing and acks!

New version follows, now tested on MPC8xx.

Kumar, if you're okay with the patches, could you please Ack the
[WATCHDOG] ones?

Thanks,

---

Changes since v3:

- MPC8xx quirk folded into MPC8xx support patch.
- Tested-by: Jochen Friedrich <jochen@scram.de>
- "[WATCHDOG] mpc83xx_wdt: convert to the OF platform driver"
  Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Changes since v2:

- New patch to fix current driver's checkpatch issues;
- New patch supporting MPC8xx watchdogs (ok to drop until tested);
- Removed MODULE_ALIAS("platform:mpc83xx_wdt"), since this driver is no
  longer on the platform bus;
- When renaming the driver also mention what kind of CPUs we support.
  Also give a pointer for BookE watchdog driver. Though BookE users will
  not see the MPC8xxx driver at all, because we're explicitly listing the
  CPU families in "depends on". But this tip might be useful for
  developers.
- Scott Wood noticed that we don't need device_type anymore. I thought
  that OpenFirmware defines this type, but google didn't prove that.
  So I just removed the device_type.

Changes since v1:

- Scott Wood asked for mpc83xx_wdt on multiplatform kernels. Done via
  OF platform driver;
- Kumar Gala asked for mpc83xx_wdt -> mpc8xxx_wdt rename. Done in two
  steps;
- Segher Boessenkool noticed a negligence in the wdt device tree node.
  Fixed by removing mpc83xx_wdt compatible entry.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
