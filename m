Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 089472C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 00:21:28 +1100 (EST)
Received: by mail-ob0-f173.google.com with SMTP id xn12so586956obc.18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 05:21:25 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and enhanced
 prefetch
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <20121217223333.6cb00476@kryten>
Date: Tue, 18 Dec 2012 07:21:16 -0600
Message-Id: <BD2B3ACC-39AD-4084-8E62-72A543EA3811@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: Kumar Gala <kumar.gala@gmail.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 17, 2012, at 5:33 AM, Anton Blanchard <anton@samba.org> wrote:

>=20
> Hi Jimi,
>=20
>> I know this is a little late, but shouldn't these power7 specific
>> thingies be in "obj-$(CONFIG_PPC_BOOK3S_64)". The reason I ask is
>> that my compiler pukes on "dcbtst" and as I deal with that I wanted
>> to point this out.
>=20
> I guess we could do that.

I think it is the right idea since it is unclear that your optimizations =
would actually help an embedded system where most of these cache =
prefetches are NOPs and only wait decode/dispatch cycles.

> It's a bit strange your assembler is
> complaining about the dcbtst instructions since we wrap them with
> power4:

Not really, the binutils is a little old (RHEL 6.2), unfortunately it =
_is_ the toolchain most people are using at the moment.
It will take me a while to get everyone using newer ones since most are =
scientists using the packages they get.

My suggestion was really for correctness,  My current patches for BG/Q =
introduce a macro replacement.
-jx


>=20
> .machine push
> .machine "power4"
>        dcbt    r0,r4,0b01000
>        dcbt    r0,r7,0b01010
>        dcbtst  r0,r9,0b01000
>        dcbtst  r0,r10,0b01010
>        eieio
>        dcbt    r0,r8,0b01010   /* GO */
> .machine pop
>=20
> Anton
