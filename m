Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id CB7C9B713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 01:52:00 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: tighten up ac97 reset timing
Date: Fri, 3 Sep 2010 11:45:22 -0400
Message-ID: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tighten up time timing around the gpio reset functionality.  Add a 200ns
delay before remuxing the pins back to ac97 to comply with the ac97 spec.
This delay ensures that sync and sdata_out are held low while reset
transitions to high.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---

Scope shots are availible upon request.

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_common.c
index 6e90531..79adfe7 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -326,11 +326,14 @@ int mpc5200_psc_ac97_gpio_reset(int psc_number)
        clrbits8(&wkup_gpio->wkup_dvo, reset);

        /* wait at lease 1 us */
-       udelay(2);
+       udelay(1);

        /* Deassert reset */
        setbits8(&wkup_gpio->wkup_dvo, reset);

+       /* wait at least 200ns */
+       __delay(7);
+
        /* Restore pin-muxing */
        out_be32(&simple_gpio->port_config, mux);

--
1.6.3.1

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
