Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PP6T3hPczDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 22:00:31 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so9770660oic.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 05:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <87sh4uj675.fsf@concordia.ellerman.id.au>
In-Reply-To: <87sh4uj675.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 9 Jul 2018 14:00:14 +0200
Message-ID: <CA+7wUsy2FmRhsX3OLkTPKh-9JCZCQKtTbbzP9=vLuEJ9Pn6QmA@mail.gmail.com>
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 8, 2018 at 1:53 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
> > Hi,
> >
> > Is there a good way (or a shortcut) to do something like:
>
> The best I know of is:
>
> > $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
> >   to get a PPC32/32BIT allmodconfig
>
> $ echo CONFIG_PPC64=n > allmod.config
> $ KCONFIG_ALLCONFIG=1 make allmodconfig
> $ grep PPC32 .config
> CONFIG_PPC32=y
>
> Which is still a bit clunky.
>
>
> I looked at this a while back and the problem we have is that the 32-bit
> kernel is not a single thing. There are multiple 32-bit platforms which
> are mutually exclusive.
>
> eg, from menuconfig:
>
>  - 512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx
>  - Freescale 85xx
>  - Freescale 8xx
>  - AMCC 40x
>  - AMCC 44x, 46x or 47x
>  - Freescale e200

Most Linux distro seems to have drop support for ppc32. So I'd suggest
to pick Debian powperc default config (but I agree that I am a little
biased here).

>
> So we could have a 32-bit allmodconfig, but we'd need to chose one of
> the above, and we'd still only be testing some of the code.
>
> Having said that you're the 2nd person to ask about this, so we should
> clearly do something to make a 32-bit allmodconfig easier, even if it's
> not perfect.
>
> cheers
