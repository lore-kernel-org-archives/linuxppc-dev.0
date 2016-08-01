Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2zPP3f62zDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 22:37:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Jiri Slaby <jslaby@suse.cz>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard  <anton@samba.org>
Subject: Linker segfault on powerpc when CONFIG_LKDTM=y (was Re:
 [kernel-hardening] [PATCH 3/5] lkdtm: add function for testing .rodata
 section)
In-Reply-To: <1465336628-18219-4-git-send-email-keescook@chromium.org>
References: <1465336628-18219-1-git-send-email-keescook@chromium.org>
 <1465336628-18219-4-git-send-email-keescook@chromium.org>
Date: Mon, 01 Aug 2016 22:37:24 +1000
Message-ID: <87h9b4oebf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kees Cook <keescook@chromium.org> writes:

> This adds a function that lives in the .rodata section. The section
> flags are corrected using objcopy since there is no way with gcc to
> declare section flags in an architecture-agnostic way.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/Makefile       |  7 +++++++
>  drivers/misc/lkdtm.h        |  6 ++++++
>  drivers/misc/lkdtm_core.c   | 24 +++++++++++++++++-------
>  drivers/misc/lkdtm_rodata.c | 10 ++++++++++
>  4 files changed, 40 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/misc/lkdtm.h
>  create mode 100644 drivers/misc/lkdtm_rodata.c

This is blowing up my linker :(

  scripts/link-vmlinux.sh: line 52: 36260 Segmentation fault      (core dumped) ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2} -T ${lds} ${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}

Haven't had a chance to debug it further.

cheers
