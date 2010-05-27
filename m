Return-Path: <ananth@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07825B7D1C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 00:12:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4REAs8X020029
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 08:10:54 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4RECRBr117964
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 08:12:28 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4RECIhJ015075
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 08:12:20 -0600
Date: Thu, 27 May 2010 19:42:03 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH] powerpc: Emulate nop too
Message-ID: <20100527141203.GA20770@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100520124955.GA29903@brick.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

While we are at it, can we also add nop to the list of emulated
instructions?

Ananth
---
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Emulate ori 0,0,0 (nop).

The long winded way is to do:

        case 24:
                rd = (instr >> 21) & 0x1f;
                if (rd != 0)
                        break;
                rb = (instr >> 11) & 0x1f;
                if (rb != 0)
                        break;
                imm = (instr & 0xffff);
                if (imm == 0) {
                        regs->nip += 4;
                        return 1;
                }
                break;

But, the following is more straightforward for this case at least.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/lib/sstep.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-27may/arch/powerpc/lib/sstep.c
===================================================================
--- linux-27may.orig/arch/powerpc/lib/sstep.c
+++ linux-27may/arch/powerpc/lib/sstep.c
@@ -412,6 +412,12 @@ int __kprobes emulate_step(struct pt_reg
 	int err;
 	mm_segment_t oldfs;
 
+	/* ori 0,0,0 is a nop. Emulate that too */
+	if (instr == 0x60000000) {
+		regs->nip += 4;
+		return 1;
+	}
+
 	opcode = instr >> 26;
 	switch (opcode) {
 	case 16:	/* bc */
