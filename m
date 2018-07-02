Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KDSh0km6zF1LS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 03:16:51 +1000 (AEST)
Date: Mon, 2 Jul 2018 12:16:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180702171631.GA16221@gate.crashing.org>
References: <20180629185339.GA37582@beast>
 <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
 <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
 <87fu12mnf7.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu12mnf7.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 02, 2018 at 11:33:32AM +1000, Michael Ellerman wrote:
> What if we write it:
> 
>        char saved_0x500[0x600 - 0x500];
> 
> Hopefully the compiler is smart enough not to generate a VLA for that :)

It is a VLA if the array size is not an integer constant expression.  This
is defined by C; the compiler has nothing to do with it.  0x600-0x500 is
an integer constant expression, so this is not a VLA.

But if you meant if GCC will ever do a dynamic stack allocation for a fixed
size local variable: yes indeed, I hope not!

(Sometimes GCC can avoid this even with VLAs; but in this example we do
not even have a VLA, so it's easier than that :-) )


Segher
