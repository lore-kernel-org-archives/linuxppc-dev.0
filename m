Date: Mon, 13 Aug 2001 14:10:10 -0500 (CDT)
Message-Id: <200108131910.f7DJAAd09710@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: assorted kernel patches
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We are switching to Linuxppc to support our early
processor bringup in the lab.

There are a small set of patches that we think would be useful to
merge back into linuxppc_2_4_devel.  What is the procedure to discuss
these changes, get them reviewed, and merged (if so desired)?

Here is the list:

1. Support for hardware breakpoints for process threads.

   - Add iabr and dabr to the end of the pt_regs structure.
   - Save and restore IABR and DABR on exception/switch.
     Since the 603 family does not have DABR, should it
     be excluded via a CONFIG compile option or with the cputable?
     In either case, pt_regs should contain spots for both.
   - add IABR and DABR register numbers for ptrace
     There is a hole before the FP regs where they can go
     without disturbing and user applications.
   - Change InstructionBreakpoint and do_page_fault to not
     call XMON/KGDB if the trap is from user_mode.

2. Allow superviser (MSR[PR]=0) user threads.
   Currently MSR[PR] has a second purpose which indicates the thread
   was in kernel mode on exception.  A different bit needs to
   indicate this.  A good alternative is MSR[RI].

   - change user_mode() to reference MSR_RI instead of MSR_PR
   - change copy_thread to use the user_mode macro instead of MSR_PR

3. Additional 7450 support
   - Use recommended cache flush/initialization routines
   - add machine check decodes in traps.c

4. 7450 L3 cache control
   - Use recommended initialization routine
   - l3cr-value in device-tree (what uses l2cr-value today?)
   - l3cr=xxxx on commandline
   - /proc/sys/kernel/l3cr

5. Use L2 Hardware flush routines for 7400, 7410, and 7450
   - define DSSALL in ppc_asm.h

6. Add support 8245 cpu/bridge, and mpc107 bridge

7. stabs support for kernel asm functions

8. In ProgramCheckException, do not call dubugger_bpt if in user_mode

9. Additional thread state:

   - per thread MSR[FE0,1] bits - allows thread to control
   - per thread MSR[FP,VA] state -  to know if thread
     used FPU for Vector unit even if it was subsequently taken from it.

Ed Swarthout

Ed.Swarthout@Motorola.com
Austin, Tx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
