Message-ID: <002401bff564$5c70e320$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10007211055230.28261-100000@gra-ux1.iram.es>
Subject: Re: How to use ppcbug to debug my program with mmu?
Date: Mon, 24 Jul 2000 19:43:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo <gongzhuo@163.net>
Cc: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, July 21, 2000 5:17 PM
Subject: Re: How to use ppcbug to debug my program with mmu?


>
> On Fri, 21 Jul 2000, Gong Zhuo wrote:
>
> >
> > Hi:
> >    I am using MVME2600 SBC and I want to debug my program under PPCbug.
> > According the PPCbug Firmware Package User's Manual chapter 2, a program
> > with mmu enable should be debugged using PPCbug if some rules are
obeyed.
> >    Those address ranges
> >          0x0 -- 0x0fffffff,
> >          0x10000000 -- 0x1fffffff ,
>
> One BAT would be enough for this...
>
> >          0xe0000000 -- 0xefffffff,
> >          0xf0000000 -- 0xffffffff
> >    have been mapped from physical address to logical address 1 to 1
using
> > BAT mothed .  Exception vectors 0x100 , 0x700, 0xc00, 0x2000 and spr272,
> > spr273, spr274, spr275 are not being used.
> >    I write the code like this under ppcbug at address 0x40000:
> >           1.     initial all the BAT register
> >           2.     isync
> >           3.     msr | 0x30  ==> msr    # open the mmu
>
> Wrong order, isync should be performed after changing the msr, mtmsr is
> execution synchronizing but not context synchronizing.
>
> >           4.     do sth. else
> >     But it always not come back to PPC1-bug> status after I use command
> > 'T'to singlestep run step 3.
> >     I also used the mothed like this :
> >           1.     initial all the BAT register
> >           2.     isync
> not necessary (you are still in real mode)
>
> >           3.     msr | 0x30  ==> srr1    # open the mmu
> >           4.     logical address of 6. => srr0
> >           5.     rfi
> >           6.     do sth. else
> >     The same error happened when singlestep 5.
> >
> >    Can this code be debugged under ppcbug? If can , how?
>
> No, don't believe Motorola's docs about this. I tried it and PPCBUG does
> not work with MMU enabled, even if the only thing you do is 1:1 mapping as
> required in the docs (actually it seems PPCBUG will set the MSR IP bit to
> 1 and then the interrupt handlers you have installed will never be used).
>
> Been there, done that when debugging prepboot, once you've enabled the MMU
> you are on your own. I was using standard paging, you are using BATs but
> there are not enough BATs for everybody: PPCBUG would need
> - a BAT for RAM (2 if you have more than 256Mb since PPCBUG data is at
> top of memory)
> - a BAT for code and data in the ROM
> - a BAT for I/O at 0x80000000
> - a BAT for MMIO at 0xc0000000 in some cases (depending on what PPCBUG
> functions you call and whether you have a VGA console)...
> - perhaps one BAT for the Raven/Falcon bridge (can't remember) it can be
> shared (data only but caching disabled) with the ROM BAT.
>
> Note that there is not much point in enabling the MMU until you enable the
> data cache. In your case, you might get it to work with the I/O BAT at
> 0x80000000 but it basically can only be used as a temporary workaround for
> debugging.
>
Hi:
   I have used your mothed and it works very well . Thank you very much.
Now, I want to use standard paging, but I don't know the really size of each
memory area of PPCbug I shoud map. (0x80000000 --? , 0xc0000000--?,
0xF0000000--?), would you please tell me where can I find the description of
each area?

Regards
Gong Zhuo.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
