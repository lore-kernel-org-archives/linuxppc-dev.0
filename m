Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 197D5679E8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 09:04:22 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Reiser <jreiser@BitWagon.com>
In-Reply-To: <4287CF06.5000809@BitWagon.com>
References: <4287CF06.5000809@BitWagon.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 09:01:53 +1000
Message-Id: <1116198114.5095.43.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-05-15 at 15:36 -0700, John Reiser wrote:
> The 2GB limit on TASK_SIZE for user address space on 32-bit PowerPC
> Apple Macintosh is getting in the way of database, filesystem
> maintenance, and scientific applications.  In user mode, most
> i686 desktops can address 3GB.  While 64-bit systems are becoming
> available, the vast majority of existing systems are still 32-bit.
> What can be done to get a larger address space for existing Macs?
> 
> According to arch/ppc/syslib/prom_init.c, the first problem is
> that CONFIG_BOOTX_TEXT restricts CONFIG_TASK_SIZE to only 0x80000000.
> Is this an initialization-only restriction that just happens
> to persist beyond initialization?  What would it take to remove
> this collision from affecting life after boot?  How much of booting
> does CONFIG_BOOTX_TEXT affect?

The limitation related to CONFIG_BOOTX_TEXT is only a problem on G5,
which isn't supported for 32 bits kernel anymore anyway. "Normal" 32
bits kernel should work fine with TASK_SIZE set to 3Gb. However, there
is another reason why it defaults to 2GB currently, and it is non-32
bits machines.

We "inherited" from some historic junk in the prep and chrp support,
that a lot of embedded platforms blindly copied, where archs use
io_block_mapping() early during boot to hard-wire various IO stuffs in
various places in the address space, including just after 2Gb. It's
totally bogus, but nobody really cared to fix it so far. The 2Gb
TASK_SIZE limit doesn't seem to have ever been an issue for ppc32 users
so far I must say, at least you are the first one to complain ;)

Anyway, nothing prevents you, on a Mac, to force it to 3Gb in
the .config, it will work fine hopefully.  If you are using a G5, just
use a 64 bits kernel.

Ben.
