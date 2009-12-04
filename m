Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFD83B70CF
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 13:20:05 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nB42JxPr003825
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2009 20:20:00 -0600
Subject: [Fwd: [PATCH] therm_adt746x: Record pwm invert bit at module load
	time]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-55uCn9n1hiMisPC0Yg1d"
Date: Fri, 04 Dec 2009 13:19:59 +1100
Message-ID: <1259893199.2076.1242.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-55uCn9n1hiMisPC0Yg1d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-55uCn9n1hiMisPC0Yg1d
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH] therm_adt746x: Record pwm
 invert bit at module load time
Content-Type: message/rfc822

Return-Path: <djwong@us.ibm.com>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_50,
 DNS_FROM_RFC_ABUSE autolearn=no version=3.1.9
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAUNlUKL027416 for
 <benh@kernel.crashing.org>; Mon, 30 Nov 2009 17:47:30 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com
 [9.56.227.237]) by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id
 nAUNjDSZ015253 for <benh@kernel.crashing.org>; Mon, 30 Nov 2009 18:45:13
 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217]) by
 d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 nAUNlTPg130708 for <benh@kernel.crashing.org>; Mon, 30 Nov 2009 18:47:29
 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1]) by
 d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
 nAUDekHk000899 for <benh@kernel.crashing.org>; Mon, 30 Nov 2009 08:40:46
 -0500
Received: from tux1.beaverton.ibm.com (elm3a169.beaverton.ibm.com
 [9.47.66.169]) by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with
 ESMTP id nAUDejp3000891; Mon, 30 Nov 2009 08:40:45 -0500
Received: by tux1.beaverton.ibm.com (Postfix, from userid 501) id
 0304E13E832; Mon, 30 Nov 2009 15:47:27 -0800 (PST)
Date: Mon, 30 Nov 2009 15:47:27 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] therm_adt746x: Record pwm invert bit at module load time
Message-ID: <20091130234727.GA10295@tux1.beaverton.ibm.com>
Reply-To: djwong@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Content-Transfer-Encoding: 7bit

In commit 0512a9a8e277a9de2820211eef964473b714ae65, we unilaterally zero the
"pwm invert" bit in the fan behavior configuration register.  On my PowerBook
G4, this results in the fans going to full speed at low temperature and
shutting off at high temperature because the pwm invert bit is supposed to be
set.

Therefore, record the pwm invert bit at driver load time, and write the bit
into the fan behavior control register.  This restores correct behavior on my
PBG4 and should work around the bit being set to the wrong value after
suspend/resume (which is what the original patch was trying to fix).  It also
fixes a minor omission where the pwm invert bit correction is NOT performed
when switching into automatic mode.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/macintosh/therm_adt746x.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 556f0fe..386a797 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -79,6 +79,7 @@ struct thermostat {
 	u8			limits[3];
 	int			last_speed[2];
 	int			last_var[2];
+	int			pwm_inv[2];
 };
 
 static enum {ADT7460, ADT7467} therm_type;
@@ -229,19 +230,23 @@ static void write_fan_speed(struct thermostat *th, int speed, int fan)
 	
 	if (speed >= 0) {
 		manual = read_reg(th, MANUAL_MODE[fan]);
+		manual &= ~INVERT_MASK;
 		write_reg(th, MANUAL_MODE[fan],
-			(manual|MANUAL_MASK) & (~INVERT_MASK));
+			manual | MANUAL_MASK | th->pwm_inv[fan]);
 		write_reg(th, FAN_SPD_SET[fan], speed);
 	} else {
 		/* back to automatic */
 		if(therm_type == ADT7460) {
 			manual = read_reg(th,
 				MANUAL_MODE[fan]) & (~MANUAL_MASK);
-
+			manual &= ~INVERT_MASK;
+			manual |= th->pwm_inv[fan];
 			write_reg(th,
 				MANUAL_MODE[fan], manual|REM_CONTROL[fan]);
 		} else {
 			manual = read_reg(th, MANUAL_MODE[fan]);
+			manual &= ~INVERT_MASK;
+			manual |= th->pwm_inv[fan];
 			write_reg(th, MANUAL_MODE[fan], manual&(~AUTO_MASK));
 		}
 	}
@@ -418,6 +423,10 @@ static int probe_thermostat(struct i2c_client *client,
 
 	thermostat = th;
 
+	/* record invert bit status because fw can corrupt it after suspend */
+	th->pwm_inv[0] = read_reg(th, MANUAL_MODE[0]) & INVERT_MASK;
+	th->pwm_inv[1] = read_reg(th, MANUAL_MODE[1]) & INVERT_MASK;
+
 	/* be sure to really write fan speed the first time */
 	th->last_speed[0] = -2;
 	th->last_speed[1] = -2;

--=-55uCn9n1hiMisPC0Yg1d--
