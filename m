Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0189.hostedemail.com
	[216.40.44.189]) by ozlabs.org (Postfix) with ESMTP id C36F4B7007
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Apr 2011 01:02:57 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 22DB95E6DD
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2011 14:55:38 +0000 (UTC)
References: <1302860993-28829-1-git-send-email-sr@denx.de>
In-Reply-To: <1302860993-28829-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----PJJF1HSO7OMA9XS7PQH2K5FIU6I3Q9"
Subject: Re: [PATCH] powerpc: Don't write protect kernel text with
	CONFIG_DYNAMIC_FTRACE enabled
From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 15 Apr 2011 10:51:31 -0400
To: Stefan Roese <sr@denx.de>,linuxppc-dev@ozlabs.org
Message-ID: <c113ce7d-2e6a-48ea-a3e0-b3f9b846ac14@email.android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------PJJF1HSO7OMA9XS7PQH2K5FIU6I3Q9
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Stefan Roese <sr@denx.de> wrote:

This problem was noticed on an MPC855T platform. Ftrace did oops when trying to write to the kernel text segment. Many thanks to Joakim for finding the root cause of this problem. Signed-off-by: Stefan Roese <sr@denx.de> Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> Cc: Steven Rostedt <rostedt@goodmis.org> --- arch/powerpc/include/asm/pte-common.h | 2 +- 1 files changed, 1 insertions(+), 1 deletions(-) diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h index 811f04a..8d1569c 100644 --- a/arch/powerpc/include/asm/pte-common.h +++ b/arch/powerpc/include/asm/pte-common.h @@ -162,7 +162,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void); * on platforms where such control is possible. */ #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\ -	defined(CONFIG_KPROBES) +	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE) #define
PAGE_KERNEL_TEXT	PAGE_KERNEL_X #else #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX -- 1.7.4.4 


This is fine for a work around but you should take a look at what x86 does for this.

-- Steve 
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------PJJF1HSO7OMA9XS7PQH2K5FIU6I3Q9
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><div class="gmail_quote">Stefan Roese &lt;sr@denx.de&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; ">This problem was noticed on an MPC855T platform. Ftrace did oops when trying to write to the kernel text segment.

Many thanks to Joakim for finding the root cause of this problem.

Signed-off-by: Stefan Roese &lt;sr@denx.de&gt;
Cc: Joakim Tjernlund &lt;joakim.tjernlund@transmode.se&gt;
Cc: Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt;
Cc: Steven Rostedt &lt;rostedt@goodmis.org&gt;
---
 arch/powerpc/include/asm/pte-common.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h index 811f04a..8d1569c 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -162,7 +162,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  * on platforms where such control is possible.
  */
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES)
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-- 
<a href="http://1.7.4.4">1.7.4.4</a>
</pre></blockquote></div><br clear="all">This is fine for a work around but you should take a look at what x86 does for this.<br>
<br>
-- Steve <br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.</body></html>
------PJJF1HSO7OMA9XS7PQH2K5FIU6I3Q9--
