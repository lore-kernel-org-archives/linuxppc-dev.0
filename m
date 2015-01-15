Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 130791A0D8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 01:09:34 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YBl75-0041Ww-Um
 for linuxppc-dev@lists.ozlabs.org; Thu, 15 Jan 2015 14:09:32 +0000
Message-ID: <54B7CA15.7000200@roeck-us.net>
Date: Thu, 15 Jan 2015 06:09:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: Tree for Jan 12 (build failures: m68k, ppc)
References: <20150112180322.003b44f2@canb.auug.org.au>	<20150112162438.GA18723@roeck-us.net>	<CAMuHMdUYEe=L=H75AOYVjinRSW=okRJNrNJVy-bY1gshdVrO7Q@mail.gmail.com>	<20150112175920.GC19868@roeck-us.net>
 <CAMuHMdV1k4viMKmi_8vM52iz+ry50k=Ard1ADkEGzia+yJ5e3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdV1k4viMKmi_8vM52iz+ry50k=Ard1ADkEGzia+yJ5e3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Linux-Next <linux-next@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2015 02:12 AM, Geert Uytterhoeven wrote:
> On Mon, Jan 12, 2015 at 6:59 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> Build failures, seen since next-20150109:
>>>>          m68k:allmodconfig
>>>>          powerpc:ppc6xx_defconfig
>
> It looks like parisc is also suffering:
> http://kisskb.ellerman.id.au/kisskb/buildresult/12343847/
>
>>>> Due to:
>>>>          ERROR: "__get_user_bad" [drivers/gpu/drm/drm.ko] undefined!
>>>>          make[1]: *** [__modpost] Error 1
>>>>
>>>> Caused by commit d34f20d6e2f (drm: Atomic modeset ioctl).
>>>
>>> Yeah, it needs a get_user() that supports 64-bit data.
>>>
>> Hi Geert,
>>
>> I assume you mean m68k, where 64 bit support for get_user has been disabled.
>>
>> The problem on powerpc is different though: __get_user_nocheck()
>> and __get_user_check() use
>>          unsigned long __gu_val;
>> followed by
>>          __get_user_size(__gu_val, __gu_addr, (size), __gu_err);
>>
>> __get_user_size() fails in
>>          if (size > sizeof(x))
>>                   (x) = __get_user_bad();
>>
>> Presumably "unsigned long" is 32 bit on 32 bit powerpc, not 64 bit.
>>
>> Overall, the explicit 64-bit use of get_user() seems to be quite unusual.
>
> I noticed you've sent a fix for DRM.
>
> Doh, and I was just fixing m68k...
>

Sorry, should have Cc:'d you.

Guenter
