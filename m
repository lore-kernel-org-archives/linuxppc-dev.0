Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id BD0232C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jul 2013 06:34:50 +1000 (EST)
Date: Sat, 20 Jul 2013 23:33:46 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: therm_pm72 units, interface
Message-ID: <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374275809.19894.562.camel@pasglop>
Cc: Jan Engelhardt <jengelh@inai.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sat, Jul 20, 2013 at 09:16:49AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-07-19 at 20:43 +0300, Aaro Koskinen wrote:
> > I booted a Xserve today with 3.11-rc1, and noticed the noise is coming
> > from slots-fan (PCI fan?) which is always 99%, although the slots-temp is
> > just 33. Is it on purpose the rm31 slots PID params are totally different
> > from therm_pm72 slots params? It seems like they have been copied from
> > pm72 "drive bay" PID params instead.
> 
> Could be my mistake. What happens if you change them to match the old code ?

I tried the change below (use SLOTS_PID_* values from therm_pm72.h),
and the noise level is considerably lower. The slots-fan stays at 19%,
and slots-temp rises to 42'C but not higher after running couple of hours.

diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index 0b9a79b..82fc86a 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -439,15 +439,15 @@ static void backside_setup_pid(void)
 
 /* Slots fan */
 static const struct wf_pid_param slots_param = {
-	.interval	= 5,
-	.history_len	= 2,
-	.gd		= 30 << 20,
-	.gp		= 5 << 20,
-	.gr		= 0,
-	.itarget	= 40 << 16,
-	.additive	= 1,
-	.min		= 300,
-	.max		= 4000,
+	.interval	= 1,
+	.history_len	= 20,
+	.gd		= 0,
+	.gp		= 0,
+	.gr		= 0x00100000,
+	.itarget	= 3200000,
+	.additive	= 0,
+	.min		= 20,
+	.max		= 100,
 };
 
 static void slots_fan_tick(void)
