Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18052.42546.78964.805791@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2007 16:26:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Please pull from 'for_paulus' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

Unfortunately with those commits I get this when compiling for a
64-bit target:

{standard input}: Assembler messages:
{standard input}:668: Error: Unrecognized opcode: `sldi'
{standard input}:676: Error: Unrecognized opcode: `sldi'
{standard input}:694: Error: Unrecognized opcode: `sldi'
{standard input}:952: Error: Unrecognized opcode: `slwi'
{standard input}:953: Error: Unrecognized opcode: `sldi'
{standard input}:1121: Error: Unrecognized opcode: `sldi'
{standard input}:1359: Error: Unrecognized opcode: `sldi'
{standard input}:1464: Error: Unrecognized opcode: `srdi'
make[2]: *** [init/main.o] Error 1
make[1]: *** [init] Error 2
make: *** [_all] Error 2

It turns out that with Arnd's patches we now get "-mcpu=powerpc64" on
the command line, and that means that gcc *doesn't* put "-mppc64" the
as command line, and as barfs on the 64-bit instructions.  That's
presumably a gcc bug, but we'll have to work around it.  I think the
best thing is just to not put the -mcpu=powerpc64 in CFLAGS when no
specific CPU is selected.

Paul.
