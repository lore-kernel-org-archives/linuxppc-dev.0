Date: Tue, 15 Dec 1998 15:44:52 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Loic Prylli <Loic.Prylli@ens-lyon.fr>
cc: linuxppc-dev@lists.linuxppc.org,
        "Eugene V. Ananishnov" <eugene-a@fort.tatarstan.ru>,
        VALETTE Eric <valette@crf.canon.fr>,
        Cort Dougan <cort@ladron.cs.nmt.edu>, minyard@acm.org,
        baccala@freesoft.org, Matt Porter <mmporter@home.com>,
        Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>,
        Peter De Schrijver <p2@medelec.uia.ac.be>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: preploader (re:Linux-2.1.129 boot on MCP750)
In-Reply-To: <13936.2484.315786.483720@porto>
Message-ID: <Pine.HPP.3.96.981215150140.19490C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




[Sorry for the other readers, part of this message is in French, but Loic
found the most serious problem in the new preploader. I have also added
all the people who have been interested in this at one time or another,
including the last discussion about MILO like things.]

On Thu, 10 Dec 1998, Loic Prylli wrote:

> 
> 
> Youpi, j'ai enfin reussi a utiliser preploader !! :-)

Great.

[snipped]

[Loic explaining how he found the bug, and the patch he used, which
unfortunately would not work on a 601]

> En fait ma question originale n'etait pas sur la MMU dans la partie
> principale de preploader, mais dans les dernieres instructions apres le
> decompress_kernel, et dans le code initial du noyau, la ou le plantage
> survient. Je me suis fait une fonction serial_putc qui:
>  - active la MMU si elle ne l'est pas avec un mapping de base
>  - rajoute une entree dans les BAT si la MMU est activee mais la
>  zone PCI/IO non configuree
> 
> Cela m'a permis de localiser le probleme en faisant  des sorties
> series a intervalles reguliers: il y avait un plantage dans le memcpy
> qui recopie le residual dans arch/ppc/kernel/setup.c, ceci parce que le
> residual etait a la fin des 64Mo de memoire alors que dans sa premier
> phase de bootstrap le noyau ne mappe que les premiers 4Mo, le probleme 
> est resolu en changeant arch/ppc/kernel/head.S pour mapper
> initialement le maximum,  c'est a dire 256 Mo de memoire:
> 
> RCS file: /cvsroot/linux/arch/ppc/kernel/head.S,v
> retrieving revision 1.112
> diff -u -r1.112 head.S
> --- head.S      1998/11/15 19:49:18     1.112
> +++ head.S      1998/12/10 17:36:01
> @@ -237,7 +258,7 @@
>         b       5f
>  4:
>  #ifndef CONFIG_APUS
> -       ori     r11,r11,0x1fe           /* set up BAT registers for 604 */
> +       ori     r11,r11,0x1ffe          /* set up BAT registers for 604 */
>         li      r8,2                    /* R/W access */
>  #else
>         ori     r11,r11,0xfe            /* set up an 8MB mapping */
> 
> 
> Le probleme ne se posait pas avec le boot par defaut parce que celui
> recopiait le residual au debut de la memoire avant de lancer le noyau.

Indeed, I did not experience any problem because I do all my developments
on a poor 16Mb machine. You'll find a new version of the preploader at the
usual site: 

	ftp://vcorr1.iram.es/pub/preploader.tgz

ands the corresponding 2.1.130 zImage with builtin de4x5 and ncr53c8xx
drivers (ext2 and nfs filesystems but no root on NFS). This kernel also
includes support for OpenPIC on Raven machines.

I would like to have as many reports as possible, both from failures and
successes. 

There is also a problem which bothers me because I simply can't understand
how some people do not get a boot prompt for kernel parameters. I have
never encountered this problem and absolutely need to track it down.

What is preploader (and how does it compare to MILO):

- it is an attempt at a clean linux loader for Linux/PPC on PreP machines
(might be extended to other machines too).

- it configures PCI resources in a saner way than most firmware (I/O and
memory mapped regions), I needed this to work around bugs in some S3
boards (there is a blakclist with one entry now, but it could and should
be extended).  However it does not yet support PCI<->PCI bridges, I would
need the help of somebody with a such a beast with some actual devices
plugged-in (any MCP750 with additional CompactPCI boards for example). 

- it includes an x86 emulator which allows me to properly initialize my S3
board.

- if no graphics adapter is detected or the keyboard is disconnected, it
automatically falls back to serial console (at least it should). 

What's new in this version:

- problems with memory > 16Mb should be solved

- the makefile has been improved and should work right out of the box

- by default the -DEBUG flag is set in the makefile and it will spit out
a lot of info about PCI mappings and some relocation information. 

- it needs to shuffle much more data around to work with the weirdest
possible memory maps (it should correctly handle any combination of
residual data and load addresses), so don't be surprised if it takes a
full 10-20ms more to boot than the preceding version ;-) 

Future plans (if Cort agrees):

- if I have enough success reports, I plan to include it in an
arch/ppc/prepboot directory so that it can become part of the general
linux-kernel archives (at least at vger for now). For this step I will
need the help of some makefile gurus, I'm unfortunately completely
hermetic to makefile concepts and syntax, and experience has shown that it
takes me more time to debug a makefile of 50 lines than 5000 lines of PPC
assembly. 

  
How to use it:

- unpack preploader.tgz in any directory (it will create a preploader
subdirectory). Then 'cd preploader; make' should take your
/usr.src/linux/vmlinux file and pack it into a zImage suitable for
booting.  

- warning: you need binutils>=2.9.1.0.13

May I insist again that both *success* and *failure* reports are very
important. They should include all possible details on the HW, as well as
the console logs if the loader gets to the point of spitting out any
information.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
