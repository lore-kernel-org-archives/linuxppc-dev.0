Message-Id: <v04003a00b6040db49ddd@[24.70.162.14]>
In-Reply-To: <200010050557.HAA00748@piglet.grunz.lu>
References: <v04003a04b60151e18975@[24.70.162.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 6 Oct 2000 18:30:11 -0500
To: mlan@cpu.lu
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: 2.4 madness!
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:57 AM -0500 10/5/2000, Michel Lanners wrote:
[...]
>> I first tried compiling a 2.2.17 kernel with the latest ide patch, which
>> resulted in a machine check on startup. bummer.
>
>That could have been PCI problems....
>
>Anyway, I'd suggest starting with:
>
>1. Andre Hedrick's ATA patches (but I suppose you knew that), available
>   somewhere on kernel.org, users/hedrick. AFAIK, the 2.2 patches
>   _don't_ contain support for the U/100, though...
>
>2. Get my PCI patches, available here:
>
>   http://www.cpu.lu/~mlan/linux/dev/pci.html
>
>...and cross fingers ;-)

Ok, done that. When I compile it here with gcc 2.97 20001003, it blows up
very early. When I compile it on the pmac itself with gcc 2.95.2 20000220
(debian), it blows up (I quote my friend) like so:

>Got past the first screen and Tux is in the corner now...
>
>Except, it goes...
>Macintosh ADB mouse driver intalled...
>Macintosh non-volatile memory driver v1.0
>Unable to handle kernel NULL pointer dereference at virtual address
>00000530 (error 40000000)
>NIP: C0130784 XER: 2000000 LR: C013072C REGS: c03d3d60 TRAP: 0300
>MSR: 00009032 [EEIRDRME]
>TASK = c03d2000[1] 'swapper' mm->pgd c0194000 Last syscall: 1200
>
>And soforth.. :-)

I had him remove the nvram driver, and it does the same. From a look at the
system map (which I neglected to examine before telling him to remove the
nvram driver), it's dying in ad1848_detect. I'm not sure why he wants that
driver compiled in, but he says he needs it. whatever.

I think I'll go grab the 2.95.2 source and compile myself another cross
compiler [insert picture of me projectile-vomiting on the gcc source], then
switch back to 2.4 again.

Hrm...


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
