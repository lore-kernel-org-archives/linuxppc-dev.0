Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D79C282E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:56:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A13218D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDfJLDoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A13218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbMl6PrFzDqRr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:56:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDfJLDoY"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTcZ3zCPzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:37:02 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 9so7750083pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZORa/d3VWeeKq780Bo75/e3acYkvPcqrS2Qo2eJpis=;
 b=eDfJLDoYAGkwZs8keGEsROvo0jQ1uPqggirL3KBml96M5NEefGQmbncxQzfbDuL9z/
 Q0oFZZy0BlmTH95TDkjYEls/OYsifHPgq+fFZUGLggf0JG5sK6b1Gu8BlnZPjhAd/yTD
 7iPHuB1Pps1IaM5ALhps15LJ6KtufJFtaM4l8Fl04oliere9NTLd+q8K8bvgoylJXs/I
 UFZgrEjZs+vDX/qLTLAUx6jEB2IK70j47gDXjdfUYozRqKVFAduzplqUstYNU9roMF0i
 +xq8iDSlWV/acWXlDQQwAv0eIFjTy01yFZ8mt1uwbmEQWACVnyJqwbom5surmVRj6vjp
 8MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZORa/d3VWeeKq780Bo75/e3acYkvPcqrS2Qo2eJpis=;
 b=Fqno1u8Qe2/JnXXAHySorJtErxfxK3HFNDUiVLKi7KW8vC6kH7g+TiTrRa478WKbd6
 E+nf0yIMtWJ16gQXQBH4OQg9iAeso5+w55vGWRZuh+zciFVgRj+2uBGQytgwu/ze0N+5
 SJCTxKC3KWdD3QCHujcS/T5reDTYd+ibc/IRW/f9Y7T5dvwkWqv0NE8uGSdesgI3lmfs
 eVXsKfEjdVRwzOOH0jdn+OftKqUqa1WnqHSCzDNbfo25Cr9J1oE1op/aBPk24zbGZvae
 u/mwuCjLAO49LM5eE0KsjXpmuCoFdSyi5ltuHSmwZL0m3IqSVzFv83lzlRPqHDtS0lE9
 FMUA==
X-Gm-Message-State: APjAAAU7v0aNXL0jZeDLXzn3mL7Q4eSamWV301TAx+nc1Gesk2FIJZAE
 1Zdd1acABllWs8Czau8IxuBb9JmQ
X-Google-Smtp-Source: APXvYqzUQlDRMfPUwrkX0kTers5v1cS+bTeK/DnK/4rtRcpmkieYCi2aUAu+t2Gyc1VpYrHrqZJtfw==
X-Received: by 2002:a62:388d:: with SMTP id
 f135mr28145955pfa.103.1556037420309; 
 Tue, 23 Apr 2019 09:37:00 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.36.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:36:59 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 40/63] Documentation: x86: convert exception-tables.txt to
 reST
Date: Wed, 24 Apr 2019 00:29:09 +0800
Message-Id: <20190423162932.21428-41-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:32 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ...eption-tables.txt => exception-tables.rst} | 231 ++++++++++--------
 Documentation/x86/index.rst                   |   1 +
 2 files changed, 126 insertions(+), 106 deletions(-)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (67%)

diff --git a/Documentation/x86/exception-tables.txt b/Documentation/x86/exception-tables.rst
similarity index 67%
rename from Documentation/x86/exception-tables.txt
rename to Documentation/x86/exception-tables.rst
index e396bcd8d830..2ffb096c8b58 100644
--- a/Documentation/x86/exception-tables.txt
+++ b/Documentation/x86/exception-tables.rst
@@ -1,5 +1,10 @@
-     Kernel level exception handling in Linux
-  Commentary by Joerg Pommnitz <joerg@raleigh.ibm.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Kernel level exception handling
+===============================
+
+Commentary by Joerg Pommnitz <joerg@raleigh.ibm.com>
 
 When a process runs in kernel mode, it often has to access user
 mode memory whose address has been passed by an untrusted program.
@@ -25,9 +30,9 @@ How does this work?
 
 Whenever the kernel tries to access an address that is currently not
 accessible, the CPU generates a page fault exception and calls the
-page fault handler
+page fault handler::
 
-void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+  void do_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 in arch/x86/mm/fault.c. The parameters on the stack are set up by
 the low level assembly glue in arch/x86/kernel/entry_32.S. The parameter
@@ -57,73 +62,74 @@ as an example. The definition is somewhat hard to follow, so let's peek at
 the code generated by the preprocessor and the compiler. I selected
 the get_user call in drivers/char/sysrq.c for a detailed examination.
 
-The original code in sysrq.c line 587:
+The original code in sysrq.c line 587::
+
         get_user(c, buf);
 
-The preprocessor output (edited to become somewhat readable):
-
-(
-  {
-    long __gu_err = - 14 , __gu_val = 0;
-    const __typeof__(*( (  buf ) )) *__gu_addr = ((buf));
-    if (((((0 + current_set[0])->tss.segment) == 0x18 )  ||
-       (((sizeof(*(buf))) <= 0xC0000000UL) &&
-       ((unsigned long)(__gu_addr ) <= 0xC0000000UL - (sizeof(*(buf)))))))
-      do {
-        __gu_err  = 0;
-        switch ((sizeof(*(buf)))) {
-          case 1:
-            __asm__ __volatile__(
-              "1:      mov" "b" " %2,%" "b" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "b" " %" "b" "1,%" "b" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"
-              "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=q" (__gu_val): "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  )) ;
-              break;
-          case 2:
-            __asm__ __volatile__(
-              "1:      mov" "w" " %2,%" "w" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "w" " %" "w" "1,%" "w" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"
-              "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  ));
-              break;
-          case 4:
-            __asm__ __volatile__(
-              "1:      mov" "l" " %2,%" "" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "l" " %" "" "1,%" "" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"        "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(__gu_err));
-              break;
-          default:
-            (__gu_val) = __get_user_bad();
-        }
-      } while (0) ;
-    ((c)) = (__typeof__(*((buf))))__gu_val;
-    __gu_err;
-  }
-);
+The preprocessor output (edited to become somewhat readable)::
+
+  (
+    {
+      long __gu_err = - 14 , __gu_val = 0;
+      const __typeof__(*( (  buf ) )) *__gu_addr = ((buf));
+      if (((((0 + current_set[0])->tss.segment) == 0x18 )  ||
+        (((sizeof(*(buf))) <= 0xC0000000UL) &&
+        ((unsigned long)(__gu_addr ) <= 0xC0000000UL - (sizeof(*(buf)))))))
+        do {
+          __gu_err  = 0;
+          switch ((sizeof(*(buf)))) {
+            case 1:
+              __asm__ __volatile__(
+                "1:      mov" "b" " %2,%" "b" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "b" " %" "b" "1,%" "b" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"
+                "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=q" (__gu_val): "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  )) ;
+                break;
+            case 2:
+              __asm__ __volatile__(
+                "1:      mov" "w" " %2,%" "w" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "w" " %" "w" "1,%" "w" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"
+                "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  ));
+                break;
+            case 4:
+              __asm__ __volatile__(
+                "1:      mov" "l" " %2,%" "" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "l" " %" "" "1,%" "" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"        "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(__gu_err));
+                break;
+            default:
+              (__gu_val) = __get_user_bad();
+          }
+        } while (0) ;
+      ((c)) = (__typeof__(*((buf))))__gu_val;
+      __gu_err;
+    }
+  );
 
 WOW! Black GCC/assembly magic. This is impossible to follow, so let's
-see what code gcc generates:
+see what code gcc generates::
 
  >         xorl %edx,%edx
  >         movl current_set,%eax
@@ -154,7 +160,7 @@ understand. Can we? The actual user access is quite obvious. Thanks
 to the unified address space we can just access the address in user
 memory. But what does the .section stuff do?????
 
-To understand this we have to look at the final kernel:
+To understand this we have to look at the final kernel::
 
  > objdump --section-headers vmlinux
  >
@@ -181,7 +187,7 @@ To understand this we have to look at the final kernel:
 
 There are obviously 2 non standard ELF sections in the generated object
 file. But first we want to find out what happened to our code in the
-final kernel executable:
+final kernel executable::
 
  > objdump --disassemble --section=.text vmlinux
  >
@@ -199,7 +205,7 @@ final kernel executable:
 The whole user memory access is reduced to 10 x86 machine instructions.
 The instructions bracketed in the .section directives are no longer
 in the normal execution path. They are located in a different section
-of the executable file:
+of the executable file::
 
  > objdump --disassemble --section=.fixup vmlinux
  >
@@ -207,14 +213,15 @@ of the executable file:
  > c0199ffa <.fixup+10ba> xorb   %dl,%dl
  > c0199ffc <.fixup+10bc> jmp    c017e7a7 <do_con_write+e3>
 
-And finally:
+And finally::
+
  > objdump --full-contents --section=__ex_table vmlinux
  >
  >  c01aa7c4 93c017c0 e09f19c0 97c017c0 99c017c0  ................
  >  c01aa7d4 f6c217c0 e99f19c0 a5e717c0 f59f19c0  ................
  >  c01aa7e4 080a18c0 01a019c0 0a0a18c0 04a019c0  ................
 
-or in human readable byte order:
+or in human readable byte order::
 
  >  c01aa7c4 c017c093 c0199fe0 c017c097 c017c099  ................
  >  c01aa7d4 c017c2f6 c0199fe9 c017e7a5 c0199ff5  ................
@@ -222,18 +229,22 @@ or in human readable byte order:
                                this is the interesting part!
  >  c01aa7e4 c0180a08 c019a001 c0180a0a c019a004  ................
 
-What happened? The assembly directives
+What happened? The assembly directives::
 
-.section .fixup,"ax"
-.section __ex_table,"a"
+  .section .fixup,"ax"
+  .section __ex_table,"a"
 
 told the assembler to move the following code to the specified
-sections in the ELF object file. So the instructions
-3:      movl $-14,%eax
-        xorb %dl,%dl
-        jmp 2b
-ended up in the .fixup section of the object file and the addresses
+sections in the ELF object file. So the instructions::
+
+  3:      movl $-14,%eax
+          xorb %dl,%dl
+          jmp 2b
+
+ended up in the .fixup section of the object file and the addresses::
+
         .long 1b,3b
+
 ended up in the __ex_table section of the object file. 1b and 3b
 are local labels. The local label 1b (1b stands for next label 1
 backward) is the address of the instruction that might fault, i.e.
@@ -246,35 +257,39 @@ the fault, in our case the actual value is c0199ff5:
 the original assembly code: > 3:      movl $-14,%eax
 and linked in vmlinux     : > c0199ff5 <.fixup+10b5> movl   $0xfffffff2,%eax
 
-The assembly code
+The assembly code::
+
  > .section __ex_table,"a"
  >         .align 4
  >         .long 1b,3b
 
-becomes the value pair
+becomes the value pair::
+
  >  c01aa7d4 c017c2f6 c0199fe9 c017e7a5 c0199ff5  ................
                                ^this is ^this is
                                1b       3b
+
 c017e7a5,c0199ff5 in the exception table of the kernel.
 
 So, what actually happens if a fault from kernel mode with no suitable
 vma occurs?
 
-1.) access to invalid address:
- > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
-2.) MMU generates exception
-3.) CPU calls do_page_fault
-4.) do page fault calls search_exception_table (regs->eip == c017e7a5);
-5.) search_exception_table looks up the address c017e7a5 in the
-    exception table (i.e. the contents of the ELF section __ex_table)
-    and returns the address of the associated fault handle code c0199ff5.
-6.) do_page_fault modifies its own return address to point to the fault
-    handle code and returns.
-7.) execution continues in the fault handling code.
-8.) 8a) EAX becomes -EFAULT (== -14)
-    8b) DL  becomes zero (the value we "read" from user space)
-    8c) execution continues at local label 2 (address of the
-        instruction immediately after the faulting user access).
+#. access to invalid address::
+
+    > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
+#. MMU generates exception
+#. CPU calls do_page_fault
+#. do page fault calls search_exception_table (regs->eip == c017e7a5);
+#. search_exception_table looks up the address c017e7a5 in the
+   exception table (i.e. the contents of the ELF section __ex_table)
+   and returns the address of the associated fault handle code c0199ff5.
+#. do_page_fault modifies its own return address to point to the fault
+   handle code and returns.
+#. execution continues in the fault handling code.
+#. a) EAX becomes -EFAULT (== -14)
+   b) DL  becomes zero (the value we "read" from user space)
+   c) execution continues at local label 2 (address of the
+      instruction immediately after the faulting user access).
 
 The steps 8a to 8c in a certain way emulate the faulting instruction.
 
@@ -295,14 +310,15 @@ Things changed when 64-bit support was added to x86 Linux. Rather than
 double the size of the exception table by expanding the two entries
 from 32-bits to 64 bits, a clever trick was used to store addresses
 as relative offsets from the table itself. The assembly code changed
-from:
-	.long 1b,3b
-to:
-        .long (from) - .
-        .long (to) - .
+from::
+
+    .long 1b,3b
+  to:
+          .long (from) - .
+          .long (to) - .
 
 and the C-code that uses these values converts back to absolute addresses
-like this:
+like this::
 
 	ex_insn_addr(const struct exception_table_entry *x)
 	{
@@ -313,15 +329,18 @@ In v4.6 the exception table entry was expanded with a new field "handler".
 This is also 32-bits wide and contains a third relative function
 pointer which points to one of:
 
-1) int ex_handler_default(const struct exception_table_entry *fixup)
+1) `int ex_handler_default(const struct exception_table_entry *fixup)`
    This is legacy case that just jumps to the fixup code
-2) int ex_handler_fault(const struct exception_table_entry *fixup)
+
+2) `int ex_handler_fault(const struct exception_table_entry *fixup)`
    This case provides the fault number of the trap that occurred at
    entry->insn. It is used to distinguish page faults from machine
    check.
-3) int ex_handler_ext(const struct exception_table_entry *fixup)
+
+3) `int ex_handler_ext(const struct exception_table_entry *fixup)`
    This case is used for uaccess_err ... we need to set a flag
    in the task structure. Before the handler functions existed this
    case was handled by adding a large offset to the fixup to tag
    it as special.
+
 More functions can easily be added.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 2033791e53bc..c0bfd0bd6000 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -10,3 +10,4 @@ Linux x86 Support
 
    boot
    topology
+   exception-tables
-- 
2.20.1

