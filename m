Message-Id: <199908121730.TAA03489@piglet.cpu.lu>
Date: Thu, 12 Aug 1999 19:30:24 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
cc: Paul.Mackerras@cs.anu.edu.au, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9908101455510.32043-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Aug, this message from Geert Uytterhoeven echoed through cyberspace:
>> One way might be to adjust the base addresses in all the pci_dev
>> structs and then make sure all drivers use the address from the
>> pci_dev struct rather than reading config space themselves.
> 
> Which will make our /proc/ioports look funny.

[mlan@piglet ~]$ cat /proc/ioports
f2000480-f2000487 : ide2
f2000488-f200048f : ide3
f2000490-f20004bf : PDC20262

I don't see why this would be funny.... except if you're used to the
PeeCee definition of IO ports being below 64 k ;-))

In any case, I still find it much better to adjust pci_dev, than to
play with offsets in inb()/outb().

But most important, adjusting struct pci_dev is the only way I see to
support IO space on more than one host bridge.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
