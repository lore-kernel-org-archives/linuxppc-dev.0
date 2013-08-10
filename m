Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FEA22C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Aug 2013 03:48:08 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: Build errors on mainline kernel
References: <20130809182446.GA26711@us.ibm.com>
 <EA801718-CA2E-4F85-AF6B-29119911038E@kernel.crashing.org>
 <20130810010119.GA29407__43692.6458766267$1376096568$gmane$org@us.ibm.com>
 <m2y58axbi8.fsf@linux-m68k.org> <20130810164526.GA11718@us.ibm.com>
Date: Sat, 10 Aug 2013 19:47:55 +0200
In-Reply-To: <20130810164526.GA11718@us.ibm.com> (Sukadev Bhattiprolu's
 message of "Sat, 10 Aug 2013 09:45:27 -0700")
Message-ID: <874nax8mk4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Andreas Schwab [schwab@linux-m68k.org] wrote:
> | Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> | 
> | > {standard input}: Assembler messages:
> | > {standard input}:244: Error: junk at end of line: `1'
> | > make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
> | > make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2
> | > make: *** [sub-make] Error 2
> | 
> | Run "make arch/powerpc/platforms/85xx/smp.s" to create the assembler
> | file.
>
> Ok. Here are few lines around 244, the whole file is below. I can't
> find the junk '1'. There is a '1' at EOL on 240 but that is also
> on several lines in the file.

The offending line is line 307 (due to the added comments at the start):

        mfcr 0,1         # tmp145, tmp146

This is a Power4 insn, but you are compiling for e500.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
