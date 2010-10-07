Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 51161B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 03:25:30 +1100 (EST)
Received: by wwa36 with SMTP id 36so19912wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Oct 2010 09:25:28 -0700 (PDT)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <20101001220343.GA10494@lixom.net>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
	<BBD78246-343E-4A96-9E55-3E40AD628C0B@kernel.crashing.org>
	<1285966315.2463.141.camel@pasglop>
	<20101001220343.GA10494@lixom.net>
Date: Thu, 7 Oct 2010 09:25:27 -0700
Message-ID: <AANLkTim0+SU3EqRe6x5aXR+G-Gczv6gBSrrdinXQavSa@mail.gmail.com>
Subject: Re: Introduce support for little endian PowerPC
From: Hollis Blanchard <hollis@penguinppc.org>
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 3:03 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Oct 02, 2010 at 06:51:55AM +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2010-10-01 at 12:59 -0500, Kumar Gala wrote:
>> > I'm not against it, and I agree some of the patches seem like good
>> > clean up. =A0I'm concerned about this bit rotting pretty quickly.
>>
>> Maybe. Most of it doesn't seem to be that bit-rottable.
>>
>> The changes to the asm stuff in misc_32.S for example are functions we
>> never ever touch once written (libgcc replacements) so I don't see them
>> rotting more with LE support than they did with BE :-)
>
> Does KVM/qemu support running LE guest on BE host? That'd help keeping
> the bitrot lower. :)

Surprisingly, qemu has very poor support for the concept of
endianness. The fact that BE PowerPC works on both BE and LE hosts in
Qemu today is more accidental than anything else (the special curse of
endianness is that two wrongs make a right). Supporting LE PowerPC
guests would be a dramatic effort, and I'm pretty sure it would impact
other qemu architectures as well.

-Hollis
