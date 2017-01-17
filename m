Return-Path: <linus971@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v36G34YHLzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 10:47:07 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id f4so25098496qte.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 15:47:07 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jan 2017 15:47:04 -0800
Message-ID: <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] modversions: treat symbol CRCs as 32 bit
 quantities on 64 bit archs
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2017 at 11:26 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The modversion symbol CRCs are emitted as ELF symbols, which allows us to
> easily populate the kcrctab sections by relying on the linker to associate
> each kcrctab slot with the correct value.
>
> This has a couple of downsides:

So the whole relocation of the crc is obviously completely crazy, but
you don't actually seem to *change* that. You just work around it, and
you make the symbols 32-bit. The latter part I agree with
whole-heartedly, btw.

But do we really have to accept this relocation insanity?

So I don't actually disagree with this patch 3/3 (turning the whole
crc array into an array of "u32" is clearly the right thing to do),
but the two other patches look oddly broken.

Why are those CRC's relocatable to begin with? Shouldn't they be
absolute values? Why do they get those idiotic relocation things? They
seem to be absolute on x86-64 (just doing a 'nm vmlinux', so I might
be missing something), why aren't they on ppc?

Is there something wrong with our generation script? Can we possibly
do something like

  -       printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
  +       printf("%s__crc_%s = ABSOLUTE(0x%08lx) ;\n", mod_prefix, name, crc);

in genksyms.c to get rid of the crazty relocation entries?

             Linus
