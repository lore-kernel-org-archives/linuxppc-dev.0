Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Restrict stack space reservation to rlimit
In-reply-to: <18033.1265587672@neuling.org>
References: <3984.1265416993@neuling.org> <20100206042038.GB32246@kryten>
	<10125.1265451732@neuling.org> <18033.1265587672@neuling.org>
Date: Mon, 08 Feb 2010 11:28:43 +1100
Message-ID: <19732.1265588923@neuling.org>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl, James Morris <jmorris@namei.org>,
	miltonm@bga.com, Oleg Nesterov <oleg@redhat.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ollie Wild <aaw@google.com>, WANG Cong <xiyou.wangcong@gmail.com>,
	linux-fsdevel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, stable@kernel.org,
	Anton Blanchard <anton@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reserving stack space for a new process, make sure we're not
attempting to allocate more than rlimit allows.

Also, reserve the same stack size independent of page size.

This fixes a bug cause by b6a2fea39318e43fee84fa7b0b90d68bed92d2ba 
"mm: variable length argument support" and unmasked by
fc63cf237078c86214abcb2ee9926d8ad289da9b 
"exec: setup_arg_pages() fails to return errors".

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---
Update commit message to include patch name and SHA1 of related
patches.  

 fs/exec.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: clone1/fs/exec.c
===================================================================
--- clone1.orig/fs/exec.c
+++ clone1/fs/exec.c
@@ -554,7 +554,7 @@ static int shift_arg_pages(struct vm_are
 	return 0;
 }
 
-#define EXTRA_STACK_VM_PAGES	20	/* random */
+#define EXTRA_STACK_VM_SIZE	81920UL	/* randomly 20 4K pages */
 
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
@@ -627,10 +627,13 @@ int setup_arg_pages(struct linux_binprm 
 			goto out_unlock;
 	}
 
+	stack_base = min(EXTRA_STACK_VM_SIZE,
+			 current->signal->rlim[RLIMIT_STACK].rlim_cur) -
+		PAGE_SIZE;
 #ifdef CONFIG_STACK_GROWSUP
-	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_base = vma->vm_end + stack_base;
 #else
-	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_base = vma->vm_start - stack_base;
 #endif
 	ret = expand_stack(vma, stack_base);
 	if (ret)
