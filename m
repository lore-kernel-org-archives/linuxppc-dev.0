Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D185DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 03:37:29 +1000 (EST)
Date: Mon, 2 Jun 2008 21:37:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-ID: <20080602173726.GA24556@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
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

No comments on the previous version for two weeks... resending once
again.

Changes since v3:

- None. Simply resending, plus adding Andrew Morton and linux-kernel
  to Cc, since I'm constantly getting bounces from Wim Van Sebroeck's
  email:

  - - - -
  <wim@iguana.be>:
  213.249.96.99 does not like recipient.
  Remote host said: 450 Client host rejected: cannot find your hostname, [85.21.88.2]
  Giving up on 213.249.96.99.
  I'm not going to try again; this message has been in the queue too long.
  - - - -

  Not sure whose fault is it though.

  Andrew, if Wim will not get this series and there will no objections,
  could you please pick [WATCHDOG] ones?

Changes since v2:

- New patch to fix current driver's checkpatch issues;
- New patch supporting MPC8xx watchdogs;
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
