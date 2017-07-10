Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5j2C5drLzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 21:01:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: luigi burdo <intermediadc@hotmail.com>,
 "linuxppc-dev\@ozlabs.org" <linuxppc-dev@ozlabs.org>
Cc: "kbuild-all\@01.org" <kbuild-all@01.org>
Subject: Re: issue with kernel 4.12.rc6 addnote -kernel dont build
In-Reply-To: <AM5P194MB013262D4AE4121CF72E1DDA9C8D10@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <1498652022-10417-2-git-send-email-mpe@ellerman.id.au>
 <201707021731.2m4fORfG%fengguang.wu@intel.com>
 <AM5P194MB013262D4AE4121CF72E1DDA9C8D10@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 10 Jul 2017 21:01:22 +1000
Message-ID: <8760f0v9ml.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

luigi burdo <intermediadc@hotmail.com> writes:

> Hi all, kernel here is not building.

Did it just stop working? That code is from 2014?

> attached file will explain better than my poor english.
>
> Host Machine BE Qoriq e5500  16GB ram

What userspace are you running? Is it 32-bit ?

>  HOSTCC  arch/powerpc/boot/addnote
   ^^^^^^
   What compiler is that?

Building with V=3D1 should show you.

> arch/powerpc/boot/addnote.c: In function =E2=80=98main=E2=80=99:
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width =
of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \

These warnings seem like they're correct, but that code should never
actually run on 32-bit so it should be harmless.

> mv: cannot move 'arch/powerpc/boot/.addnote.tmp' to 'arch/powerpc/boot/.a=
ddnote.cmd': No such file or directory
> scripts/Makefile.host:107: recipe for target 'arch/powerpc/boot/addnote' =
failed
> make[1]: *** [arch/powerpc/boot/addnote] Error 1

But they're only warnings, so they shouldn't be breaking the build AFAICS.

cheers
