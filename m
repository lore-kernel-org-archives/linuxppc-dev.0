Date: Wed, 23 Jun 1999 10:45:22 +1000
Message-Id: <199906230045.KAA02613@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: nsheeley@ibmoto.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199906221621.LAA28496@shippy.ibmoto.com> (message from Nathan
	Sheeley on Tue, 22 Jun 1999 11:21:02 -0500 (CDT))
Subject: Re: bug in head.S
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199906221621.LAA28496@shippy.ibmoto.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nathan Sheeley <nsheeley@ibmoto.com> wrote:

> I was poking around in arch/ppc/kernel/head.S and I noticed this:
> 
>   oris  r18,r8,0x20000000@h
>   oris  r21,r11,(KERNELBASE+0x20000000)@h
>   mtspr DBAT2L,r18    /* N.B. 6xx (not 601) have valid */
>   mtspr DBAT2U,r21    /* bit in upper BAT register */
>   mtspr IBAT2L,r28
>                ^^^^^^^^^^^^^^^^Wouldn't r18 make more sense here?

Yep, sure, thanks for pointing that out.

> Has anyone tried to build/run a pmac SMP kernel with a recent (2.2.9)
> version of Linux?  

I have 2.2.10 running on my 2-cpu powermac at home (it's a 7500 with a
2 x 604e 200MHz cpu card in it).  It mostly runs fine but has frozen
up on me a couple of times - I haven't tracked down why/where yet.

> Can I expect a SMP kernel to boot on a UP?  I thought so, although it might

I would have thought so, as long as it's not a 601.  The SMP kernel
uses the tlbsync instruction which isn't implemented on the 601.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
