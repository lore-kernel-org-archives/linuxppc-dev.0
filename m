Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x231.google.com (mail-it0-x231.google.com
 [IPv6:2607:f8b0:4001:c0b::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3yzj17yvzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 20:22:41 +1100 (AEDT)
Received: by mail-it0-x231.google.com with SMTP id 203so136188592ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 01:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzpCdSAP1ef9d+8SWByEa5ekP0V2T6feKPMZq_cOfiOUA@mail.gmail.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
 <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
 <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
 <CA+55aFx5QHfi3X6cxbmXHcxTWfBfxTG33N+kX4Ro=747rnuxtw@mail.gmail.com>
 <CA+55aFz2=B1WmVFREpouYJcUb31zH7ijqU6jvTsveQdb_yJ=sg@mail.gmail.com>
 <CAKv+Gu-wqoQVXvZcEF8xfAnHmrakKU73ToMNO+2Lw158B4teJA@mail.gmail.com>
 <CA+55aFzpCdSAP1ef9d+8SWByEa5ekP0V2T6feKPMZq_cOfiOUA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 19 Jan 2017 09:22:38 +0000
Message-ID: <CAKv+Gu_5hL617uMzT37sn6-1R_9fwoRnmr_jE=zDB1XyHGvDAQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] modversions: treat symbol CRCs as 32 bit
 quantities on 64 bit archs
To: Linus Torvalds <torvalds@linux-foundation.org>
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

On 19 January 2017 at 00:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jan 18, 2017 at 2:37 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> For a ballpark number of 10,000 CRCs in the core kernel, this would
>> increase the size of the image by 40 KB for 32-bit architectures (and
>> if saving 40 KB is essential, chances are you won't be using
>> modversions in the first place).
>
> As you say, I don't think the space issue is much of a problem.
>
> I'm more worried about the replacement of one crazy model that has
> problems due to linker subtlety with _another_ one.
>
> Your genksyms.c change is not exactly obvious. I looked at it, and my
> brain just shut down. Why both the
>
>   LONG(0x%08lx);
>
> _and_ the
>
>   "%s__crc_%s = 0x%08lx;\n"
>
> in the linker script? I'm sure there's a good reason, but I'd like to
> see a more explicit explanation fo what the generated linker script
> does and what the rules are.
>

This is simply because modpost still uses the value of the symbol
rather than the value it points to to generate the /other/ side of the
comparison (i.e., Module.symvers etc)

I will look into updating modpost to dereference the symbol as well,
and update the RFC patch accordingly.
