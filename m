Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqq9l2NWhzF1KZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 04:50:34 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id y127so10393369vky.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 09:50:34 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUswNE1ydgeESpG8Dqtz4SGFjZZJJiPp+SHN8Z1qtBtPLLQ@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-7-malat@debian.org>
 <8862c1e1-d161-3410-1b2a-502ad06cef57@c-s.fr>
 <6cba215c-127e-f3eb-b525-773b6aed0eb7@c-s.fr>
 <CA+7wUswNE1ydgeESpG8Dqtz4SGFjZZJJiPp+SHN8Z1qtBtPLLQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 26 Feb 2018 18:50:11 +0100
Message-ID: <CA+7wUsx047shRJ92PJ+cvg24HNhMnYzM0t5zUdEOaSE00sXkSg@mail.gmail.com>
Subject: Re: [PATCH 06/21] powerpc: Avoid comparison of unsigned long >= 0 in
 __access_ok
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
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

On Mon, Feb 26, 2018 at 8:44 AM, Mathieu Malaterre <malat@debian.org> wrote=
:
> On Mon, Feb 26, 2018 at 7:50 AM, Christophe LEROY
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>> Le 26/02/2018 =C3=A0 07:34, Christophe LEROY a =C3=A9crit :
>>>
>>>
>>>
>>> Le 25/02/2018 =C3=A0 18:22, Mathieu Malaterre a =C3=A9crit :
>>>>
>>>> Rewrite check size - 1 <=3D Y as size < Y since `size` is unsigned val=
ue.
>>>> Fix warning (treated as error in W=3D1):
>>>>
>>>>    CC      arch/powerpc/kernel/signal_32.o
>>>> In file included from ./include/linux/uaccess.h:14:0,
>>>>                   from ./include/asm-generic/termios-base.h:8,
>>>>                   from ./arch/powerpc/include/asm/termios.h:20,
>>>>                   from ./include/uapi/linux/termios.h:6,
>>>>                   from ./include/linux/tty.h:7,
>>>>                   from arch/powerpc/kernel/signal_32.c:36:
>>>> ./include/asm-generic/termios-base.h: In function
>>>> =E2=80=98user_termio_to_kernel_termios=E2=80=99:
>>>> ./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsig=
ned
>>>> expression >=3D 0 is always true [-Werror=3Dtype-limits]
>>>>     (((size) =3D=3D 0) || (((size) - 1) <=3D ((segment).seg - (addr)))=
))
>>>>                                     ^
>>>> ./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro
>>>> =E2=80=98__access_ok=E2=80=99
>>>>     __access_ok((__force unsigned long)(addr), (size), get_fs()))
>>>>     ^~~~~~~~~~~
>>>> ./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macr=
o
>>>> =E2=80=98access_ok=E2=80=99
>>>>    if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
>>>>        ^~~~~~~~~
>>>> ./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro
>>>> =E2=80=98__get_user_check=E2=80=99
>>>>    __get_user_check((x), (ptr), sizeof(*(ptr)))
>>>>    ^~~~~~~~~~~~~~~~
>>>> ./include/asm-generic/termios-base.h:36:6: note: in expansion of macro
>>>> =E2=80=98get_user=E2=80=99
>>>>    if (get_user(termios->c_line, &termio->c_line) < 0)
>>>>        ^~~~~~~~
>>>> [...]
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>> ---
>>>>   arch/powerpc/include/asm/uaccess.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/uaccess.h
>>>> b/arch/powerpc/include/asm/uaccess.h
>>>> index 51bfeb8777f0..fadc406bd39d 100644
>>>> --- a/arch/powerpc/include/asm/uaccess.h
>>>> +++ b/arch/powerpc/include/asm/uaccess.h
>>>> @@ -49,7 +49,7 @@
>>>>   #define __access_ok(addr, size, segment)    \
>>>>       (((addr) <=3D (segment).seg) &&        \
>>>> -     (((size) =3D=3D 0) || (((size) - 1) <=3D ((segment).seg - (addr)=
))))
>>>> +     (((size) =3D=3D 0) || ((size) < ((segment).seg - (addr)))))
>>>
>>>
>>> IIUC, ((2 - 1) <=3D 1) is the same as (2 < 1) ?????
>>
>
> The whole series was pretty mediocre, but this one was actually pretty
> destructive. Thanks for catching this.
>
>>
>> Note that I already try to submit a fix for this warning 3 years ago
>> (https://patchwork.ozlabs.org/patch/418075/) and it was rejected with th=
e
>> following comment:

Tested again today with gcc 6.3.0 and gcc is still producing the
original warning (treated as error).

>> Again, I don't think Linux enables this warning.  What did you do to
>> produce this?  In any case, it's a bad warning that doesn't take macros
>> into account, and the answer is not to make the code less clear by hidin=
g
>> the fact that zero is a special case.
>
> Right. I'll try to see how to make W=3D1 run without error with an
> alternate solution.

So the other alternative is to update a bunch of ppc32 defconfig(s)
with: CONFIG_PPC_DISABLE_WERROR=3Dy.

Would that be preferable ?

>> Christophe
>>
>>
>>>
>>> Christophe
>>>
>>>>   #endif
>>>>
>>
