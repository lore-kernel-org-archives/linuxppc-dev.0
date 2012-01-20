Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 786081007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 20:08:35 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Fri, 20 Jan 2012 08:53:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0K93jZY3108908
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 20:03:45 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0K98LAB011181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 20:08:21 +1100
Message-ID: <4F192F01.1030502@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2012 14:38:17 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree
References: <20120120182117.01a6eb5d3cfb3f2bdfb32ae4@canb.auug.org.au>
In-Reply-To: <20120120182117.01a6eb5d3cfb3f2bdfb32ae4@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Trinabh Gupta <g.trinabh@gmail.com>,
 Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/20/2012 12:51 PM, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allmodconfig) failed like this:
> 
> arch/powerpc/platforms/pseries/processor_idle.c:35:6: error: redefinition of 'update_smt_snooze_delay'
> arch/powerpc/include/asm/system.h:230:20: note: previous definition of 'update_smt_snooze_delay' was here
> arch/powerpc/platforms/pseries/processor_idle.c:175:5: error: redefinition of 'pseries_notify_cpuidle_add_cpu'
> arch/powerpc/include/asm/system.h:231:19: note: previous definition of 'pseries_notify_cpuidle_add_cpu' was here
> 
> Caused by commit 707827f3387d ("powerpc/cpuidle: cpuidle driver for
> pSeries").  For this build, CONFIG_PSERIES_IDLE is "m".
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev




Hi Stephen,

We had a discussion on this particular problem on ppcdev list a few
days back and concluded that it is best not have pseries_idle
as a module.

http://old.nabble.com/-PATCH--cpuidle%3A-Default-y-for-pseries-to33118294.html#a33127587

The following patch disables pseries cpuidle driver to be loaded as a
module as there are build problems reported when one is trying to do so.

arch/powerpc/platforms/pseries/processor_idle.c:35:6: error:
redefinition of 'update_smt_snooze_delay'
arch/powerpc/include/asm/system.h:230:20: note:
previous definition of 'update_smt_snooze_delay' was here
arch/powerpc/platforms/pseries/processor_idle.c:175:5:
error: redefinition of 'pseries_notify_cpuidle_add_cpu'
arch/powerpc/include/asm/system.h:231:19: note:
previous definition of 'pseries_notify_cpuidle_add_cpu' was here

Since the above two functions
are used in core power architecture functions (store_smt_snooze_delay
at kernel/sysfs.c and smp_xics_setup_cpu at platforms/pseries/smp.c),
this requires some rework in these interactions. For now please
disable PSERIES_IDLE to be built as a module for now.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig
b/arch/powerpc/platforms/pseries/Kconfig
index ae7b6d4..31f22c1 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -122,7 +122,7 @@ config DTL
 	  Say N if you are unsure.

 config PSERIES_IDLE
-	tristate "Cpuidle driver for pSeries platforms"
+	bool "Cpuidle driver for pSeries platforms"
 	depends on CPU_IDLE
 	depends on PPC_PSERIES
 	default y

Regards,
Deepthi
