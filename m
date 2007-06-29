Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F350DDEF4
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 17:05:03 +1000 (EST)
In-Reply-To: <18052.42546.78964.805791@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C780633-8136-4CBE-9E32-2B8596A53AFC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 02:04:51 -0500
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


On Jun 29, 2007, at 1:26 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
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
> {standard input}:676: Error: Unrecognized opcode: `sldi'
> {standard input}:694: Error: Unrecognized opcode: `sldi'
> {standard input}:952: Error: Unrecognized opcode: `slwi'
> {standard input}:953: Error: Unrecognized opcode: `sldi'
> {standard input}:1121: Error: Unrecognized opcode: `sldi'
> {standard input}:1359: Error: Unrecognized opcode: `sldi'
> {standard input}:1464: Error: Unrecognized opcode: `srdi'
> make[2]: *** [init/main.o] Error 1
> make[1]: *** [init] Error 2
> make: *** [_all] Error 2
>
> It turns out that with Arnd's patches we now get "-mcpu=powerpc64" on
> the command line, and that means that gcc *doesn't* put "-mppc64" the
> as command line, and as barfs on the 64-bit instructions.  That's
> presumably a gcc bug, but we'll have to work around it.  I think the
> best thing is just to not put the -mcpu=powerpc64 in CFLAGS when no
> specific CPU is selected.

I dropped the patch and re-pushed my tree w/o it.

Let me know if you have any issues.

- k
