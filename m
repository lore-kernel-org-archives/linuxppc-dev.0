Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F2770DE19A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:40:01 +1000 (EST)
Date: Fri, 23 May 2008 22:40:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] [POWERPC] mpic: fix ambiguous else statement
Message-ID: <20080523184000.GA354@polina.dev.rtsoft.ru>
References: <20080523141541.GA16217@polina.dev.rtsoft.ru>
	<6C9CC80B-8422-4612-BDFF-22DC245F2179@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <6C9CC80B-8422-4612-BDFF-22DC245F2179@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following warning introduced by
commit 475ca391b490a683d66bf19999a8a7a24913f139 (mpic: Deal with bogus NIRQ
in Feature Reporting Register):

  CC      arch/powerpc/sysdev/mpic.o
arch/powerpc/sysdev/mpic.c: In function 'mpic_alloc':
arch/powerpc/sysdev/mpic.c:1146: warning: suggest explicit braces to avoid ambiguous 'else'

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Kumar Gala <galak@kernel.crashing.org>
---

On Fri, May 23, 2008 at 12:56:08PM -0500, Kumar Gala wrote:
>
> On May 23, 2008, at 9:15 AM, Anton Vorontsov wrote:
>
>> This patch fixes following warning introduced by
>> commit 475ca391b490a683d66bf19999a8a7a24913f139 (mpic: Deal with bogus 
>> NIRQ
>> in Feature Reporting Register):
>>
>>  CC      arch/powerpc/sysdev/mpic.o
>> arch/powerpc/sysdev/mpic.c: In function â€˜mpic_allocâ€™:
>> arch/powerpc/sysdev/mpic.c:1146: warning: suggest explicit braces to  
>> avoid ambiguous â€˜elseâ€™
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>
> as pointed at to me if you set LANG=C in your environment gcc will stop 
> spitting out the funny chars.

Ok, resending with Ack and non-unicode gcc warning. Also Cc'ing Paul
(forgot last time).

 arch/powerpc/sysdev/mpic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f99f81a..a281341 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1143,13 +1143,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
-	if (isu_size == 0)
+	if (isu_size == 0) {
 		if (flags & MPIC_BROKEN_FRR_NIRQS)
 			mpic->num_sources = mpic->irq_count;
 		else
 			mpic->num_sources =
 				((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
 				 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
+	}
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-- 
1.5.5.1
