Message-ID: <3B71AE22.2050901@galileo.co.il>
Date: Thu, 09 Aug 2001 00:24:50 +0300
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: "Karaaslan, Utku" <UKaraasl@drs.ca>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: A Question on Physical Memory Access from Applications
References: <47EE8DCFB8C6D311A23700508B8BAD5903DAF7@THEBRAIN2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We had such a problem few months ago ; what we've done is allocating
contigious physical memory using kmalloc in kernel space.
 From the pointer that you get from kmalloc remove the 4 MSB bits
(usually 0xc) and pass it (some how) to the user space application.
The user space application map the address that was passed from the
kernel, and it will get another virtual contigious memory space.

Now the memory area that you have in user space is contigious AND the
physical memory that the page tables points to is contigious (because it
was allocated in kernel space using kmalloc), therfore it is enough that
your ADA applications just refer to the allocated memory using a pointer
to the virtual memory.

Regards,
Rabeeh


Karaaslan, Utku wrote:

>I have ported the Linux bootloader/kernel to our home-made boards
>(Motorola 860) and they have been running well up to now. However,
>I have a problem: we've got a number of ADA applications which are
>using direct memory access to certain hardware registers. Under
>VxWorks, this is not a problem as it lacks kernelspace/userspace
>separation. Under Linux, I know I can do direct memory access (through
>/dev/mem), but in this case I want to use the applications as they are,
>with no change to the ADA code. Is there any way to do physical memory
>access transparently wrt the application? Many thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
