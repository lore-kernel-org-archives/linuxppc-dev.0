Message-ID: <3A50A051.1000907@galileo.co.il>
Date: Mon, 01 Jan 2001 17:20:49 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
Reply-To: rabeeh@galileo.co.il
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Page tables
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have been able to boot our embedded system (7400 PowerPC and Galileo
Technology system controller) and mounting NFS throught network.
Now the system is trying to run the first process - init.
It starts downloading part of init, then downloads part of ld.so.1 and
in the function padzero (in fs/binfmt_elf.c), where the user space is
first accessed at all (address 0x30026328 to be exact), the kernel tries
to zero the bss section.
Due to that an exception occurs due to not valid page, then the kernel
allocates succesfully new pte to the process (in function do_page_fault
in file arch/ppc/mm/fault.c) and it is supposed to go back to function
padzero to resume, but the weird thing is that it doesn't go back and
stays stuck some where that I couldn't find where.
One good thing is that the interrupt handling mechainsm is still working
and the kernel still responds to pings.


Did any one encounter such a problem ?
and how can I debug this problem ?
is there any functions that I can use to search the page tables ?

Any tip would help a lot !


Thank you,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
