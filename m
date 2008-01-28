Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 6A87ADDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 10:00:24 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2536758pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 15:00:23 -0800 (PST)
Message-ID: <5ee408090801281500q467fe03anf00a5a31a5473846@mail.gmail.com>
Date: Mon, 28 Jan 2008 21:00:22 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Linux boot on a ppc 405
In-Reply-To: <20080128225505.22226C20071@mail131-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479CAF56.30306@gmail.com>
	<fa686aa40801271315m5ba4ea08p913fd6235eb1d240@mail.gmail.com>
	<5ee408090801281453l3e6fe3e5x2f8f1b0b130ad163@mail.gmail.com>
	<20080128225505.22226C20071@mail131-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Steve,

I tried that, but the System.map is not the real memory address, it's
processed by the mmu isn't it?

This is my System.map: c01e0cc4 b __log_buf
when I try to look at the position 0xc01e0cc4 the debugger returns:
Error: Cannot access memory at address 0xc01e0cc4

Am I doing something wrong?

Thanks,

On Jan 28, 2008 8:55 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> You have to look at the System.map file, find the __log_buf symbol, and
> then look at the address manually.
>
> Steve
>
>
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
> > bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Ricardo
> Ayres Severo
> > Sent: Monday, January 28, 2008 2:53 PM
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: Linux boot on a ppc 405
> >
> > Grant,
> >
> > my output is the following:
> >
> > loaded at:     00400000 004E919C
> >
> > board data at: 00000000 0000007C
> >
> > relocated to:  00404040 004040BC
> >
> > zimage at:     00404E2C 004E620A
> >
> > avail ram:     004EA000 8DA05119
> >
> >
> > Linux/PPC load: console=ttyUL0,9600
> >
> > Uncompressing Linux...done.
> >
> > Now booting the kernel
> >
> >
> >
> > nothing shows up next.
> > I tried to look at __log_buf but the debugger doesn't recognize it.
> > The debugger only knows the code of the part that boots the kernel.
> > I also tried setting ttyUL0 and ttyS0 for the linux console.
> > Any ideas of how I can get the real position of __log_buf?
> >
> > Thanks,
> >
> > On Jan 27, 2008 7:15 PM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
> > > On 1/27/08, Ricardo Severo <severo.ricardo@gmail.com> wrote:
> > > > Hi all,
> > > >
> > > > I am working with a Xilinx Virtex II Pro  evaluation board, wich
> has two
> > > > PowerPC 405 and I'm trying to boot a vanilla linux kernel
> 2.6.23.14.
> > > > Until now I've manged to make it uncompress the kernel, but it
> doesn't boot.
> > > > My question is how the initial execution (the one who uncompresses
> the
> > > > kernel image) transfers the processor to the kernel itself. I've
> looked
> > > > in the arch/ppc/boot/simple/relocate.S code and it jumps to the
> position
> > > > 0x0 after uncompressing, is it right? The kernel is uncompressed
> at that
> > > > position?
> > >
> > > Post your output log please.
> > >
> > > If your getting a message that the kernel is uncompressing, but you
> > > don't have any output beyond that then most likely your console is
> not
> > > setup correctly.  If you've got a debugger, look at memory at the
> > > __log_buf location to see if there are any boot logs there.
> > >
> > > Cheers,
> > > g.
> > >
> > >
> > > --
> > > Grant Likely, B.Sc., P.Eng.
> > > Secret Lab Technologies Ltd.
> > >
> >
> >
> >
> > --
> > Ricardo Ayres Severo <severo.ricardo@gmail.com>
>
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>



-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
