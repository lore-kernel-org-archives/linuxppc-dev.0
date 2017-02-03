Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com
 [IPv6:2607:f8b0:4001:c0b::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF9873jyVzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 19:31:51 +1100 (AEDT)
Received: by mail-it0-x22f.google.com with SMTP id 203so7055256ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 00:31:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170203050954.4qisyy66es6yjhkg@jeyu>
References: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170203035441.GA2964@packer-debian-8-amd64.digitalocean.com>
 <20170203050954.4qisyy66es6yjhkg@jeyu>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 3 Feb 2017 08:31:48 +0000
Message-ID: <CAKv+Gu_vBJPN071h_kRpLMSG3FWx_Gq6TLeZbOP8_W3XDk3V+Q@mail.gmail.com>
Subject: Re: modversions: redefine kcrctab entries as 32-bit values
To: Jessica Yu <jeyu@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Michael Ellerman <mpe@ellerman.id.au>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Russell King <linux@armlinux.org.uk>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3 February 2017 at 05:09, Jessica Yu <jeyu@redhat.com> wrote:
> +++ Jessica Yu [02/02/17 22:54 -0500]:
>>
>> +++ Ard Biesheuvel [24/01/17 16:16 +0000]:
>>>
>>> This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
>>> relative CRC pointers', but since relative CRC pointers do not work in
>>> modules, and are actually only needed by powerpc with
>>> CONFIG_RELOCATABLE=y,
>>> I have made it a Kconfig selectable feature instead.
>>>
>>> Patch #1 introduces the MODULE_REL_CRCS Kconfig symbol, and adds the
>>> kbuild
>>> handling of it, i.e., modpost, genksyms and kallsyms.
>>>
>>> Patch #2 switches all architectures to 32-bit CRC entries in kcrctab,
>>> where
>>> all architectures except powerpc with CONFIG_RELOCATABLE=y use absolute
>>> ELF
>>> symbol references as before.
>>>
>>> v4: make relative CRCs kconfig selectable
>>>   use absolute CRC symbols in modules regardless of kconfig selection
>>>   split into two patches
>>
>>
>> This asymmetry threw me off a bit, especially the Kconfig naming (only
>> vmlinux crcs get the relative offsets, and only on powerpc atm, but all
>> modules keep the absolute syms, but it is called MODULE_REL_CRCS...),
>> if we keep this asymmetric crc treatment, it would be really nice to
>> note this discrepancy this somewhere, perhaps in the Kconfig, to keep
>> our heads from spinning :-)
>>
>> I'm still catching up on the previous discussion threads, but can you
>> explain a bit more why you switched away from full blown relative crcs
>> from your last patchset [1]? I had lightly tested your v3 on ppc64le
>> previously, and relative offsets with modules seemed to worked very
>> well. I'm probably missing something very obvious.
>
>
> Ah, I just saw your other comment about other arches not having support
> for the rel32 offsets :-/
>
> The asymmetry still bothers me though. Can't we have something that just
> switches relative crcs on and off, that applies to *both* vmlinux and
> modules?
> Then we can get rid of the crc_owner check in check_version() and just have
> something like:
>
>   if (IS_ENABLED(CONFIG_RELATIVE_CRCS))
>       crcval = resolve_crc(crc);
>
> Also we could get rid of the '&& !defined(MODULE)' checks scattered in
> export.h. Then the arches that want relative crcs and that *do* have rel32
> relocation support can turn relative crcs on, and powerpc can enable it,
> right?
>

Indeed. My reasoning was that, given that we need to support both
absolute and relative CRCs anyway, it would make sense for modules to
keep using absolute ones regardless of what vmlinux is using, but it
does obfuscate the code a bit.

> Would that work or is there another reason this won't work with modules
> (assuming that the arches that select this option support the relative
> offsets)?
>

PowerPC with CONFIG_RELOCATABLE=y is really the only arch that
requires this atm, and it supports REL32 relocations just fine, both
for 32-bit and 64-bit.

I will respin the patches with the above modification.
