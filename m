Return-Path: <linus971@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3b7M3NSDzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 05:27:59 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id f9so1961566otd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 10:27:59 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
 <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
 <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jan 2017 10:27:56 -0800
Message-ID: <CA+55aFx5QHfi3X6cxbmXHcxTWfBfxTG33N+kX4Ro=747rnuxtw@mail.gmail.com>
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

On Wed, Jan 18, 2017 at 5:52 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> It turns out that this odd treatment of absolute symbols (i.e.,
> symbols having section number SHN_ABS) is a known issue in GNU ld
>
> https://sourceware.org/ml/binutils/2012-05/msg00019.html

Ugh. I hate the GNU linker. It's slow, it does nasty crazy fixups, and
it's apparently buggy too.

I wonder what happened to gold, and why it didn't take over. I'm
assuming it had _other_ bugs.. Oh well.

                 Linus
