Return-Path: <keescook@google.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrKN85cDjzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 14:29:28 +1000 (AEST)
Received: by mail-wm0-x22b.google.com with SMTP id f65so11034013wmi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:29:28 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20160715020550.GB13944@balbir.ozlabs.ibm.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-12-git-send-email-keescook@chromium.org>
 <20160715020550.GB13944@balbir.ozlabs.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 14 Jul 2016 21:29:25 -0700
Message-ID: <CAGXu5j+Ub2-jmTa-XmF90Gd+ze1os+eqk_yijouCSQoLvU1hNQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm: SLUB hardened usercopy support
To: Balbir Singh <bsingharora@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>,
 Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-ia64@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 7:05 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Wed, Jul 13, 2016 at 02:56:04PM -0700, Kees Cook wrote:
>> Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
>> SLUB allocator to catch any copies that may span objects. Includes a
>> redzone handling fix from Michael Ellerman.
>>
>> Based on code from PaX and grsecurity.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  init/Kconfig |  1 +
>>  mm/slub.c    | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 798c2020ee7c..1c4711819dfd 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1765,6 +1765,7 @@ config SLAB
>>
>>  config SLUB
>>       bool "SLUB (Unqueued Allocator)"
>> +     select HAVE_HARDENED_USERCOPY_ALLOCATOR
>
> Should this patch come in earlier from a build perspective? I think
> patch 1 introduces and uses __check_heap_object.

__check_heap_object in patch 1 is protected by a check for
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR.

It seemed better to be to do arch enablement first, and then add the
per-allocator heap object size check since it was a distinct piece.
I'm happy to rearrange things, though, if there's a good reason.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
