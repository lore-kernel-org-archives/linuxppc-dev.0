Return-Path: <keescook@google.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s38ty05XmzDqRq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 05:45:13 +1000 (AEST)
Received: by mail-wm0-x231.google.com with SMTP id f65so382730670wmi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 12:45:13 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87h9b4oebf.fsf@concordia.ellerman.id.au>
References: <1465336628-18219-1-git-send-email-keescook@chromium.org>
 <1465336628-18219-4-git-send-email-keescook@chromium.org>
 <87h9b4oebf.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Aug 2016 12:45:09 -0700
Message-ID: <CAGXu5jL8UBfs7NjSgKOeqd9toRgtW3gPu53TPLbTMRJiwRUvPg@mail.gmail.com>
Subject: Re: Linker segfault on powerpc when CONFIG_LKDTM=y (was Re:
 [kernel-hardening] [PATCH 3/5] lkdtm: add function for testing .rodata
 section)
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Jiri Slaby <jslaby@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
 LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2016 at 5:37 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> This adds a function that lives in the .rodata section. The section
>> flags are corrected using objcopy since there is no way with gcc to
>> declare section flags in an architecture-agnostic way.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/misc/Makefile       |  7 +++++++
>>  drivers/misc/lkdtm.h        |  6 ++++++
>>  drivers/misc/lkdtm_core.c   | 24 +++++++++++++++++-------
>>  drivers/misc/lkdtm_rodata.c | 10 ++++++++++
>>  4 files changed, 40 insertions(+), 7 deletions(-)
>>  create mode 100644 drivers/misc/lkdtm.h
>>  create mode 100644 drivers/misc/lkdtm_rodata.c
>
> This is blowing up my linker :(
>
>   scripts/link-vmlinux.sh: line 52: 36260 Segmentation fault      (core dumped) ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2} -T ${lds} ${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}
>
> Haven't had a chance to debug it further.

Argh. Do you want a quick fix for this now? I can add a PPC CONFIG
blacklist for the rodata check, maybe?

Also, what version of gcc? I'll see if I can reproduce this with a
cross compiler...

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
