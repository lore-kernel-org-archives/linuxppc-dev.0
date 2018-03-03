Return-Path: <Alexander.Levin@microsoft.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0118.outbound.protection.outlook.com [104.47.33.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zv1985DL6zDrL8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 09:31:05 +1100 (AEDT)
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Arnaldo
 Carvalho de Melo <acme@redhat.com>, Sasha Levin
 <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe location is
 at function entry
Date: Sat, 3 Mar 2018 22:27:58 +0000
Message-ID: <20180303222716.26640-5-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]

kretprobes can be registered by specifying an absolute address or by
specifying offset to a symbol. However, we need to ensure this falls at
function entry so as to be able to determine the return address.

Validate the same during kretprobe registration. By default, there
should not be any offset from a function entry, as determined through a
kallsyms_lookup(). Introduce arch_function_offset_within_entry() as a
way for architectures to override this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/f1583bc4839a3862cfc2acefcc56f9c8837fa2ba.148=
7770934.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/kprobes.h |  1 +
 kernel/kprobes.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e23392517db9..56a998f34bdd 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -266,6 +266,7 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern bool arch_function_offset_within_entry(unsigned long offset);
=20
 extern bool within_kprobe_blacklist(unsigned long addr);
=20
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a1a07cf1101f..2ede39e4227f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1834,12 +1834,25 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
=20
+bool __weak arch_function_offset_within_entry(unsigned long offset)
+{
+	return !offset;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret =3D 0;
 	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
+	unsigned long offset;
+
+	addr =3D kprobe_addr(&rp->kp);
+	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
+		return -EINVAL;
+
+	if (!arch_function_offset_within_entry(offset))
+		return -EINVAL;
=20
 	if (kretprobe_blacklist_size) {
 		addr =3D kprobe_addr(&rp->kp);
--=20
2.14.1
