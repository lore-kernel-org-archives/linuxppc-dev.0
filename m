Message-ID: <3B54CA59.65830E98@comdev.cc>
Date: Tue, 17 Jul 2001 16:29:29 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: cal_erickson@mvista.com
Cc: Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu problems
References: <3B4F412F.99A14D9E@comdev.cc> <3B4F5BE9.6258498B@mvista.com> <3B530F09.E93C0B8D@comdev.cc> <3B531CC8.8212165C@comdev.cc> <3B532E16.A26A9BA9@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm still completely stuck.  Any help would be greatly appreciated.
Every crash in the last 2 days has been pretty much this:


Oops: Exception in kernel mode, sig: 4
NIP: C0005F80 XER: 00000000 LR: C000CF9C SP: C34B3BF0 REGS: c34b3b40
TRAP: 0700 MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c34b2000[20] 'ls' Last syscall: 3
last math c3472000 last altivec 00000000
GPR00: C001F714 C34B3BF0 C34B2000 C3400000 00000080 00000081 C33FF000
00000001
GPR08: 00000000 000000C9 C027B060 00000000 44444824 1004BE90 03FDE000
007FFF00
GPR16: 00000000 007FFF00 007FFEB0 C002343C 00009032 034B3D20 00000000
C0003DC4
GPR24: C000BE90 02000000 00030002 C34A6064 C34A6064 C35404A0 C3683320
C0247FE4
Call backtrace:
C35404A0 C001F714 C001F7F0 C001F99C C000C020 C0003DC4 C352FCC0
C0023080 C0023538 C0031FD4 C0003B5C 0FF31FD0 0FF307F0 0FF32040
0FF31EB4 0FF26DF0 0FF26C48 0FF2FDD0 0FE8E6D8 0FE8EB00 0FF6553C
0FF64EF4 10029794 10012B64 10012648 10012718 10012764 10012764
10012764 100133C8 10027B64 100277E0 0FEDC068

closest to c0005f80 :: c0005f50 T __flush_page_to_ram     (plus 48 of
76)
closest to c35404a0 :: NOT FOUND
closest to c001f714 :: c001f674 t do_anonymous_page     (plus 160 of
296)
closest to c001f7f0 :: c001f79c t do_no_page     (plus 84 of 396)
closest to c001f99c :: c001f928 T handle_mm_fault     (plus 116 of 300)
closest to c000c020 :: c000be90 T do_page_fault     (plus 400 of 904)
closest to c0003dc4 :: c0003dc4 T ret_from_except     (plus 0 of 40)
closest to c352fcc0 :: NOT FOUND
closest to c0023080 :: c0022e2c T do_generic_file_read     (plus 596 of
1552)
closest to c0023538 :: c00234d0 T generic_file_read     (plus 104 of
160)
closest to c0031fd4 :: c0031f0c T sys_read     (plus 200 of 276)
closest to c0003b5c :: c0003b5c T ret_from_syscall_1     (plus 0 of 180)

_GLOBAL(__flush_page_to_ram)
        mfspr   r5,PVR
        rlwinm  r5,r5,16,16,31
        cmpi    0,r5,1
        beqlr                           /* for 601, do nothing */
        rlwinm  r3,r3,0,0,19            /* Get page base address */
        li      r4,4096/CACHE_LINE_SIZE /* Number of lines in a page */
        mtctr   r4
        mr      r6,r3
0:      dcbst   0,r3                    /* Write line to ram */
        addi    r3,r3,CACHE_LINE_SIZE
        bdnz    0b
        sync
        mtctr   r4              /* !!!! this is __flush_page_to_ram +48
!!!! */
1:      icbi    0,r6
        addi    r6,r6,CACHE_LINE_SIZE
        bdnz    1b
        sync
        isync
        blr

--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
