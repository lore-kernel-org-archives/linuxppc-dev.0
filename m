Message-ID: <00c401c0fe17$1ffc3860$150101c0@teletron.co.kr>
From: =?ks_c_5601-1987?B?wPy5zrHU?= <apices@intizen.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux Booting again - MPC8260
Date: Tue, 26 Jun 2001 17:08:03 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi machael,
Thanks for your help.

I asked about Linux Booting of MPC8260 a few day ago.
The problem is following code.

start_here:
        ...
        bl identify_machine
        bl MMU_init
        lis r4,2f@h
        ori r4,r4,2f@l
        tophys(r4,r4)
        li r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
        FIX_SRR1(r3,r5)
        mtspr SRR0,r4
        mtspr SRR1,r3
        SYNC
        RFI              /* halt after the rfi instruction ? */

2:
   /* Here I add my debuging codes,
      GPIO - Port A4 output ON.
      but it outputs nothing. */

        sync
        tlbia
        sync

And I received answer.

>Check those codes(setbat) in MMU_init() to make sure it is same as your
>custom board:

>case _MACH_8260:
>    setbat(...);
>    setbat(...);
>    ioremap_base=...;
>break;

I tried following cases.

    setbat(0, 0xf0000000, 0xf0000000, 0x10000000, IO_PAGE);
    ioremap_base = 0xf0000000;

    setbat(0, 0xf0000000, 0xf0000000, 0x20000, IO_PAGE);
    ioremap_base = 0xf0000000;

    setbat(0, 0xf0000000, 0xf0000000, 0x10000000, IO_PAGE);
    setbat(1, 0xe0000000, 0xe0000000, 0x10000000, IO_PAGE);
    ioremap_base = 0xe0000000;

    setbat(0, 0xf0000000, 0xf0000000, 0x20000, IO_PAGE);
    setbat(1, 0xe0000000, 0xe0000000, 0x10000000, IO_PAGE);
    ioremap_base = 0xe0000000;


- My Custom Board Info.
    CPU    : MPC8260 (Rev 01, Mask A.1 1K22A-XC) at 198 MHz
    DRAM  : 64 MB  (Base Address 0)
    FLASH : 512 KB (Base Address 0xFFF00000)
    IMMR   : 0xF0000000
      - I changed H/W configuration value 0xFF000000 -> 0xF0000000 in ppcboot.
    No more I/O space for custom board.

Linux port is frist try to me.
I have no more solution.
Please let me know if you have any ideas.
Thank you.

min-gyu Jeon.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
