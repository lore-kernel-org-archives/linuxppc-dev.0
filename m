Date: Mon, 25 Oct 1999 18:25:26 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Still not booting
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910251825040.434-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi,

I am still not able to boot my 8xx board via NFS. Actually, I do not
think is it NFS related anymore. I put a lot of printk and was able
to narrow down to the clear_user function.

This is happening while trying to load /sbin/init. init/main.c calls
execve which eventually leads to load_elf_intepr to padzero to
clear_user and __clear_user. (There is other functions inbetween, I
just skipped them end the list here). __clear_user is an assembly
routine which clears a memory block. The arguments are the same as
clear_user, i.e. an address pointer and a length.

I do not get any more printk outputs after the processor enters
__clear_user. I modified clear_user to do the actual clearing of the
memory in C (easier to work with). Right now, I find that the first
access to the memory to clear it ends up in hanging the system. The
address is 3004ddcc which obviously seems to be a logical or virtual
address. If I am not wrong, /sbin/init is the first user land process,
so trying to start it is the first time the kernel is playing with
user land memory space. I do not think this is an hardware unmapped
physical location since I think the bus monitor would eventually kick
in and result into a machine check. Am I right?

Is there s way to easilly convert the virtual address to physical?

Any other idea on how to keep analysing the problem?

Thanks

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
