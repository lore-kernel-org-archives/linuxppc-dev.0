Date: Fri, 6 Aug 1999 10:08:04 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Neil Blackwood <nb@terrafix.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PROBLEMS BOOTING KERNEL ON EMBEDDED PROCESSOR MBX821
In-Reply-To: <000101bedfdd$9250fc20$6401a8c0@everyone>
Message-ID: <Pine.LNX.4.10.9908061005520.31686-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 5 Aug 1999, Neil Blackwood wrote:
>         I have just downloaded the 2.2.0pre6 kernel for MBX8xx processors
> from
> the embedded directory of linuxppc.cs.nmt.edu.
> We are running it on a MXX821-004A development board.
> Unfortunately we seem to have a problem during the booting of the kernel.
> The messages
> 
>                         iack = -1
> 
> and
>                         irq = 7
> 
> are displayed continuously.
> 
> We have managed to track down the iack message in the kernel source.
> In directory
> linux/arch/ppc/kernel
> in File
> ppc8xx_pic.c
> In function
> 
> mbx_i8259_action()
> is the code
> 
>                 int irq;
> 
>                 irq = (inl(0x508)>>24)&0xff;
>                 if (irq!= 0xff)printk("iack 5d\n", irq);
> 
> We think this is inconsistent if the value of irq is printed out as -1.

The first thing in my mind that gets triggered by this is unsigned vs. signed
chars. On most systems, `char' defaults to `signed char', but on PPC it
defaults to `unsigned char'. Either behavior complies with the C standard.
But I don't see where it gets wrong here :-(

> ps Is this type of enquiry suitable for this mailing list or should I use
> USERS.

IMHO this is the correct list.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
