Date: Thu, 19 Oct 2000 18:19:11 -0700
From: Matt Porter <mmporter@home.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: Alois Fertl <alois_fertl@talknet.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: initial console
Message-ID: <20001019181911.A1175@cx258813-a.chnd1.az.home.com>
References: <39EE00CA.BE9889DC@talknet.de> <Pine.LNX.4.21.0010191410170.8107-100000@ipnpcu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0010191410170.8107-100000@ipnpcu5>; from grave@ipno.in2p3.fr on Thu, Oct 19, 2000 at 02:16:35PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 19, 2000 at 02:16:35PM +0200, Xavier Grave wrote:
>
> On Wed, 18 Oct 2000, Alois Fertl wrote:
> >
> > The problem you are seeing here is probably prep_init in prep_setup.c
> > not copying the arguments passed by the boot loader into the kernels command
> > line. Your root=/dev/sda5 is probably ignored.
> > Look at your early log messages during boot. There should be a line
> > "Boot arguments: ..." telling you those things seen by the kernel.
> Indeed, The kernel argument I give is :
> root=/dev/sda5
> and during the boot when I look more closely :
> PReP architecture
> Boot arguments: /dev/sda1
>
> > In case the arguments aren't as you typed them, try putting the following
> > lines at the beginning of prep_init:
> >
> > +       if (r6) {
> > +               *(char *)(r7 + KERNELBASE) = 0;
> > +               strcpy(cmd_line, (char *)(r6 + KERNELBASE));
> > +       }
> Ok, this is fine my kernel boots ! Thank you very much.
> > What hardware is this running on? If it is Motorola VME this failure is only
> > the starting point and other trouble will follow. There are additional fixes
> > but I can't verify them against a working source at the moment. test9 and
> > test10
> > from fmlabs currently both panic during init as soon as the process starts
> > using the hard drive (this is on a PowerStack).
>
> I have a MVME2303 from motorola diskless + a PMC with a 53c895 pci board
> for my disk. With the 2.2.17 kernel all works well.
> And now with the latest fsmlabs + your hack all function !

Sorry, I had this change locally but hadn't pushed it yet. :)  The other
option on PReP is to build with /dev/nvram support and then (on a
PPCBUG system) use 'gevedit bootargs' to set a kernel argument command
line like "root=/dev/sda5".  That's often more convenient then hard
coding in your parameters like with the PReP cmd_line config option.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
