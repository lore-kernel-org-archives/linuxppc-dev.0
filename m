Date: Fri, 5 Jan 2001 21:06:28 +0100
From: Michael Holzt <kju@fqdn.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Bugs in 2.4.0-ac2 in ppc
Message-ID: <20010105210627.D1095@fqdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While trying to compile LinuxPPC 2.4.0-ac2 for an embedded PPC i found
three problems:

 - function set_pgdir disappeared somewhere late in the 2.4.0test
   series. I had to copy the source from an older kernel to get the
   kernel to compile.


 - In ac2 the following source in asm-ppc/mmu_context.h is removed:

   #ifdef CONFIG_8xx
   extern inline void mmu_context_overflow(void)
   {
       atomic_set(&next_mmu_context, -1);
   }
   #endif

   When compiling on for a 8xx this leads to errors due to nonexisting
   function mmu_context_overflow.


 - And third the worst problem: Since one of the latest test series
   kernels i'm unable to use modules:

   For all modules i try i get unresolved symbols - for trivial functions:

   bash-2.03# insmod ./loop.o
   ./loop.o: unresolved symbol memset
   ./loop.o: unresolved symbol int_control_R58a1efa3
   ./loop.o: unresolved symbol __copy_tofrom_user_Re410a3dd
   ./loop.o: unresolved symbol memcpy
   ./loop.o: unresolved symbol strncpy_R328a05f1


As i'm no kernel-developer, i'm not subscribed to this list. So if
replying, please make a courtesy-copy to me privately. I really would like
to see these problems fixed. Thanks.


--
Greetings
Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
