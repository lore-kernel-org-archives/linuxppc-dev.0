Return-Path: <keescook@google.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KBbp5SRWzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 01:52:53 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id l189-v6so431396ywb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 08:52:53 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87fu12mnf7.fsf@concordia.ellerman.id.au>
References: <20180629185339.GA37582@beast>
 <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
 <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
 <87fu12mnf7.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 2 Jul 2018 08:52:49 -0700
Message-ID: <CAGXu5jLn0G0Qm=DUOuZ3chtOiRTZLVDnepXo5Nu-SwrHz_eyuQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anatolij Gustschin <agust@denx.de>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 1, 2018 at 6:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> switches to using a stack size large enough for the saved routine and
>>>> adds a sanity check.
>>>>
>>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>> This seems particularly nice, not only avoids it the dynamic stack
>>> allocation, it
>>> also makes sure the new 0x500 handler doesn't overflow into the 0x600
>>> exception handler.
>>>
>>> It would help to explain how you arrived at that '256 byte' number in
>>> the changelog though.
>>
>> Honestly, I just counted instructions, multiplied by 8 and rounded up
>> to the next nearest power of 2, and the result felt right for giving
>> some level of flexibility for code growth before tripping the WARN. :P
>>
>> I'm happy to adjust, of course. :)
>
> What if we write it:
>
>        char saved_0x500[0x600 - 0x500];
>
> Hopefully the compiler is smart enough not to generate a VLA for that :)

Sure, that's fine. I'll send an updated patch.

-Kees

-- 
Kees Cook
Pixel Security
