Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A12AEDDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:52:51 +1000 (EST)
Date: Thu, 15 May 2008 20:52:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/8 v3] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-ID: <20080515165250.GA30738@polina.dev.rtsoft.ru>
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

Once again thanks for the previous review, updated series follows.

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
