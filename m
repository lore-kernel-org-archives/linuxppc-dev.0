Return-Path: <glaubitz@physik.fu-berlin.de>
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVsv1109NzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 19:52:28 +1000 (AEST)
Subject: Re: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
References: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
 <20160907012356.GA21443@fergus.ozlabs.ibm.com>
 <87a8fhlv2t.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <5f47ce4e-646f-9532-307a-2904c298e64e@physik.fu-berlin.de>
Date: Fri, 9 Sep 2016 11:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <87a8fhlv2t.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/2016 03:29 AM, Michael Ellerman wrote:
> Interestingly it builds fine for me, even for 32-bit configs, I assume
> because my toolchains are 32/64-bit they are able to cope with it. I'll
> try and built a 32-bit only toolchain to catch these problems in future.

Yeah, I was just asking myself the same question after seeing your patch
on the list as the kernel package builds fine on Debian's powerpc port [1].

However, the powerpc Debian package always builds a 64-bit kernel image
as well in order to be able to use a 32-bit userland on a 64-bit kernel
when the hardware is capable of 64-bit. So, your guess above might actually
be true, but I haven't tested it.

What I do know is that "ld" is definitely not available on PowerPC e500
while "lwz" is available, see 3-68 in the e500 reference manual [2].

Thanks for the quick fix!

Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=4.7.2-1&stamp=1472464832
> [2] http://www.nxp.com/files/32bit/doc/ref_manual/E500CORERM.pdf

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
