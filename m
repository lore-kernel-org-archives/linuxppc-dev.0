Return-Path: <bastian@waldi.eu.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D0F73B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 19:33:19 +1000 (EST)
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 39E73DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 19:33:18 +1000 (EST)
Date: Thu, 13 Aug 2009 11:30:45 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Remove SMP warning from PowerMac cpufreq
Message-ID: <20090813093045.GA7085@wavehammer.waldi.eu.org>
References: <20090811093931.GA15940@wavehammer.waldi.eu.org>
	<1250144098.3587.111.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1250144098.3587.111.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 13, 2009 at 04:14:58PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-08-11 at 11:39 +0200, Bastian Blank wrote:
> > This patch just disables this driver on SMP kernels, as it is obviously
> > not supported.
> Why not remove the #error instead ? :-) I don't think it's still
> meaningful, especially since we use the timebase for delays nowadays
> which doesn't depend on the CPU frequency...

Your call. Take this one:

The build of a PowerMac 32bit kernel currently fails with

error: #warning "WARNING, CPUFREQ not recommended on SMP kernels"

Thie patch removes the not longer applicable SMP warning from the
PowerMac cpufreq code.

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index 65c585b..08d94e4 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -44,14 +44,6 @@
  */
 #undef DEBUG_FREQ
 
-/*
- * There is a problem with the core cpufreq code on SMP kernels,
- * it won't recalculate the Bogomips properly
- */
-#ifdef CONFIG_SMP
-#warning "WARNING, CPUFREQ not recommended on SMP kernels"
-#endif
-
 extern void low_choose_7447a_dfs(int dfs);
 extern void low_choose_750fx_pll(int pll);
 extern void low_sleep_handler(void);
-- 
Those who hate and fight must stop themselves -- otherwise it is not stopped.
		-- Spock, "Day of the Dove", stardate unknown
