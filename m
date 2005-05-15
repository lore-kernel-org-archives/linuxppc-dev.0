Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A845C679E9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 09:36:59 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17031.56167.926193.391545@cargo.ozlabs.ibm.com>
References: <4287CF06.5000809@BitWagon.com> <1116198114.5095.43.camel@gaston>
	<17031.56167.926193.391545@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 09:34:29 +1000
Message-Id: <1116200069.5095.51.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-16 at 09:29 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > We "inherited" from some historic junk in the prep and chrp support,
> > that a lot of embedded platforms blindly copied, where archs use
> > io_block_mapping() early during boot to hard-wire various IO stuffs in
> > various places in the address space, including just after 2Gb. It's
> > totally bogus, but nobody really cared to fix it so far. The 2Gb
> > TASK_SIZE limit doesn't seem to have ever been an issue for ppc32 users
> > so far I must say, at least you are the first one to complain ;)
> 
> I believe that prep and chrp are also now OK with a 3GB TASK_SIZE
> limit, it's just various embedded board ports that will blow up with
> 3GB.  We should change the default to 3GB to encourage the embedded
> guys to fix their ports properly (or else to put in the appropriate
> Kconfig stuff to force it back to 2GB for their port).
> 

static void __init
prep_map_io(void)
{
	io_block_mapping(0x80000000, PREP_ISA_IO_BASE, 0x10000000, _PAGE_IO);
	io_block_mapping(0xf0000000, PREP_ISA_MEM_BASE, 0x08000000, _PAGE_IO);
}

We need to fix that too :) Though I suppose we can just switch that to
page tables, I don't really see the point of using a BAT here...

Ben.
