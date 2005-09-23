Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 861C868336
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Sep 2005 01:54:26 +1000 (EST)
In-Reply-To: <20050923152242.BE6F62400135@mwinf0609.wanadoo.fr>
References: <20050923152242.BE6F62400135@mwinf0609.wanadoo.fr>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20812E62-A1C7-4711-A2EA-F8E83C1BA9F3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 23 Sep 2005 10:54:36 -0500
To: "Nicolas DET" <det.nicolas@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Sven Luther <sl@bplan-gmbh.de>, David Holm <dholm@gentoo.org>
Subject: Re: Tiny patch for cputable.c -> 750CXe support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is overkill for what you want.

First you are changing 82202 which is listed as a 750CX to be  
reported as a 750CXe. Second, why not just add in the one case for  
00083311 which is missing.  Finally, we shouldn't put the revision  
info into the cpu_name unless it actually matters.  Seeing as the  
cpu_features fields are all the same for all 750CXe parts there is no  
need to distinguish them, we only need to ensure a match occurs.

Your patch really should be something like:

+    {    /* 750CXe rev 3.1 */
+        .pvr_mask         = 0xffff0fff,
+        .pvr_value        = 0x00080311,
+        .cpu_name        = "750CXe",
+        .cpu_features        = CPU_FTR_COMMON |
+            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+        .cpu_user_features    = COMMON_PPC,
+        .icache_bsize        = 32,
+        .dcache_bsize        = 32,
+        .num_pmcs        = 4,
+        .cpu_setup        = __setup_cpu_750cx
+    },

- kumar


On Sep 23, 2005, at 11:22 AM, Nicolas DET wrote:

> Hello,
>
> You can find enclosed or at
> http://arrakin.homedns.org/~nicolas/cputable_750CXe_2.6.14.rc1.diff
>
> A tiny patch which alow to correctly recognized every (let's hope)
> 750CXe
> cpus.
> Tested on my system (750 CXe rev 3.1, PVR: 0008 3311).
>
> Feel free to comment and review it.
>
> By the way, a nice 750CXe PVR summary can be found there:
> http://www-306.ibm.com/chips/techlib/techlib.nsf/techdocs/ 
> 291C8D0EF3EAEC
> 1687256B72005C745C#C1
>
> Regards,
> -- 
> Nicolas DET
> MorphOS & Linux developer
>
> <cputable_750CXe_2.6.14.rc1.diff>
> <ATT368009.txt>
>
