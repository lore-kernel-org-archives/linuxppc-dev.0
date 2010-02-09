Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: [PATCH] Restrict initial stack space expansion to rlimit
In-reply-to: <20100208161014.7C6D.A69D9226@jp.fujitsu.com>
References: <20100208145240.FB58.A69D9226@jp.fujitsu.com>
	<2375c9f91002072307h4af1ba6dw1b7a598582991dc4@mail.gmail.com>
	<20100208161014.7C6D.A69D9226@jp.fujitsu.com>
Date: Tue, 09 Feb 2010 17:11:25 +1100
Message-ID: <1273.1265695885@neuling.org>
Cc: stable@kernel.org, aeb@cwi.nl, Oleg Nesterov <oleg@redhat.com>,
	miltonm@bga.com, James Morris <jmorris@namei.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Serge Hallyn <serue@us.ibm.com>, linux-fsdevel@vger.kernel.org,
	Americo Wang <xiyou.wangcong@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reserving stack space for a new process, make sure we're not
attempting to expand the stack by more than rlimit allows.

This fixes a bug caused by b6a2fea39318e43fee84fa7b0b90d68bed92d2ba "mm:
variable length argument support" and unmasked by
fc63cf237078c86214abcb2ee9926d8ad289da9b "exec: setup_arg_pages() fails
to return errors".  This bug means when limiting the stack to less the
20*PAGE_SIZE (eg. 80K on 4K pages or 'ulimit -s 79') all processes will
be killed before they start.  This is particularly bad with 64K pages,
where a ulimit below 1280K will kill every process.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@kernel.org
---
Attempts to answer comments from Kosaki Motohiro.

Tested on PPC only, hence !CONFIG_STACK_GROWSUP.  Someone should
probably ACK for an arch with CONFIG_STACK_GROWSUP.

As noted, stable needs the same patch, but 2.6.32 doesn't have the
rlimit() helper.

 fs/exec.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: linux-2.6-ozlabs/fs/exec.c
===================================================================
--- linux-2.6-ozlabs.orig/fs/exec.c
+++ linux-2.6-ozlabs/fs/exec.c
@@ -555,6 +555,7 @@ static int shift_arg_pages(struct vm_are
 }
 
 #define EXTRA_STACK_VM_PAGES	20	/* random */
+#define ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
@@ -570,7 +571,7 @@ int setup_arg_pages(struct linux_binprm 
 	struct vm_area_struct *vma = bprm->vma;
 	struct vm_area_struct *prev = NULL;
 	unsigned long vm_flags;
-	unsigned long stack_base;
+	unsigned long stack_base, stack_expand, stack_expand_lim, stack_size;
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size to 1GB */
@@ -627,10 +628,24 @@ int setup_arg_pages(struct linux_binprm 
 			goto out_unlock;
 	}
 
+	stack_expand = EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_size = vma->vm_end - vma->vm_start;
+	if (rlimit(RLIMIT_STACK) < stack_size)
+		stack_expand_lim = 0; /* don't shrick the stack */
+	else
+		/*
+		 * Align this down to a page boundary as expand_stack
+		 * will align it up.
+		 */
+		stack_expand_lim = ALIGN_DOWN(rlimit(RLIMIT_STACK) - stack_size,
+					      PAGE_SIZE);
+	/* Initial stack must not cause stack overflow. */
+	if (stack_expand > stack_expand_lim)
+		stack_expand = stack_expand_lim;
 #ifdef CONFIG_STACK_GROWSUP
-	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_base = vma->vm_end + stack_expand;
 #else
-	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_base = vma->vm_start - stack_expand;
 #endif
 	ret = expand_stack(vma, stack_base);
 	if (ret)
