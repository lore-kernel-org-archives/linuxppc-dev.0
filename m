Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqcCg613BzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 22:35:43 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id j186so9941123pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 05:35:43 -0700 (PDT)
Date: Sat, 17 Jun 2017 22:35:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/5] watchdog: split up config options
Message-ID: <20170617223522.66c0ad88@roar.ozlabs.ibm.com>
In-Reply-To: <20170616065715.18390-4-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
 <20170616065715.18390-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jun 2017 16:57:13 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Split SOFTLOCKUP_DETECTOR from LOCKUP_DETECTOR, and split
> HARDLOCKUP_DETECTOR_PERF from HARDLOCKUP_DETECTOR.
> 
> LOCKUP_DETECTOR implies the general boot, sysctl, and programming
> interfaces for the lockup detectors.
> 
> An architecture that wants to use a hard lockup detector must define
> HAVE_HARDLOCKUP_DETECTOR_PERF or HAVE_HARDLOCKUP_DETECTOR_ARCH.
> 
> Alternatively an arch can define HAVE_NMI_WATCHDOG, which provides
> the minimum arch_touch_nmi_watchdog, and it otherwise does its own
> thing and does not implement the LOCKUP_DETECTOR interfaces.
> 
> sparc is unusual in that it has started to implement some of the
> interfaces, but not fully yet. It should probably be converted to
> a full HAVE_HARDLOCKUP_DETECTOR_ARCH.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I haven't worked out the nm10300 Kconfig warning, but in the meantime
Andrew can you fold this patch in please?

Thanks,
Nick

---
 arch/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 878addc6f141..d1cd10f1c087 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -198,9 +198,6 @@ config HAVE_KPROBES_ON_FTRACE
 config HAVE_NMI
 	bool
 
-config HAVE_NMI_WATCHDOG
-	depends on HAVE_NMI
-	bool
 #
 # An arch should select this if it provides all these things:
 #
@@ -288,7 +285,6 @@ config HAVE_PERF_EVENTS_NMI
 	  subsystem.  Also has support for calculating CPU cycle events
 	  to determine how many clock cycles in a given period.
 
-
 config HAVE_HARDLOCKUP_DETECTOR_PERF
 	bool
 	depends on HAVE_PERF_EVENTS_NMI
@@ -297,6 +293,7 @@ config HAVE_HARDLOCKUP_DETECTOR_PERF
 	  detector. Must define HAVE_PERF_EVENTS_NMI.
 
 config HAVE_NMI_WATCHDOG
+	depends on HAVE_NMI
 	bool
 	help
 	  The arch provides a low level NMI watchdog. It provides
@@ -310,7 +307,6 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  a superset of the HAVE_NMI_WATCHDOG. It also conforms to config
 	  interfaces and parameters provided by hardlockup detector subsystem.
 
-
 config HAVE_PERF_REGS
 	bool
 	help
-- 
2.11.0
