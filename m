Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F304B7C38
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 25/27] Fix trace.h
Date: Fri, 30 Oct 2009 16:47:25 +0100
Message-Id: <1256917647-6200-26-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like the variable "pc" is defined. At least the current code always
failed on me stating that "pc" is already defined somewhere else.

Let's use _pc instead, because that doesn't collide.

Is this the right approach? Does it break on 440 too? If not, why not?

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/trace.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 67f219d..a8e8400 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -12,8 +12,8 @@
  * Tracepoint for guest mode entry.
  */
 TRACE_EVENT(kvm_ppc_instr,
-	TP_PROTO(unsigned int inst, unsigned long pc, unsigned int emulate),
-	TP_ARGS(inst, pc, emulate),
+	TP_PROTO(unsigned int inst, unsigned long _pc, unsigned int emulate),
+	TP_ARGS(inst, _pc, emulate),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	inst		)
@@ -23,7 +23,7 @@ TRACE_EVENT(kvm_ppc_instr,
 
 	TP_fast_assign(
 		__entry->inst		= inst;
-		__entry->pc		= pc;
+		__entry->pc		= _pc;
 		__entry->emulate	= emulate;
 	),
 
-- 
1.6.0.2
