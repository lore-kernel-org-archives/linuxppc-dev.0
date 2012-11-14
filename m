Return-Path: <bhelgaas@google.com>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FFBB2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 01:53:58 +1100 (EST)
Received: by mail-la0-f51.google.com with SMTP id e4so375877lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 06:53:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXu2VJhB+1uFApeBrYS3t2cfpPMaTz12F=A_FNJB1Q60w@mail.gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
 <CAMuHMdXu2VJhB+1uFApeBrYS3t2cfpPMaTz12F=A_FNJB1Q60w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 14 Nov 2012 07:53:31 -0700
Message-ID: <CAErSpo6p09BJo=3tFp7f8StLT9avYdqiecGm8FxyQnWUm+pfiw@mail.gmail.com>
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 H Hartley Sweeten <hartleys@visionengravers.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2012 at 3:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Nov 12, 2012 at 10:26 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 366ec06..9bc00e7 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -271,6 +271,13 @@ config ARCH_WANT_OLD_COMPAT_IPC
>>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>>         bool
>>
>> +config ARCH_NO_VIRT_TO_BUS
>> +       bool
>> +       help
>> +         An architecture should select this if it cannot (or will not)
>> +         implement virt_to_bus().  All new architectures should probably
>> +         select this.
>
> Don't we typically put the burden of selecting Kconfig flags for deprecated
> features on the existing architectures that provide the deprecated features?
>
> I.e. shouldn't it be ARCH_HAS_VIRT_TO_BUS, selected by the architectures
> that need it, instead?

I like this idea.
