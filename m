Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 029FE1A076A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:12:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 28 Jul 2015 11:12:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2A17F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:12:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6S1CFjW57082070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:12:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6S1BpTq029710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:11:51 +1000
Date: Tue, 28 Jul 2015 11:11:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: eeh-powernv.c: Unbalanced IRQ warning
Message-ID: <20150728011126.GA17094@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1437982623.6262.56.camel@axtens.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <1437982623.6262.56.camel@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2015 at 05:37:03PM +1000, Daniel Axtens wrote:
>Hi Alistair,
>
>I've just rebased some CAPI patches on top of 4.2-rc4 and I'm getting a
>new WARN relating to IRQs in EEH, which I believe is related to your
>patch 79231448c929 ("powernv/eeh: Update the EEH code to use the opal
>irq domain").
>
>This is what I see after injecting a PHB fence on a CAPI card.
>
>[  126.022390] EEH: Notify device driver to resume
>[  126.022421] Unbalanced enable for IRQ 17
>[  126.022432] ------------[ cut here ]------------
>[  126.022440] WARNING: at /scratch/dja/linux-capi/kernel/irq/manage.c:511
>[  126.022451] Modules linked in: cxl
>[  126.022465] CPU: 3 PID: 123 Comm: eehd Not tainted 4.2.0-rc4-00013-g86caa74-dirty #86
>[  126.022479] task: c000000751b0af50 ti: c000000751b94000 task.ti: c000000751b94000
>[  126.022493] NIP: c0000000000f1760 LR: c0000000000f175c CTR: c0000000006000c0
>[  126.022509] REGS: c000000751b97710 TRAP: 0700   Not tainted  (4.2.0-rc4-00013-g86caa74-dirty)
>[  126.022522] MSR: 9000000100029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 22008022  XER: 20000000
>[  126.022560] CFAR: c0000000008a8680 SOFTE: 0 
>GPR00: c0000000000f175c c000000751b97990 c000000000e80c00 000000000000001c 
>GPR04: 0000000000000000 000000000000002c 00000000000000ff 000000000000001f 
>GPR08: c000000000d86cc0 c000000000d86cb8 c000000000d86cc0 0000000000000000 
>GPR12: 0000000042008028 c00000000fdc0d80 c0000000000bb460 c000000758162580 
>GPR16: 0000000000000000 0000000000000000 c00000074d3a1000 c000000000b35240 
>GPR20: c000000000b35210 c000000000b35278 c000000000b352e8 c000000000b2e2a8 
>GPR24: c0000000008d35b8 c0000000008d3510 c000000000efa408 c000000751b97c10 
>GPR28: 0000000000000000 c000000000d7a330 0000000000000011 c000000751eaec00 
>[  126.022735] NIP [c0000000000f1760] .__enable_irq+0x30/0xd0
>[  126.022747] LR [c0000000000f175c] .__enable_irq+0x2c/0xd0
>[  126.022756] Call Trace:
>[  126.022764] [c000000751b97990] [c0000000000f175c] .__enable_irq+0x2c/0xd0 (unreliable)
>[  126.022780] [c000000751b97a20] [c0000000000f1848] .enable_irq+0x48/0x90
>[  126.022796] [c000000751b97ab0] [c00000000006ab00] .pnv_eeh_next_error+0x1f0/0x6f0
>[  126.022812] [c000000751b97ba0] [c000000000035908] .eeh_handle_event+0xb8/0x2f0
>[  126.022827] [c000000751b97c70] [c000000000035cf8] .eeh_event_handler+0x1b8/0x1c0
>[  126.022844] [c000000751b97d30] [c0000000000bb564] .kthread+0x104/0x130
>[  126.022860] [c000000751b97e30] [c0000000000095a4] .ret_from_kernel_thread+0x58/0xb4
>[  126.022874] Instruction dump:
>[  126.022882] 7c0802a6 fbe1fff8 7c7f1b78 f8010010 f821ff71 81230170 2f890000 409e0034 
>[  126.022915] 3c62ffcd 3863a730 487b6ec9 60000000 <0fe00000> 38210090 e8010010 ebe1fff8 
>[  126.022935] ---[ end trace 26e6323a0534e98d ]---
>
>manage.c:511 suggests that this is probably the result of the IRQ being
>enabled when it's already enabled.
>
>Do you know what might be causing this and how it might be fixed?
>Thanks in advance!
>

Daniel, could you check if the attached patch fixes the issue? If it helps,
I'll clean it up and send it out for review together other cleanup patches.

Thanks,
Gavin



--PEIAKu/WMn1b1Hv9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-powernv-Reenable-EEH-IRQ-if-necessary.patch"

>From 64484296abf5a6419e9c31d7b394f92e541d73d3 Mon Sep 17 00:00:00 2001
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 28 Jul 2015 10:58:29 +1000
Subject: [PATCH] powerpc/powernv: Reenable EEH IRQ if necessary

pnv_eeh_next_error() is called to handle EEH special event. The
function can be called for multiple times for one EEH special
event. So we can't enable the EEH IRQ without limitation. Otherwise,
the following warning would be seen because of attempt to enable
IRQ, which has been enabled.

The patch introduces another flag to track the EEH IRQ enablement
state and doesn't enable it if it's already enabled.

EEH: Notify device driver to resume
Unbalanced enable for IRQ 17
------------[ cut here ]------------
WARNING: at /scratch/dja/linux-capi/kernel/irq/manage.c:511
Modules linked in: cxl
   :
NIP [c0000000000f1760] .__enable_irq+0x30/0xd0
LR [c0000000000f175c] .__enable_irq+0x2c/0xd0
Call Trace:
[c000000751b97990] [c0000000000f175c] .__enable_irq+0x2c/0xd0 (unreliable)
[c000000751b97a20] [c0000000000f1848] .enable_irq+0x48/0x90
[c000000751b97ab0] [c00000000006ab00] .pnv_eeh_next_error+0x1f0/0x6f0
[c000000751b97ba0] [c000000000035908] .eeh_handle_event+0xb8/0x2f0
[c000000751b97c70] [c000000000035cf8] .eeh_event_handler+0x1b8/0x1c0
[c000000751b97d30] [c0000000000bb564] .kthread+0x104/0x130
[c000000751b97e30] [c0000000000095a4] .ret_from_kernel_thread+0x58/0xb4

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 5cf5e6e..28ac8d1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -41,6 +41,7 @@
 #include "pci.h"
 
 static bool pnv_eeh_nb_init = false;
+static bool pnv_eeh_irq_enabled = false;
 static int eeh_event_irq = -EINVAL;
 
 /**
@@ -98,7 +99,10 @@ static irqreturn_t pnv_eeh_event(int irq, void *data)
 	 * finished processing the outstanding ones. Event processing
 	 * gets unmasked in next_error() if EEH is enabled.
 	 */
-	disable_irq_nosync(irq);
+	if (pnv_eeh_irq_enabled) {
+		disable_irq_nosync(irq);
+		pnv_eeh_irq_enabled = false;
+	}
 
 	if (eeh_enabled())
 		eeh_send_failure_event(NULL);
@@ -243,11 +247,14 @@ static int pnv_eeh_post_init(void)
 			return ret;
 		}
 
+		pnv_eeh_irq_enabled = true;
 		pnv_eeh_nb_init = true;
 	}
 
-	if (!eeh_enabled())
+	if (!eeh_enabled() && pnv_eeh_irq_enabled) {
 		disable_irq(eeh_event_irq);
+		pnv_eeh_irq_enabled = false;
+	}
 
 	list_for_each_entry(hose, &hose_list, list_node) {
 		phb = hose->private_data;
@@ -1478,8 +1485,10 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	}
 
 	/* Unmask the event */
-	if (eeh_enabled())
+	if (eeh_enabled() && !pnv_eeh_irq_enabled) {
 		enable_irq(eeh_event_irq);
+		pnv_eeh_irq_enabled = true;
+	}
 
 	return ret;
 }
-- 
2.1.0


--PEIAKu/WMn1b1Hv9--
