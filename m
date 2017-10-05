Return-Path: <keescook@google.com>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7KY30Qk5zDr57
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 04:30:29 +1100 (AEDT)
Received: by mail-it0-x232.google.com with SMTP id y138so2297516itc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 10:30:29 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <6e6bf9ba-d66c-0bcc-358e-fed97b2ca5cd@c-s.fr>
References: <20171005034505.GA32157@beast>
 <6e6bf9ba-d66c-0bcc-358e-fed97b2ca5cd@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Oct 2017 10:30:25 -0700
Message-ID: <CAGXu5jLx+eMYrehvrT7+3V3Joa6VDAbhkLLDndC5aYLxJGmhYA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Default to enabling STRICT_KERNEL_RWX
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 5, 2017 at 12:49 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 05/10/2017 =C3=A0 05:45, Kees Cook a =C3=A9crit :
>>
>> When available, CONFIG_KERNEL_RWX should be default-enabled.
>
>
> On PPC32, this option implies deactivating BATs and/or LTLB mapping of th=
e
> linear kernel address space, hence a significant performance degradation.
>
> So at least on PPC32, it should remain unselected by default.

Alright, sounds fine to me. Would this be okay?

+       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if !PPC64

-Kees

>
> Christophe
>
>
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/powerpc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 809c468edab1..9a549bbfc278 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -178,6 +178,7 @@ config PPC
>>         select HAVE_ARCH_TRACEHOOK
>>         select ARCH_HAS_STRICT_KERNEL_RWX       if ((PPC_BOOK3S_64 ||
>> PPC32) && !RELOCATABLE && !HIBERNATION)
>>         select ARCH_OPTIONAL_KERNEL_RWX         if
>> ARCH_HAS_STRICT_KERNEL_RWX
>> +       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>>         select HAVE_CBPF_JIT                    if !PPC64
>>         select HAVE_CONTEXT_TRACKING            if PPC64
>>         select HAVE_DEBUG_KMEMLEAK
>>
>



--=20
Kees Cook
Pixel Security
