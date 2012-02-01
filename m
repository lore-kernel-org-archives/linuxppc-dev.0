Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25EFD104785
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 05:56:29 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 1 Feb 2012 11:56:26 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2EA5F19D805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 11:55:31 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q11ItDLw044994
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 11:55:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q11ItBp1030145
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 11:55:12 -0700
Date: Wed, 1 Feb 2012 10:55:10 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Define cpus_in_crash only for SMP kernels
Message-ID: <20120201185510.GA8542@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, paulus@samba.org, anton@samba.org,
 ben@decadent.org.uk
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The variable cpus_in_crash gets a defined-but-not-used warning when
CONFIG_SMP=n, so fix by placing the variable under ifdef.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 28be345..eb3384e 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -46,7 +46,9 @@
 
 /* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
+#ifdef CONFIG_SMP
 static atomic_t cpus_in_crash;
+#endif /* #ifdef CONFIG_SMP */
 static int time_to_dump;
 
 #define CRASH_HANDLER_MAX 3
