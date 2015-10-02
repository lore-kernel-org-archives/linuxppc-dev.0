Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 929F31A055C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 05:03:47 +1000 (AEST)
Received: by ykdz138 with SMTP id z138so119438530ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2015 12:03:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <560EA623.1040300@redhat.com>
References: <560EA623.1040300@redhat.com>
Date: Fri, 2 Oct 2015 22:03:45 +0300
Message-ID: <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
Subject: Re: Missing operand for tlbie instruction on Power7
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113a6b24a763f7052123d27b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113a6b24a763f7052123d27b
Content-Type: text/plain; charset=UTF-8

On 10/2/15, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> We received a report (https://bugzilla.redhat.com/show_bug.cgi?id=1267395)
> of bad assembly
> when compiling on powerpc with little endian
>
> [labbott@labbott-redhat-machine linux_upstream]$ make ARCH=powerpc
> CROSS_COMPILE=powerpc64-linux-gnu-
>    CHK     include/config/kernel.release
>    CHK     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
>    CHK     include/generated/bounds.h
>    CHK     include/generated/timeconst.h
>    CHK     include/generated/asm-offsets.h
>    CALL    scripts/checksyscalls.sh
>    CHK     include/generated/compile.h
>    CALL    arch/powerpc/kernel/systbl_chk.sh
>    AS      arch/powerpc/kernel/swsusp_asm64.o
> arch/powerpc/kernel/swsusp_asm64.S: Assembler messages:
> arch/powerpc/kernel/swsusp_asm64.S:188: Error: missing operand
> scripts/Makefile.build:294: recipe for target
> 'arch/powerpc/kernel/swsusp_asm64.o' failed
> make[1]: *** [arch/powerpc/kernel/swsusp_asm64.o] Error 1
> Makefile:941: recipe for target 'arch/powerpc/kernel' failed
> make: *** [arch/powerpc/kernel] Error 2
>
> This problem started happening after a binutils update:
>
> [labbott@labbott-redhat-machine linux_upstream]$ powerpc64-linux-gnu-as
> --version
> GNU assembler version 2.25.1-1.fc22
> Copyright (C) 2014 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or later.
> This program has absolutely no warranty.
> This assembler was configured for a target of `powerpc64-linux-gnu'.
> [labbott@labbott-redhat-machine linux_upstream]$
>
> After some discussion with the binutils folks, it turns out that the tlbie
> instruction actually requires another operand and binutils was updated to
> check for this https://sourceware.org/ml/binutils/2015-05/msg00133.html .
>
> The code sequence in arch/powerpc/include/asm/ppc_asm.h now needs to be
> updated:
>
> #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
> #define tlbia                                   \
>          li      r4,1024;                        \
>          mtctr   r4;                             \
>          lis     r4,KERNELBASE@h;                \
> 0:      tlbie   r4;                             \
>          addi    r4,r4,0x1000;                   \
>          bdnz    0b
> #endif
>
> I don't know enough ppc assembly to properly fix this but I can test.

Could you please test the patch attached?



>
> Thanks,
> Laura
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--001a113a6b24a763f7052123d27b
Content-Type: text/x-patch; charset=US-ASCII; name="tlbie_fix.patch"
Content-Disposition: attachment; filename="tlbie_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wcGNfYXNtLmggYi9hcmNoL3Bv
d2VycGMvaW5jbHVkZS9hc20vcHBjX2FzbS5oCmluZGV4IGRkMGZjMTguLjI0MDU1N2EgMTAwNjQ0
Ci0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wcGNfYXNtLmgKKysrIGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL3BwY19hc20uaApAQCAtNDQ1LDcgKzQ0NSw3IEBAIEVORF9GVFJfU0VD
VElPTl9ORVNURUQoQ1BVX0ZUUl9IQVNfUFBSLENQVV9GVFJfSEFTX1BQUiw5NDUpCiAJbGkJcjQs
MTAyNDsJCQlcCiAJbXRjdHIJcjQ7CQkJCVwKIAlsaXMJcjQsS0VSTkVMQkFTRUBoOwkJXAotMDoJ
dGxiaWUJcjQ7CQkJCVwKKzA6CXRsYmllCXI0LCAwOwkJCQlcCiAJYWRkaQlyNCxyNCwweDEwMDA7
CQkJXAogCWJkbnoJMGIKICNlbmRpZgo=
--001a113a6b24a763f7052123d27b--
