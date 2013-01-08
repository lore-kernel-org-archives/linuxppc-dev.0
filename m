Return-Path: <anton@samba.org>
Date: Wed, 9 Jan 2013 10:47:36 +1100
From: Anton Blanchard <anton@samba.org>
To: eparis@redhat.com, viro@zeniv.linux.org.uk, benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH 2/4] powerpc: Remove static branch prediction in 64bit
 traced syscall path
Message-ID: <20130109104736.063d143b@kryten>
In-Reply-To: <20130109104617.74e995a5@kryten>
References: <20130109104617.74e995a5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Some distros enable auditing by default which forces us through the
syscall trace path. Remove the static branch prediction in our 64bit
syscall handler and let the hardware do the prediction.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/entry_64.S
===================================================================
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -149,7 +149,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
-	bne-	syscall_dotrace
+	bne	syscall_dotrace
 .Lsyscall_dotrace_cont:
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
