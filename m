Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FE001A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 10:04:00 +1100 (AEDT)
Date: Thu, 26 Feb 2015 15:03:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@kernel.org>, Hector Marco Gisbert <hecmargi@upv.es>,
 Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 ismael Ripoll <iripoll@upv.es>, "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List
 <linux-mips@linux-mips.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226150357.b9343de08c96cb366d7e1d56@linux-foundation.org>
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2015 14:38:15 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Does that __weak trick even work?

Nope.

--- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix
+++ a/fs/binfmt_elf.c
@@ -2307,10 +2307,10 @@ unsigned long __weak mmap_rnd(void)
 }
 
 /*
- * Not all architectures use randomize_et_dyn(), so use __weak to let the
- * linker omit it from vmlinux
+ * Not all architectures use randomize_et_dyn(), but there doesn't seem to be
+ * a compile-time way of avoiding its generation.
  */
-unsigned long __weak randomize_et_dyn(unsigned long base)
+unsigned long randomize_et_dyn(unsigned long base)
 {
 	unsigned long ret;
 
_
