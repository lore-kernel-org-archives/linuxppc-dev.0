Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001301c10a89$5f588a80$1701a8c0@paulplanet>
From: "Paul Chu (Accusys)" <paulchu@accusys.com.tw>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU & cache questions on 8240 (kernel 2.4.6)
Date: Thu, 12 Jul 2001 12:16:02 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

    Thank you for reading my questions.
    I'm porting kernel 2.4.6 to my custom 8240 board without
open firmware or any BIOS like that. I have questions at "head.S"
in the /arch/ppc/kernel directory. I cannot go back to running
unmapped after "MMU_init" and before "load_up_mmu". The
program is as follwos:
        DEBUG_OUT(0xAA)
        lis     r4,2f@h
        ori     r4,r4,2f@l
        tophys(r4,r4)
        li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
        FIX_SRR1(r3,r5)
        mtspr   SRR0,r4
        mtspr   SRR1,r3
        SYNC
        RFI
    2: DEBUG_OUT(0xBB)
This piece of code is from kernel and not modified at all; I'm
sure that the address caculation of "2" is correct. But I just
cannot get 0xBB at my debug port. And, when I disable
cache-enabling code, then this code can run to DEBUG_OUT(0xBB).
My cache-enabling code looks like this:
        mfspr   r3,HID0                 // enable i cache
        li      r4,0
        ori     r4,r4,(HID0_ICE|HID0_ICFI)
        or      r3,r3,r4
        mtspr   HID0,r3
        andc    r3,r3,r4
        ori     r3,r3,HID0_ICE
        mtspr   HID0,r3
        sync
        isync
        mfspr   r3,HID0                 // enable d cache
        ori     r3,r3,(HID0_DCE|HID0_DCI)
        rlwinm  r4,r3,0,22,20
        sync
        mtspr   HID0,r3
        mtspr   HID0,r4
        sync
        isync
Any advices are welcome, thank you !!
Paul Chu
Email: paulchu@accusys.com.tw


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
