Message-ID: <410E85EE.8050707@mvista.com>
Date: Mon, 02 Aug 2004 11:20:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Workaround for 745x data corruption bug
References: <1091291276.987.57.camel@localhost>
In-Reply-To: <1091291276.987.57.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------090609080203030905040801"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090609080203030905040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Cox wrote:

>Recently released errata documents show a new bug in all 745x family
>processors. This can cause data corruption when memory is mapped
>non-coherent and one of these conditions is true:
>1) L2 hardware prefetch is enabled (as it is in Linux)
>2) instructions and data are fetched from the same or adjacent cache
>lines.
>
>The attached patch adds a workaround, by setting CPU_FTR_NEED_COHERENT
>on all 745x processors.
>

Well that sucks (the bug, not the patch :).  Many people like to turn
off coherency when using Marvell host bridges b/c they struggle
performance-wise with coherency on (at least on some versions).

One change to the patch, though.  According to the 7447/7457 errata doc,
rev 1.2 doesn't have the bug.  The attached patch accounts for that.

Mark
--

--------------090609080203030905040801
Content-Type: text/plain;
 name="coherent2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coherent2.patch"

===== arch/ppc/kernel/cputable.c 1.25 vs edited =====
--- 1.25/arch/ppc/kernel/cputable.c	2004-08-01 17:30:29 -07:00
+++ edited/arch/ppc/kernel/cputable.c	2004-08-02 11:12:37 -07:00
@@ -352,7 +352,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+	CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x

--------------090609080203030905040801--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
