From: Andrew_Klosterman@3com.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <882567C2.008325F6.00@hqoutbound.ops.3com.com>
Date: Tue, 3 Aug 1999 16:52:47 -0700
Subject: PPC kernel bootstrapping and relocation
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





I have inherited a board (developed in-house) and been tasked with porting Linux
to it.  I have started from the 2.2.10 kernel and have been able to get the boot
process working up to the branch to identify_machine in /arch/ppc/kernel/head.S.
Coming to this point, I still have some nagging questions that I hope someone
with more experience porting operating systems (Linux) to PPC hardware can help
me with.

1. What is the rationale behind the address at which the kernel should be
compiled?  There is the KERNELLOAD value defined in /arch/ppc/Makefile that is
set to 0xc000_0000 as well as a value in /include/asm-ppc/page.h that defines
PAGE_OFFSET and KERNELBASE to 0xc000_0000.  KERNELLOAD is used as the text
linkage address for the kernel, but the kernel gets relocated during the boot
process.

2. Is the kernel supposed to run at 0 or at 0xc000_0000?  Sure it gets compiled
for 0xc000_0000, but then it gets copied down to zero by relocate_kernel in
/arch/ppc/kernel/head.S.

3. Do the BATs do the necessary translation of addresses while the kernel is
starting/running (wherever it end up executing at)?  I haven't quite sorted out
the way that memory ends up for the running kernel because I haven't yet managed
to get the kernel running yet.  :)

4. Ultimately, what is the view of memory that the BATs set up for the kernel?
(This leads in to point #5.)

5. How can I exclude the kernel from using certain memory regions?  I have some
special memory areas to worry about that other hardware on this board needs.
Therefore, I need to be able to exclude some memory ranges from use by the
kernel.  Any hints?

6. What sort of environment is the kernel expecting to be starting from?  What
are the default settings for the memory architecture (BATs) that is expected?  I
still have to deal with the peculiarities of this particular board, but I can
have my own boot code set things up to a more standard configuration before
passing jumping to the kernel start.

Thanks for whatever aid you can contribute to yet another Linux port!

--Andy Klosterman



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
