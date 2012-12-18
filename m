Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74B1F2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 00:28:19 +1100 (EST)
Received: by mail-ob0-f182.google.com with SMTP id 16so588133obc.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 05:28:16 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and enhanced
 prefetch
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1355790373.5180.26.camel@otta>
Date: Tue, 18 Dec 2012 07:28:11 -0600
Message-Id: <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten> <1355790373.5180.26.camel@otta>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Kumar Gala <kumar.gala@gmail.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 17, 2012, at 6:26 PM, Peter Bergner <bergner@vnet.ibm.com> wrote:

> On Mon, 2012-12-17 at 22:33 +1100, Anton Blanchard wrote:
>> Hi Jimi,
>>=20
>>> I know this is a little late, but shouldn't these power7 specific
>>> thingies be in "obj-$(CONFIG_PPC_BOOK3S_64)". The reason I ask is
>>> that my compiler pukes on "dcbtst" and as I deal with that I wanted
>>> to point this out.
>>=20
>> I guess we could do that. It's a bit strange your assembler is
>> complaining about the dcbtst instructions since we wrap them with
>> power4:
>>=20
>> .machine push
>> .machine "power4"
>>        dcbt    r0,r4,0b01000
>>        dcbt    r0,r7,0b01010
>>        dcbtst  r0,r9,0b01000
>>        dcbtst  r0,r10,0b01010
>>        eieio
>>        dcbt    r0,r8,0b01010   /* GO */
>> .machine pop
>=20
> Jimi, are you using an "old" binutils from before my patch that
> changed the operand order for these types of instructions?
>=20
>    http://sourceware.org/ml/binutils/2009-02/msg00044.html

Actually, this confused me as well, that embedded has the same =
instruction encoding but different mnemonic.
I was under the impression that the assembler made no instruction =
decisions based on CPU.
So your only hint would be that '0b' prefix.
Does AS even see that?

If not, then without a _normalizing_ macro, I think will need that =
obj-$(CONFIG_PPC_BOOK3S_64) and .S files with the two can never be =
shared.

-jx


>=20
> Peter
>=20
>=20
