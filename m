From: Arun Dharankar <ADharankar@comcast.net>
Reply-To: ADharankar@comcast.net
To: linuxppc-embedded@lists.linuxppc.org,
	"Christian Meyer" <Christian.Meyer@cs.tum.edu>
Subject: MPC7410 doesn't work with linux-2.4.20-denx 
Date: Wed, 1 Oct 2003 09:50:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200310010950.08570.ADharankar@Comcast.Net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


One problem I faced when using 2.4.18, 2.4.19 and
2.4.20 with 7410/8260 with 8260 core disabled can be
described as follows. I have not checked the 2.4.20-denx
code base, and  better solution for this problem may
be there - that is if this is indeed the same problem
you are facing.


The tlbie instruction whenexecuted on 7410 sends out
a transaction on the bus with type (0x18 if I remember
it correctly). There is no response to this if the address
which goes out with this transaction type does not
fall into any device's chip selects.

So, when Linux is booting up, at some point it sends
out TT 0x18 for the virtual addresses it wants to clear
the TLB entries for. Since there is no response, the
8260 has a bus timeout (if I remember correctly), and
the board is reset.


The solution that works for me is to change the places
where tlbie is called such that the address passed on
to the tlbie instruction has all bits cleared except those
in bits 14 through 23. I dont remember this for sure - you
can see the 7410 manual section where tblie is
described - the bit range is described (although it does
not mention this explicitly).

One of the places:
- in misc.S where _tlbie macro is defined, add the following
  before the isync.
    lis    r0, 0x3F000@h
    ori    r0, r0, 0x3F000@l
    and    r3, r3, r0

- in hashtable.S before the tlbie instruction add the following:
    lis    r6, 0x3F000@h
    ori    r6, r6, 0x3F000@l
    and    r4, r4, r6

- ppc_asm.h, change the code to not use KERN_BASE,
  instead use "0".


Just make sure that with the code base you are using you
do not clobber the registers I have chosen i the misc.S and
hashtable.S.


These changes work ok with the same kernel binary if I
were to use it with 750/755 instead of 7410. Also, it works
if I were to use it with only 8250, 8260 and 8270.


Hope this helps.
Best regards,
-Arun.


-------------------------------------------------------------------------------------------------------------
in message <200308141128.h7EBSnQ06089@mailgate5.cinetic.de> you wrote:
Date: Thu, 14 Aug 2003 13:28:50 +0200

 Hello!

 I'm currently trying to get linux running on an embedded board:
 * MPC7410 Rev.1.4
 * PowerQUICC (MPC 8260)
 * RAM: 128 MB
 * Flash: 64 MB
 * Kernel: 2.4.20-denx

 For some reason, it doesn't boot properly. It says "Now booting Linux",
 after that something triggers a hard reset. For the last 2 weeks I tried
 to debug (using the hardware debugger BDI2000) the kernel and more or
 less found out where the problem might be located.

 start_here() (arch/ppc/kernel/head.S) calls call_setup_cpu()
 (arch/ppc/kernel/misc.S), machine_init() (arch/ppc/kernel/setup.c),
 MMU_init() (arch/ppc/mm/init.c) and load_up_mmu()
 (arch/ppc/kernel/head.S). call_setup_cpu() and machine_init() seem to
 be fine; MMU_init() calls MMU_init_hw() and mapin_ram(). As far as I
 can tell, that's the point where the board initiates a hard reset. I
 don't know why it does that and I also don't know any solution to solve
 that problem. It seems like either the MMU isn't correctly initialized
 or there's a problem with the L2 cache. Motorola says, that the MPC7410
 is compatible to the MPC75x; regarding my current problem it looks like
 that there's a difference somewhere.

 Maybe you know a solution for the problem or have an idea how to find
 out what's wrong.

 Thanks in advance,
 --
 Christian Meyer

 Technische Universit� Mnchen
 E-Mail: Christian.Meyer@cs.tum.edu
 UIN: 72107443
 AIM: chrisime
 Jabber: chrisime@charente.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
