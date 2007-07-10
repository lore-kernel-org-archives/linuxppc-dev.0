Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18066.63111.703924.714899@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 13:01:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
In-Reply-To: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> In older versions of glibc (through 2.3), the dynamic linker executes a
> small amount of code from the data segment, which is not marked as
> executable.  A recent change (commit 9ba4ace39fdfe22268daca9f28c5df384ae462cf)
> stops this from working; there should be a deprecation period before
> older glibc versions stop working.

Actually I see no good reason to enforce no-exec at all if we can't do
it consistently.  And if we're not going to enforce it then there is
no point whinging about it.

When I applied Segher's original patch I thought that we had the
read-implies-exec stuff enabled for the affected CPUs, but it turns
out we don't.  (We only have that stuff turned on for 32-bit processes
on 64-bit cpus - see elf_read_implies_exec in include/asm-powerpc/elf.h.)

Paul.
