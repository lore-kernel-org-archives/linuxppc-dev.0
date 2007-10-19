Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 60813DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 16:28:10 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Fri, 19 Oct 2007 01:28:02 -0500
References: <boot-8-00.miltonm@bga.com>
	<440d60abf1ef533839cf5d9beb0584c9@bga.com>
	<fa686aa40710181029o6852b1b0pf6259f27cabfd085@mail.gmail.com>
In-Reply-To: <fa686aa40710181029o6852b1b0pf6259f27cabfd085@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710190128.02537.rob@landley.net>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 18 October 2007 12:29:08 pm Grant Likely wrote:
> On 10/18/07, Milton Miller <miltonm@bga.com> wrote:
> > If we say only some boards or ports are special and need to build then
> > I would vote for shipping asm files.  If we think we need to build any
> > random embedded platform without installing dtc then we should merge
> > dtc.
>
> I don't think we do.  It's looking like there are going to be out of
> tree users of dtc also (The are some patches floating around for
> u-boot to use the device tree for it's own initialization).  I don't
> think it's unreasonable to install dtc for embedded development.

There are out of tree users of yacc and lex, but the kernel has *.c_shipped 
files so as not to require that external tool of people who simply want to 
build the sucker without modifying it.  "make oldconfig" was modified not to 
require curses.

How about *.S_shipped files?

> I like the idea of shipping asm files to support the qemu target; at
> least until qemu gets better firmware.

I've now gotten qemu to boot a kernel I built, using Milton's 1/2 patch and a 
a self-contained build of a 4k ppc_boot.rom (which includes the dtc source 
because I don't expect anybody else to have it installed, either).  
Description and links to source, binaries, and build scripts in this message:

http://lists.gnu.org/archive/html/qemu-devel/2007-10/msg00415.html

There's a problem with qemu-cvs (detailed in the message), but qemu-system-ppc 
0.9.0 boots fine, up to a shell prompt.

> Cheers,
> g.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
