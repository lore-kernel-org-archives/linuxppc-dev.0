Date: Wed, 23 Dec 1998 14:23:30 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: "David S. Miller" <davem@dm.cobaltmicro.com>,
        Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
Subject: Re: TCPv4 checksum errors
In-Reply-To: <Pine.LNX.4.03.9812231013310.18310-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.981223141624.16086E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 23 Dec 1998, Geert Uytterhoeven wrote:

> In the mean time I got this from a `new' PPC hacker. I haven't tried it yet
> (still have to manually calculate checksums for my bad packets, too, sigh).
> 
> --------------------------------------------------------------------------------
> >From VANDROVE@vc.cvut.cz Wed Dec 23 10:11:44 1998
> Date: Tue, 22 Dec 1998 16:44:01 MET-1
> From: Petr Vandrovec Ing. VTEI <VANDROVE@vc.cvut.cz>
> To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> Subject: PPC checksumming...
> 
> Hello Geert,
>   I've found that Motorola Powerstack is much more happy after
> applying folowing patch:
> 
> diff -ur linux/include/asm-ppc/checksum.h linux/include/asm-ppc/checksum.h
> --- linux/include/asm-ppc/checksum.h Thu Apr 23 02:35:41 1998
> +++ linux/include/asm-ppc/checksum.h    Tue Dec 22 16:19:49 1998
> @@ -83,13 +83,13 @@
>                            unsigned int sum)
>  {
>      __asm__("
> -   add %0,%0,%1
> -   add %0,%0,%2
> -   add %0,%0,%0
> -   addi %0,%0,0
> +   addc %0,%0,%1
> +   adde %0,%0,%2
> +   adde %0,%0,%3
> +   addze %0,%0
>     "
>     : "=r" (sum)
> -   : "r" (daddr), "r"(saddr), "r"((ntohs(len)<<16)+proto*256), "0"(sum));
> +   : "r" (daddr), "r"(saddr), "r"((proto<<16)+len), "0"(sum));
>      return sum;
>  }
> 
> 
> Before applying, I've got TCPv4 bad checksum instead of Connection refused,
> now it works :-) and I finnaly found that on my PPC inetd was not started...
> But because of I'm learning PPC assembler only since today morning, I'm not
> sure whether it does what I think it should... If you find it useful,
> please post it to appropriate maintainer (DaveM or ... ?) I do not know,
> who invented original code, maybe Cort (according to comments around code),
> but it was not taken from linux/include/asm-sparc - I'm pretty sure :-)

This patch looks very reasonable. You absolutely need the carry for TCP
checksums. 

> With regards to matroxfb: I've found that PPC Bios did not assign addresses
> to Matrox : framebuffer was located at 0xFF800000, MMIO at FFFFC000,
> both overlapping itself :-( Unfortunately, after going through PREP PCI code
> they were relocated to 0x01800000 and 0x01FFC000 - still overlapping, but
> now values looks `normal' :-( And, it is worse, it looks like that
> only region 0x01000000 - 0x01FFFFFF is forwarded into PCI bus, so there
> is really resource starvation here... One 8MB framebuffer, 16KB MMIO,
> some MMIO of NCR825... Life is not simple.

What is your machine ? Can you try to embed you /usr/src/vmlinux
in my (relatively new) preploader found at:

	ftp://vcorr1.iram.es/pub/preploader.tgz

Instructions:

tar xvzf preploader.tgz
cd preploader
make

provided your source tree is /usr/src/linux. You will get a zImage in
the preploader directory. This bootloader should reassign all I/O and
PCI memory space to something sane (provided you don't have any PCI<->PCI
bridges, not yet supported). However some S3 chips for example are buggy:
they claim they need 8Mb but actually need 64Mb. The bootloader includes
a black list to correct for this (one entry only up to now). 

	Gabriel.

P.S.: the output of lspci on your machine would be useful to help with
these problems. I'm also surprised that you only have 16Mb of MMIO
forwarded to PCI.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
