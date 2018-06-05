Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410j4x3HzbzF1wr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 05:47:29 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id g21-v6so3448422lfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 12:47:29 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180605160624.GA30373@roeck-us.net>
References: <e11832b0-f071-b709-be34-417f2d3bc343@roeck-us.net>
 <CAK8P3a3CFhkjPCX8bgZbx7aYwrUVsKE5ct4ghnMxJLo5OSYqbA@mail.gmail.com>
 <20180605160624.GA30373@roeck-us.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Jun 2018 21:47:24 +0200
Message-ID: <CAK8P3a0CjKCYCyhGejF6e3-Mk0mQ2=x3Kd76U8B4iB1amNr76g@mail.gmail.com>
Subject: Re: Problems building ppc images in v4.14.y and v4.16.y using gcc
 7.3.0 / 8.1.0 from kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 5, 2018 at 6:06 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 05, 2018 at 04:31:00PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 5, 2018 at 3:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > Hi Arnd,
>> >
>> > when using the ppc64 compiler from kernel.org, I see the following problems
>> > when trying to compile ppc:allnoconfig in v4.14.y or v4.16.y.
>> >
>> > gcc 7.3.0: Compilation of kernel.cpu.o hangs
>> >
>> > The problem goes away if I apply the following two patches (tested with
>> > 4.16.y)
>> >
>> > 17a2f1ced028 cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states
>> > fcb3029a8d89 cpu/hotplug: Fix unused function warning
>>
>> This is probably the same as
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84038
>>
>> I thought I had included the fix in my builds.
>>
> Guess not.

I probably had it in one build and then forgot about it when I did a
rebuild of 7.3 :(

I'm still planning to do a new set of gcc-7.3 binaries (or maybe 7.4
if that gets
released soon) and should try to remember doing that.

>>
> I think it may have cached the flags from the other compiler version.
> "make mrproper" prior to "make defconfig" took care of the issue.
>
> However, that doesn't really help - I get lots of
>         error: 'sys_spu_create' alias between functions of incompatible types
>         error: 'strncpy' output truncated before terminating nul
> if I try to use gcc 8.1.0.
>
> Oh well. I'll try gcc 6.4.0 next.

On the upside, those two errors are just a result of arch/power/*/*.c getting
built with -Werror, they are warnings that gcc-8 introduced that we should
either shut up or fix.

        Arnd
