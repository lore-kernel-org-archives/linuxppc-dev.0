Message-ID: <3F54B7C2.9060409@2net.co.uk>
Date: Tue, 02 Sep 2003 16:31:14 +0100
From: Chris Simmonds <chris@2net.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: IRQ0 handler
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Can anybody tell me how to install a handler for irq0 on an 8xx
platform? Doing the obvious (request_8xxirq (SIU_IRQ0 ...)) doesn't seem
to work. It seems that I need to modify head_8xx.S so that the excption
handler for 0x100 is do_IRQ instead of UnKnownException. I tried the
patch below, but now I get a Software Emulation trap (0x1000). Any help
gratefully accepted.

Chris.

/* System reset */
#ifdef CONFIG_SMP /* MVME/MTX start the secondary here */
    STD_EXCEPTION(0x100, Reset, __secondary_start_psurge)
#else
/****
    Replace norrmal NMI handler with do_IRQ

    STD_EXCEPTION(0x100, Reset, UnknownException)
****/
NMI_Interrupt:
    EXCEPTION_PROLOG;
    addi    r3,r1,STACK_FRAME_OVERHEAD
    li    r20,MSR_KERNEL
    li    r4,0
    bl    transfer_to_handler
    .long    do_IRQ;
    .long    ret_from_intercept

#endif

--
Chris Simmonds                        2net Limited
chris@2net.co.uk                      http://www.2net.co.uk/
Tel:   +44 (0)1962 869003             Fax:   +44 (0)870 056 7556
"If it's not connected, it's not effective"(tm)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
