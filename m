Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vpPr5161zDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 06:30:07 +1000 (AEST)
Date: Mon, 28 May 2018 21:30:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] [powerpc] arch_ptrace() uses of access_ok() are
 pointless
Message-ID: <20180528203002.GD30522@ZenIV.linux.org.uk>
References: <20180527223403.GT30522@ZenIV.linux.org.uk>
 <CA+7wUswhpVRQ4yECc-Zh9djHxiT=9-ALuP7_=mfLMtU-NXDnfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+7wUswhpVRQ4yECc-Zh9djHxiT=9-ALuP7_=mfLMtU-NXDnfg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Maybe this is just an RFC, but:
> 
>   CALL    ../arch/powerpc/kernel/systbl_chk.sh
> ../arch/powerpc/kernel/ptrace.c: In function ‘arch_ptrace’:
> ../arch/powerpc/kernel/ptrace.c:3086:4: error: expected ‘)’ before ‘return’
>     return -EFAULT;
>     ^~~~~~

and the same a few lines later.  What's more, those 'unlikely' are pointless
there.  Fixed variant follows; only build-tested, though.

make it use copy_{from,to}_user(), rather than access_ok() +
__copy_...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/ptrace.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d23cf632edf0..f557322621e0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3081,27 +3081,19 @@ long arch_ptrace(struct task_struct *child, long request,
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
-		if (!access_ok(VERIFY_WRITE, datavp,
-			       sizeof(struct ppc_debug_info)))
+		if (copy_to_user(datavp, &dbginfo,
+				     sizeof(struct ppc_debug_info)))
 			return -EFAULT;
-		ret = __copy_to_user(datavp, &dbginfo,
-				     sizeof(struct ppc_debug_info)) ?
-		      -EFAULT : 0;
-		break;
+		return 0;
 	}
 
 	case PPC_PTRACE_SETHWDEBUG: {
 		struct ppc_hw_breakpoint bp_info;
 
-		if (!access_ok(VERIFY_READ, datavp,
-			       sizeof(struct ppc_hw_breakpoint)))
-			return -EFAULT;
-		ret = __copy_from_user(&bp_info, datavp,
-				       sizeof(struct ppc_hw_breakpoint)) ?
-		      -EFAULT : 0;
-		if (!ret)
-			ret = ppc_set_hwdebug(child, &bp_info);
-		break;
+		if (copy_from_user(&bp_info, datavp,
+				       sizeof(struct ppc_hw_breakpoint)))
+		      return -EFAULT;
+		return ppc_set_hwdebug(child, &bp_info);
 	}
 
 	case PPC_PTRACE_DELHWDEBUG: {
-- 
2.11.0
