Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FABCDDF52
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 19:15:45 +1000 (EST)
In-Reply-To: <18052.42546.78964.805791@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fd3e668b664f28db6aa3071b1abdc642@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 11:15:21 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Please pull from 'for_paulus' branch of
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git 
>> for_paulus
>
> Unfortunately with those commits I get this when compiling for a
> 64-bit target:
>
> {standard input}: Assembler messages:
> {standard input}:668: Error: Unrecognized opcode: `sldi'

[etc.]

> It turns out that with Arnd's patches we now get "-mcpu=powerpc64" on
> the command line, and that means that gcc *doesn't* put "-mppc64" the
> as command line, and as barfs on the 64-bit instructions.  That's
> presumably a gcc bug, but we'll have to work around it.

It is not.  -mcpu=powerpc64 doesn't select an ABI, and your
GCC presumably defaults to the 32-bit ABI.  Use -m64 on the
GCC command line, too, you need it, and it solves this issue
as a side effect.

It would be a bug if GCC would allow 64-bit insns in the
32-bit ABI for Linux, but that is currently not the case :-(

> I think the
> best thing is just to not put the -mcpu=powerpc64 in CFLAGS when no
> specific CPU is selected.

That would be the "use the compiler default CPU" option.


Segher
