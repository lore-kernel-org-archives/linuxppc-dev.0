Return-Path: <srs0=fawz=iz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411h834HlWzF33p
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:08:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 411h833ng0z98st
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:08:35 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 411h830BtKz9s01
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2018 20:08:34 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57A4VHO079221
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2018 06:08:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jf0vcwqbe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Jun 2018 06:08:32 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 11:08:31 +0100
Subject: [v2 PATCH 5/5] powerpc/pseries: Fix endainness while restoring of
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 07 Jun 2018 15:38:27 +0530
In-Reply-To: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
References: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152836605787.29173.4384469130105616077.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

r3 in MCE handler.

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

During Machine Check interrupt on pseries platform, register r3 points
RTAS extended event log passed by hypervisor. Since hypervisor uses r3
to pass pointer to rtas log, it stores the original r3 value at the
start of the memory (first 8 bytes) pointed by r3. Since hypervisor
stores this info and rtas log is in BE format, linux should make
sure to restore r3 value in correct endian format.

Without this patch when MCE handler, after recovery, returns to code that
that caused the MCE may end up with Data SLB access interrupt for invalid
address followed by kernel panic or hang.

[   62.878965] Severe Machine check interrupt [Recovered]
[   62.878968]   NIP [d00000000ca301b8]: init_module+0x1b8/0x338 [bork_kernel]
[   62.878969]   Initiator: CPU
[   62.878970]   Error type: SLB [Multihit]
[   62.878971]     Effective address: d00000000ca70000
cpu 0xa: Vector: 380 (Data SLB Access) at [c0000000fc7775b0]
    pc: c0000000009694c0: vsnprintf+0x80/0x480
    lr: c0000000009698e0: vscnprintf+0x20/0x60
    sp: c0000000fc777830
   msr: 8000000002009033
   dar: a803a30c000000d0
  current = 0xc00000000bc9ef00
  paca    = 0xc00000001eca5c00	 softe: 3	 irq_happened: 0x01
    pid   = 8860, comm = insmod
[c0000000fc7778b0] c0000000009698e0 vscnprintf+0x20/0x60
[c0000000fc7778e0] c00000000016b6c4 vprintk_emit+0xb4/0x4b0
[c0000000fc777960] c00000000016d40c vprintk_func+0x5c/0xd0
[c0000000fc777980] c00000000016cbb4 printk+0x38/0x4c
[c0000000fc7779a0] d00000000ca301c0 init_module+0x1c0/0x338 [bork_kernel]
[c0000000fc777a40] c00000000000d9c4 do_one_initcall+0x54/0x230
[c0000000fc777b00] c0000000001b3b74 do_init_module+0x8c/0x248
[c0000000fc777b90] c0000000001b2478 load_module+0x12b8/0x15b0
[c0000000fc777d30] c0000000001b29e8 sys_finit_module+0xa8/0x110
[c0000000fc777e30] c00000000000b204 system_call+0x58/0x6c
--- Exception: c00 (System Call) at 00007fff8bda0644
SP (7fffdfbfe980) is in userspace

This patch fixes this issue.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index afdf05444bc2..cd9446980092 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -360,7 +360,7 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 	}
 
 	savep = __va(regs->gpr[3]);
-	regs->gpr[3] = savep[0];	/* restore original r3 */
+	regs->gpr[3] = be64_to_cpu(savep[0]);	/* restore original r3 */
 
 	/* If it isn't an extended log we can use the per cpu 64bit buffer */
 	h = (struct rtas_error_log *)&savep[1];
