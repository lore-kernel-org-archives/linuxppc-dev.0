Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KRgb3m6zzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 11:42:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
In-Reply-To: <20180702171631.GA16221@gate.crashing.org>
References: <20180629185339.GA37582@beast>
 <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
 <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
 <87fu12mnf7.fsf@concordia.ellerman.id.au>
 <20180702171631.GA16221@gate.crashing.org>
Date: Tue, 03 Jul 2018 11:41:59 +1000
Message-ID: <8736x1gkns.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jul 02, 2018 at 11:33:32AM +1000, Michael Ellerman wrote:
>> What if we write it:
>> 
>>        char saved_0x500[0x600 - 0x500];
>> 
>> Hopefully the compiler is smart enough not to generate a VLA for that :)
>
> It is a VLA if the array size is not an integer constant expression.  This
> is defined by C; the compiler has nothing to do with it.  0x600-0x500 is
> an integer constant expression, so this is not a VLA.

Thanks.

That wasn't meant as a dig at GCC. Kees had an epic struggle with the
kernel's min/max() macros which were causing expressions that looked
like they should be constant to generate VLAs.

> But if you meant if GCC will ever do a dynamic stack allocation for a fixed
> size local variable: yes indeed, I hope not!

Hey that would be cool, just-in-time local variable allocation :)

cheers
