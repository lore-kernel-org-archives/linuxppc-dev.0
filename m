Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 27C3D67BC9
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 05:21:14 +1000 (EST)
Message-ID: <44FB2BAF.1080509@ru.mvista.com>
Date: Sun, 03 Sep 2006 23:23:27 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please pull powerpc.git 'merge' branch
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Linus Torvalds wrote:

> I wrote a sparse extension that warns if an initializer tries to 
> initialize the same entry multiple times.

    Ugh, I expected the C compiler to catch this... :-/

> Look what it found:

>  - arch/powerpc/platforms/powermac/pfunc_base.c:259
> 
> 	static struct pmf_handlers macio_mmio_handlers = {
> 	        .write_reg32            = macio_do_write_reg32,
> 	        .read_reg32             = macio_do_read_reg32,
> 	        .write_reg8             = macio_do_write_reg8,
> 	        .read_reg32             = macio_do_read_reg8,

    Cut and paste error, should be .read_reg8...

> 	        .read_reg32_msrx        = macio_do_read_reg32_msrx,
> 	        .read_reg8_msrx         = macio_do_read_reg8_msrx,
> 	        .write_reg32_slm        = macio_do_write_reg32_slm,
> 	        .write_reg8_slm         = macio_do_write_reg8_slm,
> 	        .delay                  = macio_do_delay,
> 	};

> Can anybody see anything suspicious there?

    I'm sorry for spoiling the fun for everybody else. ;-)

WBR, Sergei
