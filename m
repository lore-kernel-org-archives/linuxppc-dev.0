Date: Wed, 28 Nov 2001 11:50:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
Message-ID: <20011128115028.A29154@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111281714.AA27362@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111281714.AA27362@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 09:14:42AM -0800, Michael Sokolov wrote:
>
> Armin Kuster <akuster@mvista.com> wrote:
>
> > AFAIK your board header should go in include/asm-ppc/platforms and your
> > board.c file should go arch/ppc/platforms
>
> Then are all the platforms that have their headers together with source files
> in arch/ppc/platforms and nothing in include/asm-ppc wrong? For example, back
> in MVista's 2.2 tree k2.h was in include/asm-ppc, but when I got to the public
> tree, which by then was linuxppc_2_4_devel, it moved to arch/ppc/kernel and is
> now in arch/ppc/platforms.

There's no exact way right now.  But it breaks down like this, if you
have a port which does _not_ need to change include/asm-ppc/serial.h,
they can all go in arch/ppc/platforms.  If you change
include/asm-ppc/serial.h AND newBoard_serial.h needs to include
newBoard.h, they both go in include/asm-ppc/platforms/.

If you're 8xx or 8260 tho, they always go in include/asm-ppc/platforms
because of how m8xx/m8260 ports work.

And there's always exceptions to the rule to boot :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
