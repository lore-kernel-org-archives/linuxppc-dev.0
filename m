Return-Path: <jjo.braun@gmail.com>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 576F12C0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 22:01:28 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id c11so604352ieb.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 03:01:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50D03FCE.9060003@grandegger.com>
References: <CADwvPCuBcSnXz1LYYf2ydfdCcz1tV5eBZufEDh5LCaZrmY7W4Q@mail.gmail.com>
 <50D03E16.1080903@grandegger.com> <50D03FCE.9060003@grandegger.com>
Date: Tue, 18 Dec 2012 12:01:24 +0100
Message-ID: <CADwvPCv+8ZFyjvtUgJ5mpBLtq5kZk4BGxtbqFnCmD72Zg0CMrA@mail.gmail.com>
Subject: Re: tqm5200s phy link toggles between up and down
From: Johannes Braun <jjo.braun@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> This is not really a new kernel.

Yes this is right. But it is the first Kernel which supports our
wireless card without problems.

>> Is it a PHY or a switch? If is a switch you need to configure a fixed
>> link to the switch. This can be done via dts file.

According to the marvell website it is a switch with integrated phy.

> Here is an example:

> http://lxr.linux.no/#linux+v3.7.1/arch/powerpc/boot/dts/charon.dts#L129

I had a look at this example and compared it to my *.dtb file. The
difference was, the fixed-link tag in the section ethernet@3000 { ...
};.
I added "fixed-link = <1 1 100 0 0>;" to my tqm5200.dtb and now it works.

I am new to powerpc development and I hope it is ok to ask what this
fixed-link with the numbers "1 1 100 0 0" does? Is it the address to
the PHY?

2012/12/18 Wolfgang Grandegger <wg@grandegger.com>:
> On 12/18/2012 10:57 AM, Wolfgang Grandegger wrote:
>> On 12/18/2012 10:44 AM, Johannes Braun wrote:
>>> Hello,
>>>
>>> I hope someone could help me with my problem. Currently I am porting
>>> a new kernel (3.3.8) for a tqm5200s based board.
>>
>> This is not really a new kernel.
>>
>>> The previous kernel was 2.6.23. The new kernel version is needed because
>>> of support for a wireless card.
>>>
>>> The new kernel has problems with my ethernet PHY. The problem occurs only
>>> with our hardware. Not with the TQ eval board.
>>> The eval board uses a Intel PHY. Our board uses a Marvel 88E6085 PHY.
>>
>> Is it a PHY or a switch? If is a switch you need to configure a fixed
>> link to the switch. This can be done via dts file.
>
> Here is an example:
>
> http://lxr.linux.no/#linux+v3.7.1/arch/powerpc/boot/dts/charon.dts#L129
>
>> Note the the DSA also supports this chip.
>
> See http://lwn.net/Articles/302333/. But I think it lacks device tree
> support.
>
> Wolfgang.
>
