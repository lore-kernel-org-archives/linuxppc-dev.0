Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB0E41A0331
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 08:07:20 +1100 (AEDT)
Date: Fri, 22 Jan 2016 13:07:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal
 Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Arnd
 Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Message-Id: <20160122130718.8313ec9aefa654f33bd17792@linux-foundation.org>
In-Reply-To: <CAKv+Gu8QvECRJ9DhEd=k-oTy=xVVFJSMaW0EOCxMMPsWsF2RMQ@mail.gmail.com>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
 <CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
 <20160121152045.82639ae577d816198607d650@linux-foundation.org>
 <CAKv+Gu8QvECRJ9DhEd=k-oTy=xVVFJSMaW0EOCxMMPsWsF2RMQ@mail.gmail.com>
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

On Fri, 22 Jan 2016 09:20:41 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > : in half since offsets can typically be expressed in 32 bits.
> > :
> """
> 
> In addition to fixing the broken grammar, would it make sense to
> mention that dynamic relocation only occurs under
> CONFIG_RELOCATABLE=y? I.e., something like
> 
> """
> On 64-bit architectures, it cuts the size of the kallsyms address
> table in half, since offsets between kernel symbols can typically be
> expressed in 32 bits. This saves several hundreds of kilobytes of
> permanent .rodata on average. In addition, the kallsyms address table
> is no longer subject to dynamic relocation when CONFIG_RELOCATABLE is
> in effect, so the relocation work done after decompression now doesn't
> have to do relocation updates for all these values. This saves up to
> 24 bytes (i.e., the size of a ELF64 RELA relocation table entry) per
> table entry, which easily adds up to a couple of megabytes of
> uncompressed __init data on ppc64 or arm64. Even if these relocation
> entries typically compress well, the combined size reduction of 2.8 MB
> uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
> data) results in a ~500 KB space saving in the compressed image.
> """

Yes, that sounds very good.  I'd buy one :)

Can you please send along a complete new changelog sometime?
