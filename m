Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.225])
	by ozlabs.org (Postfix) with ESMTP id 484CEDDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 06:19:04 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1214570qbe
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 13:19:03 -0700 (PDT)
Message-ID: <fa686aa40708101319s27fe5cd4sdc0f295f0e4cfac@mail.gmail.com>
Date: Fri, 10 Aug 2007 14:19:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: windstorm <likunarmstrong@gmail.com>
Subject: Re: some questions about XUP and the generation of ace file
In-Reply-To: <c46c91d0708100937h50fb37fcgff2f66db6207e025@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c46c91d0708100613m61d8a6d9gc4ca8b379e59fca6@mail.gmail.com>
	<fa686aa40708100714m469fb7bdm3757ccf35f6a97db@mail.gmail.com>
	<c46c91d0708100937h50fb37fcgff2f66db6207e025@mail.gmail.com>
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

On 8/10/07, windstorm <likunarmstrong@gmail.com> wrote:
> 1 it's strange. the ns16550.c do exist in the arch/ppc/boot/
> directory, not arch/ppc/boot/common. I just download the source
> yesterday.
>
> 2 Can you show me some reference about the "small bootloader"? Or any
> web material about it?

Sorry, I don't have anything I can publish.  I just grabbed some elf
decoding code from CFE (Common firmware environment which uses a BSD
style license) and bound it up with the Xilinx FAT driver.  It wasn't
very hard to do.

g.

>
> 2007/8/10, Grant Likely <grant.likely@secretlab.ca>:
> > On 8/10/07, windstorm <likunarmstrong@gmail.com> wrote:
> > > Hello all:
> > >
> > > I am trying to transfer the Linux onto XUP board. The kernel source I
> > > used is from the git trees from andrei konovalov or grant likely. But
> > > I encounter two questions now.
> > >
> > > 1 Generally, I should correct the kernel source file
> > > arch/ppc/boot/common/ns16550.c, In that file, changing SERIAL_BAUD
> > > from 9600 to 38400  makes the bootloader talk at 38400. I always do it
> > > when I use standard kernel source. But this time I found out that the
> > > ns16550.c's path is arch/ppc/boot/, not arch/ppc/boot/common/, and
> > > there was no "SERIAL_BAUD" string any more. So, how can I control the
> > > baud rate?
> >
> > ???
> >
> > I don't know what you're referring to.  ns16550.c is in
> > arch/ppc/boot/common on my tree, and it still contains the SERIAL_BAUD
> > #define.
> >
> > >
> > > 2 I have compiled the kernel and obtained a Image.elf whose size is
> > > 1.7MB, and then it's time for creating a system.ace file which I can
> > > put onto a compact flash card.  I Changed the file xupGenace.opt like
> > > the follow:
> >
> > You can do this, but I don't think it's a particularly good idea.
> > Binding the kernel image into an ACE file results in a *very* large
> > ace file, and it's slow.  Consider the fact that doing it that way
> > means that you're transferring the entire 1.7MB image via JTAG.
> >
> > I've also seem problems where DDR isn't fully initialized before the
> > SystemACE tries to transfer the image which results in a non-booting
> > system.
> >
> > What I do, is I've got a small bootloader that lives in BRAM and is
> > just smart enough to load an elf file off of the CF card.  If I can
> > get permission to do so, I'll publish the source for my utility.
> >
> > >
> > > -jprog
> > > -board user
> > > -target ppc_hw
> > > -hw ./implementation/download.bit
> > > -elf zImage.elf
> > > -configdevice devicenr 1 idcode 0x1127e093 irlength 14 partname xc2vp30
> > > -debugdevice devicenr 1 cpunr 1
> > > -ace system.ace
> > >
> > > and executed the command: xmd -tcl genace.tcl -opt genace.opt
> > >
> > > and the result I saw is:  Using GenACE option file : genace.opt
> > > Error: Executable zImage.elf does not contain start address..
> > >
> > > I examine the information by google, some said that it's the bug of
> > > development tools without sp, but both my ISE and EDK was patched.
> > > Others said that it's because of the "mb-objdump", we should chage it
> > > into "powerpc-eaci-objdump", and actually I had done this correction.
> > > BUT, the error still here.
> > >
> > > Could anyone please to help me about this question? I will be very grateful.
> >
> > Very odd.  I haven't seen this problem myself so I can't be much help. sorry.
> >
> > >
> > > BTW, could any kind person send any basic config file, which had been
> > > proved that the kernel compiled based on it could work good on XUP
> > > board?
> >
> > I don't have that board, sorry
> >
> > g.
> >
> > --
> > Grant Likely, B.Sc., P.Eng.
> > Secret Lab Technologies Ltd.
> > grant.likely@secretlab.ca
> > (403) 399-0195
> >
>
>
> --
> web: http://www.forwind.cn
> msn: likunarmstrong at hotmail.com
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
