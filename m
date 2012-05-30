Return-Path: <steffen.rumler.ext@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
 [93.183.12.32])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "demumfd001.nsn-inter.net",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E376B7063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 00:33:46 +1000 (EST)
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
 by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
 q4UEXeDQ007324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 16:33:41 +0200
Received: from mango.dwdm.mu.nsn-intra.net ([10.148.33.2])
 by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id
 q4UEXe5C000659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 16:33:40 +0200
Message-ID: <4FC62FB9.8010701@nsn.com>
Date: Wed, 30 May 2012 16:33:29 +0200
From: Steffen Rumler <steffen.rumler.ext@nsn.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: kernel panic during kernel module load (powerpc specific part)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We have seen the following kernel panic, happened during loading a kernel module:

     [  536.107430] Unable to handle kernel paging request for data at address 0xd76a907c
     [  536.114922] Faulting instruction address: 0xc0000770
     [  536.119891] Oops: Kernel access of bad area, sig: 11 [#1]
     [  536.125291] CCEP MPC8541E
     [  536.127908] Modules linked in: pppoe(+) nf_conntrack_ipv6 ...
     [  536.155705] NIP: c0000770 LR: c0000770 CTR: d76ab0d4
     [  536.160674] REGS: d76a8f24 TRAP: 0300   Not tainted  (2.6.33-ccep)
     [  536.166857] MSR: 00021000 <ME,CE>  CR: 24000482  XER: 20000000
     [  536.172718] DEAR: d76a907c, ESR: 00800000
     [  536.176728] TASK = cbd7f9f0[972] 'insmod' THREAD: cbeb2000
     [  536.182041] GPR00: 83cbfff8 d76a8fd4 cbd7f9f0 00000000 83cbfff8 00000000 cbeb3e1e 00000000
     [  536.190438] GPR08: 0000327b d76aa000 24000482 d76a8fd4 cbd7fc08 10019b04 100c2e5c 00000000
     [  536.198836] GPR16: 00000000 1009bafc 100c44a4 100c2ed4 100c0000 100d1e60 100d1ca8 100017ab
     [  536.207235] GPR24: 100017ae 10001936 c0343ae8 10012018 00000000 834bffe8 836bffec 838bfff0
     [  536.215819] NIP [c0000770] InstructionStorage+0xb0/0xc0
     [  536.221048] LR [c0000770] InstructionStorage+0xb0/0xc0
     [  536.226188] Call Trace:
     [  536.228630] Instruction dump:
     [  536.231600] 90eb002c 910b0030 7cbe0aa6 90ab00b8 7d846378 38a00000 39400401 914b00b0
     [  536.239386] 3d400002 614a1002 512a0420 4800d6f5 <c000e43c> c000e65c 60000000 60000000
     [  536.247348] Kernel panic - not syncing: Fatal exception in interrupt
     [  536.253704] Call Trace:
     [  536.256149] Rebooting in 10 seconds..

The system crashes inside the return of the init entry point of the kernel module.

I've found the following root cause:

     (1) The system has a high number of NAT rules configured, which created a bigger vmalloc area.
           I've checked this by looking at /proc/vmallocinfo.

     (2) The kernel module ELF file contains the separate section .init.text for the init entry point,
           which is marked with __init, as usual.

     (3) The kernel module ELF file contains the function prologue and epilogue in the .text section.

     (4) The epilogue is also called from the init entry point, in order to return to the caller.
           It is intended to restore the non-volatile registers from the stack and to jump to the caller.

     (5) Because of (1), it is not more possible to jump by a relative branch instruction. The distance is too big.
           Instead, the trampoline method is applied, which allows longer jumps via register.
           (please see see do_plt_call() in arch/powerpc/kernel/module_32.c)

     (6) Unfortunately, the trampoline code (do_plt_call()) is using register r11 to setup the jump.
           It looks like the prologue and epilogue are using also the register r11, in order to point to the previous stack frame.
           This is a conflict !!! The trampoline code is damaging the content of r11.

According to the current EABI definitions, the register r11 has got a dedicated function (pointer to previous stack frame).
In the following, there are parts of the prologue/epilogue shown, which are generated by the compiler:

    ...
    00000084 <_rest32gpr_28>:
          84:       83 8b ff f0     lwz     r28,-16(r11)
    00000088 <_rest32gpr_29>:
          88:       83 ab ff f4     lwz     r29,-12(r11)
    0000008c <_rest32gpr_30>:
          8c:       83 cb ff f8     lwz     r30,-8(r11)
    00000090 <_rest32gpr_31>:
          90:       83 eb ff fc     lwz     r31,-4(r11)
          94:       4e 80 00 20     blr
    00000098 <_rest32gpr_14_x>:
          98:       81 cb ff b8     lwz     r14,-72(r11)
    ...


I'd suggest to use register r12 instead of r11 in the trampoline generation code, in do_plt_call() (arch/powerpc/kernel/module_32.c).
I'm using kernel 2.6.33, but I think it is also relevant for the current kernel release.

Below, there is the complete debug sessions, showing more the details.

Thanks
Steffen Rumler

--

     0xd54990c0:     addi    r11,r1,48
     0xd54990c4:     mr      r3,r29
     0xd54990c8:     b       0xd5499100 <-- going to return from the init entry point

     (gdb) bt
     #0  0xd5499100 in ?? ()
     #1  0xd54990ac in ?? ()
     #2  0xc0001db0 in do_one_initcall (fn=0, wait=1131130) at init/main.c:719
     #3  0xc0059e50 in sys_init_module (umod=<value optimized out>, ...
     #4  0xc000e038 in syscall_dotrace_cont () at arch/powerpc/kernel/entry_32.S:331
     Backtrace stopped: frame did not save the PC
     (gdb) info reg r1
     r1             0xcbbdbed0    3418210000
     (gdb) x/2x 0xcbbdbed0
     0xcbbdbed0:    0xcbbdbf00    0xd54990ac
     (gdb) x/2x 0xcbbdbf00
     0xcbbdbf00:    0xcbbdbf20    0xc0001db0
     (gdb) info reg r11
     r11            0xcbbdbf00    3418210048

         --> the stack is OK here
         --> r11 is OK, pointing to the previous stack frame

     0xd5499100:     lis        r11,-10381 <-- this is the trampoline code using/changing r11 (do_plt_call()).
     0xd5499104:     addi    r11,r11,-3888
     0xd5499108:     mtctr  r11

     (gdb) info reg r11
     r11            0xd772f0d0    3614634192
<-- r11 is now damaged !!!

     0xd549910c:     bctr

     0xd772f0d0:     lwz     r28,-16(r11) <-- the epilogue, using damaged r11 as stack pointer
     0xd772f0d4:     lwz     r29,-12(r11)
     0xd772f0d8:     lwz     r30,-8(r11)
     0xd772f0dc:     lwz     r0,4(r11)
     0xd772f0e0:     lwz     r31,-4(r11)
     0xd772f0e4:     mtlr    r0
     0xd772f0e8:     mr      r1,r11

     (gdb) info reg lr
     lr             0x83abfff4    0x83abfff4
         0xd772f0ec:     blr
     (gdb) stepi
     Program received signal SIGSTOP, Stopped (signal).

        ---> the kernel panic !!!
