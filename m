From: eejape@tpu.fi
To: Rabeeh Khoury <rabeeh@galileo.co.il>,
	linuxppc-embedded@lists.linuxppc.org
Message-ID: <6142463f.463f6142@tpu.fi>
Date: Thu, 09 Aug 2001 08:55:09 +0300
MIME-Version: 1.0
Subject: Re: A Question on Physical Memory Access from Applications
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

Could you make a "short" example of this?

Thanks

----- Alkuperäinen viesti -----
Lähettäjä: Rabeeh Khoury <rabeeh@galileo.co.il>
Päiväys: Torstai, Elokuu 9, 2001 0:24
Aihe: Re: A Question on Physical Memory Access from Applications

>
> Hi,
>
> We had such a problem few months ago ; what we've done is allocating
> contigious physical memory using kmalloc in kernel space.
> From the pointer that you get from kmalloc remove the 4 MSB bits
> (usually 0xc) and pass it (some how) to the user space application.
> The user space application map the address that was passed from the
> kernel, and it will get another virtual contigious memory space.
>
> Now the memory area that you have in user space is contigious AND the
> physical memory that the page tables points to is contigious
> (because it
> was allocated in kernel space using kmalloc), therfore it is
> enough that
> your ADA applications just refer to the allocated memory using a
> pointerto the virtual memory.
>
> Regards,
> Rabeeh
>
>
> Karaaslan, Utku wrote:
>
> >I have ported the Linux bootloader/kernel to our home-made boards
> >(Motorola 860) and they have been running well up to now. However,
> >I have a problem: we've got a number of ADA applications which are
> >using direct memory access to certain hardware registers. Under
> >VxWorks, this is not a problem as it lacks kernelspace/userspace
> >separation. Under Linux, I know I can do direct memory access
> (through>/dev/mem), but in this case I want to use the
> applications as they are,
> >with no change to the ADA code. Is there any way to do physical
> memory>access transparently wrt the application? Many thanks in
> advance.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
