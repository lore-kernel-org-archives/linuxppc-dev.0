From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Porting LinuxPPC
To: Graham Stoney <greyham@research.canon.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00May19.180925est.115223@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20000519051051.236093C972@elph.research.canon.com.au>
Date: Fri, 19 May 2000 18:09:22 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Graham,

Graham Stoney wrote:

>
> To quote Grant Erickson in
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00123.html:
>
> "You don't ever want to change KERNELLOAD or KERNELBASE, otherwise the
> virtual memory and MMU code will all break."
>
> This seems to be a common error, so I might add mention of it in the HOWTO.
>

Yes, I saw the article after sending the question. But this doesn't really help me
:-( I've put back the KERNELLOAD and KERNELBASE address back to their orginal
values and load the zImage (in the .../arch/ppc/mbxboot directory) rather than the
vmlinux file using the BDM debugger but it still crashes very early in the piece.

To be precise, while clearing the BSS.

/* Clear all of BSS */
        lis     r3,edata@h
        ori     r3,r3,edata@l
        lis     r4,end@h
        ori     r4,r4,end@l
        subi    r3,r3,4
        subi    r4,r4,4
        li      r0,0
50:     stwu    r0,4(r3) <---- crashes here
        cmp     0,r3,r4
        bne     50b

The strange thing is that it seems to work if I step through the loop. In any
case, it crashes soon after that in serial_init.

I think I'm missing something fundamental here ... any suggestions.

Regards,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
