Date: Wed, 30 Jun 2004 15:14:31 +0200 (CEST)
From: Christiaan Welvaart <cjw@daneel.dyndns.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	John Steele Scott <toojays@toojays.net>
Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
In-Reply-To: <200406202044.01554.toojays@toojays.net>
Message-ID: <Pine.LNX.4.58.0406301456050.17875@zem.cjw.nep>
References: <200406051846.50718.toojays@toojays.net> <200406191250.18936.toojays@toojays.net>
 <1087619961.9046.301.camel@gaston> <200406202044.01554.toojays@toojays.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 20 Jun 2004, John Steele Scott wrote:

> Okay, here it is:
> http://www.toojays.net/~toojays/misc/7447a_cpufreq_20040619a.patch

Tested on my 1067MHz iBook that apparently doesn't need the voltage
tweak - it still works.

The patch breaks (32-bit) kernel builds for G5s etc (non-CONFIG_6xx).
Patch below fixes that.


    Christiaan


--- linux-2.6.7/arch/ppc/platforms/pmac_cpufreq.c.bak   2004-06-25 22:35:25.094647214 +0200
+++ linux-2.6.7/arch/ppc/platforms/pmac_cpufreq.c       2004-06-26 04:13:19.182914571 +0200
@@ -128,6 +128,7 @@
 /* Switch CPU speed using DFS */
 static int __pmac dfs_set_cpu_speed(int low_speed)
 {
+#ifdef CONFIG_6xx
        if (low_speed == 0) {
                /* ramping up, set voltage first */
                pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
@@ -150,6 +151,7 @@
                /* ramping up, disable aack delay last */
                pmac_call_feature(PMAC_FTR_AACK_DELAY_ENABLE, NULL, 0, 0);
        }
+#endif

        return 0;
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
