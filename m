Message-ID: <40DC0B11.5000302@ru.mvista.com>
Date: Fri, 25 Jun 2004 15:22:57 +0400
From: Yuri Frolov <yfrolov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Unsuccessfull system call interseption. Please, help to correct it
 or make a suggestion.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Platform: IBM Spruce 750CX.
The problem: due to the necessity of logging system calls entry/exit
events by LTT the arch/ppc/kernel/entry.S was modified in this way:

/* LTT stuff */
#if (CONFIG_LTT)

#define TRACE_REAL_ASM_SYSCALL_ENTRY    \
        addi    r3,r1,STACK_FRAME_OVERHEAD;     /* Put pointer to
registers into r3 */  \
        mflr    r29;                            /* Save LR */ \
        bl      trace_real_syscall_entry;       /* Call real trace
function */ \
        mtlr    r29;                            /* Restore LR */ \
        lwz     r0,GPR0(r1);                    /* Restore original
registers */ \
        lwz     r3,GPR3(r1);    \
        lwz     r4,GPR4(r1);    \
        lwz     r5,GPR5(r1);    \
        lwz     r6,GPR6(r1);    \
        lwz     r7,GPR7(r1);    \
        lwz     r8,GPR8(r1);

#define TRACE_REAL_ASM_SYSCALL_EXIT \
        bl      trace_real_syscall_exit;        /* Call real trace
function */ \
        lwz     r0,GPR0(r1);                    /* Restore original
registers */ \
        lwz     r3,RESULT(r1); \
        lwz     r4,GPR4(r1); \
        lwz     r5,GPR5(r1); \
        lwz     r6,GPR6(r1); \
        lwz     r7,GPR7(r1); \
        lwz     r8,GPR8(r1); \
        addi    r9,r1,STACK_FRAME_OVERHEAD;

#endif /* CONFIG_LTT */

And then:

_GLOBAL(DoSyscall)
        stw     r0,THREAD+LAST_SYSCALL(r2)
        stw     r3,ORIG_GPR3(r1)
        li      r12,0
        stw     r12,RESULT(r1)
        lwz     r11,_CCR(r1)    /* Clear SO bit in CR */
        rlwinm  r11,r11,0,4,2
        stw     r11,_CCR(r1)
#ifdef SHOW_SYSCALLS
        bl      do_show_syscall
#endif /* SHOW_SYSCALLS */
        rlwinm  r10,r1,0,0,18   /* current_thread_info() */
        lwz     r11,TI_LOCAL_FLAGS(r10)
        rlwinm  r11,r11,0,~_TIFL_FORCE_NOERROR
        stw     r11,TI_LOCAL_FLAGS(r10)
        lwz     r11,TI_FLAGS(r10)
        andi.   r11,r11,_TIF_SYSCALL_TRACE
        bne-    syscall_dotrace
syscall_dotrace_cont:
        cmpli   0,r0,NR_syscalls
        lis     r10,sys_call_table@h
        ori     r10,r10,sys_call_table@l
        slwi    r0,r0,2
        bge-    66f
        lwzx    r10,r10,r0      /* Fetch system call handler [ptr] */
        mtlr    r10
#if (CONFIG_LTT)
        TRACE_REAL_ASM_SYSCALL_ENTRY ;
#endif
        addi    r9,r1,STACK_FRAME_OVERHEAD
        blrl                    /* Call handler */
        .globl  ret_from_syscall
ret_from_syscall:
#ifdef SHOW_SYSCALLS
        bl      do_show_syscall_exit
#endif
#if (CONFIG_LTT)
        stw     r3,RESULT(r1)   /* Save result */
        TRACE_REAL_ASM_SYSCALL_EXIT ;
#endif
        mr      r6,r3
        li      r11,-_LAST_ERRNO
        cmpl    0,r3,r11
        rlwinm  r12,r1,0,0,18   /* current_thread_info() */
        blt+    30f
        lwz     r11,TI_LOCAL_FLAGS(r12)
        andi.   r11,r11,_TIFL_FORCE_NOERROR
        bne     30f

And so on.

This state of affairs produces the next fault sequence (obtained with
BDI2000 help):
(gdb) bt
#0  0xc000814c in __delay ()
#1  0xc0015ac4 in panic (fmt=0x121eac0 <Address 0x121eac0 out of bounds>)
    at delay.h:42
#2  0xc00182b0 in do_exit (code=11) at kernel/exit.c:768
#3  0xc000625c in die (str=0x1 <Address 0x1 out of bounds>, fp=0xc02add20,
        err=11) at arch/ppc/kernel/traps.c:106
#4  0xc000e51c in bad_page_fault (regs=0xc02add20, address=1, sig=11)
    at arch/ppc/mm/fault.c:363
#5  0xc000e4c0 in do_page_fault (regs=0xc02add20, address=2449539152,
               error_code=1107296256) at arch/ppc/mm/fault.c:337
#6  0xc0005f80 in ret_from_except_full () at init/initramfs.c:12
#7  0xc01c8ce0 in init_thread_union ()
#8  0xc0025e94 in queue_work (wq=0x1, work=0x1) at kernel/workqueue.c:105
#9  0xc0026698 in schedule_work (work=0x1) at kernel/workqueue.c:389
#10 0xc002a1d4 in kthread_create (threadfn=0x593ad, data=0x1,
                    namefmt=0xc017388c "%s/%d") at kernel/kthread.c:134
#11 0xc002640c in create_workqueue_thread (wq=0x1, cpu=10)
                       at kernel/workqueue.c:293
#12 0xc0026528 in __create_workqueue (name=0xc017fe74 "kblockd",
                            singlethread=0) at kernel/workqueue.c:329
#13 0xc01d8d6c in blk_dev_init () at drivers/block/ll_rw_blk.c:2822
#14 0xc01d8e28 in device_init () at drivers/block/genhd.c:311
#15 0xc01ca664 in do_initcalls () at init/main.c:519
#16 0xc01ca700 in do_basic_setup () at init/main.c:559
#17 0xc000392c in init (unused=0x593ad) at init/main.c:599
#18 0xc0008994 in original_kernel_thread ()

The investigation has shown that the reason for fault is the
addi    r3,r1,STACK_FRAME_OVERHEAD;     /* Put pointer to registers into
r3 */  \
instruction whitch follows direcly after the macro:
#define TRACE_REAL_ASM_SYSCALL_ENTRY

Definitly I can't just get rid of it (trace_real_syscall_entry really
needs a parameter) and my poor knowledge of ppc assembly prevents me
from thorough understanding of DoSyscall. If you have a clue, or think
you may know what problem is, please let me know ASAP.

Thanks in advance
Yuri Frolov


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
