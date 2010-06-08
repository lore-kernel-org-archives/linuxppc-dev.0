Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 6629EB7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 03:13:39 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] mpc5200 ac97 gpio reset
Date: Tue, 8 Jun 2010 12:46:00 -0400
Message-ID: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches reimplement the reset fuction in the ac97 to use gpio pins
instead of using the mpc5200 ac97 reset functionality in the psc.  This
avoids a problem in which attached ac97 devices go into "test" mode appear
unresponsive.

These patches were tested on a pcm030 baseboard and on custom hardware with
a wm9715 audio codec/touchscreen controller.

Eric Millbrandt

---

Eric Millbrandt (2):
    powerpc/5200: Export port-config
    sound/soc: mpc5200_psc_ac97: Use gpio pins for cold reset.

 arch/powerpc/boot/dts/lite5200.dts           |    3 +
 arch/powerpc/boot/dts/lite5200b.dts          |    3 +
 arch/powerpc/boot/dts/pcm030.dts             |    3 +
 arch/powerpc/boot/dts/pcm032.dts             |    3 +
 arch/powerpc/include/asm/mpc52xx.h           |    2 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   61 +++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h                  |    5 ++
 sound/soc/fsl/mpc5200_psc_ac97.c             |   83 ++++++++++++++++++++++=
++-
 8 files changed, 159 insertions(+), 4 deletions(-)

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-


This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
