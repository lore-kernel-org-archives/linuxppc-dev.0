Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41JqXF5mmlzF1LP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 11:33:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anatolij Gustschin <agust@denx.de>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
In-Reply-To: <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
References: <20180629185339.GA37582@beast>
 <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
 <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
Date: Mon, 02 Jul 2018 11:33:32 +1000
Message-ID: <87fu12mnf7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kees Cook <keescook@chromium.org> writes:

> On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches to using a stack size large enough for the saved routine and
>>> adds a sanity check.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> This seems particularly nice, not only avoids it the dynamic stack
>> allocation, it
>> also makes sure the new 0x500 handler doesn't overflow into the 0x600
>> exception handler.
>>
>> It would help to explain how you arrived at that '256 byte' number in
>> the changelog though.
>
> Honestly, I just counted instructions, multiplied by 8 and rounded up
> to the next nearest power of 2, and the result felt right for giving
> some level of flexibility for code growth before tripping the WARN. :P
>
> I'm happy to adjust, of course. :)

What if we write it:

       char saved_0x500[0x600 - 0x500];

Hopefully the compiler is smart enough not to generate a VLA for that :)

cheers
