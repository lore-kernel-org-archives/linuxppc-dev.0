Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E790B67A6D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 18:32:39 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 29 Mar 2005 10:32:11 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050329083211.GA27952@iram.es>
References: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
	<1112048510.5410.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112048510.5410.60.camel@gaston>
Cc: Tom Rini <trini@kernel.crashing.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: ASM formatting rules?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2005 at 08:21:50AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2005-03-28 at 10:44 -0600, Kumar Gala wrote:
> > Guys,
> > 
> > While this is not overly important to me, I was wondering if we had any 
> > rules related to formatting of assembly files.  We seem to have code 
> > formatted with and without spaces in the args.
> > 
> > I'm assuming something like this (w/o spaces):
> > 
> > <TAB>insn<TAB>argD,arg1,arg2
> > 
> > is what we want?  Just trying to get a rule documented going forward.
> 
> I used to have argD, arg1, arg2 but since everything else was "compact",
> I now tend to adapt to everything else ;)

Assembly is not C! I don't like the space after the comma in
assembly, but can adapt to (almost) any style.

For the record, the biggest file of PPC assembly I wrote 
(the real mode x86 emulator to initialize graphics board
through BIOS emulation) is really atypical:

1) it has two tabs before the opcode, because it must  
accomodate really_long_labels and a single tab is not enough.

2) only a space between the opcode and the operands, but many 
registers have fixed uses and have mnemonic names through #defines.
This helps a lot for readability and maintainability. See 4)
for the reason.

3) no space after the comma between operands.

4) Sometimes several instructions separated by a semicolon in 
the same line, but only the first instruction may have a label. 
That's because at the time I wanted to see as much as possible 
on a small screen. But this does not mix well with putting
tabs between instruction and operands, hence 2).

I don't think these rules ar generally applicable to 
assembly files, these were specific rules which matched
my needs for this file (5000 lines).

	Gabriel
