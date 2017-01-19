Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v49gw59hTzDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:24:44 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id w144so3716228oiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:24:44 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKv+Gu_5hL617uMzT37sn6-1R_9fwoRnmr_jE=zDB1XyHGvDAQ@mail.gmail.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
 <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
 <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
 <CA+55aFx5QHfi3X6cxbmXHcxTWfBfxTG33N+kX4Ro=747rnuxtw@mail.gmail.com>
 <CA+55aFz2=B1WmVFREpouYJcUb31zH7ijqU6jvTsveQdb_yJ=sg@mail.gmail.com>
 <CAKv+Gu-wqoQVXvZcEF8xfAnHmrakKU73ToMNO+2Lw158B4teJA@mail.gmail.com>
 <CA+55aFzpCdSAP1ef9d+8SWByEa5ekP0V2T6feKPMZq_cOfiOUA@mail.gmail.com>
 <CAKv+Gu_5hL617uMzT37sn6-1R_9fwoRnmr_jE=zDB1XyHGvDAQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Jan 2017 09:24:41 -0800
Message-ID: <CA+55aFze-554PcrE8O4_ZFN5_veQ7s3M3HFOTbpj7rxVKY-KjQ@mail.gmail.com>
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

On Thu, Jan 19, 2017 at 1:22 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>>
>> Your genksyms.c change is not exactly obvious. I looked at it, and my
>> brain just shut down. Why both the
>>
>>   LONG(0x%08lx);
>>
>> _and_ the
>>
>>   "%s__crc_%s = 0x%08lx;\n"
>>
>> in the linker script? I'm sure there's a good reason, but I'd like to
>> see a more explicit explanation fo what the generated linker script
>> does and what the rules are.
>
> This is simply because modpost still uses the value of the symbol
> rather than the value it points to to generate the /other/ side of the
> comparison (i.e., Module.symvers etc)

Ahh, now that you explained it, it was obvious. Thanks.

But yes, I don't think we want that "both belt and suspenders"
approach, so your updated patch that does things just one way is I
think the right way.

> I will look into updating modpost to dereference the symbol as well,
> and update the RFC patch accordingly.

Yes, so your updated patch looks good to me.

I think our old "symbol with an absolute value" model was simpler
conceptually, but given the existing absolute (sic) braindamage of
linkers, I think your latest patch is probably the way to go.

If for no other reason than the fact that it doesn't depend on
something that clearly nobody else uses, and even the linker people
were confused about.

So I think the slightly more complex model of relative offsets is the
simpler one in the end if it means that we don't have to have
completely insane workarounds for linker damage.

But maybe somebody else wants to pipe up. Preferably somebody who
doesn't hate the symversions code as much as I do by now, and actually
_uses_ it ;)

                Linus
