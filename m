Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 3D8452BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Nov 2004 23:40:06 +1100 (EST)
Message-ID: <1101732712.41ab1b682760f@webmail.televes.com:443>
Date: Mon, 29 Nov 2004 13:51:52 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
References: <1101236780.41a38a2c7f44f@webmail.televes.com:443>
	<2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
In-Reply-To: <2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Kernel 2.6.10-rc1 yet not running on ads8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

After commenting out the BCSR lines on m82xx_board_init as Dan
suggested, some problem still prevents kernel 2.6.10-rc1 from
running in ads8272 board.

After running MMU_init, next step in head.S is this

/*
 * Go back to running unmapped so we can load up new values
 * for SDR1 (hash table pointer) and the segment registers
 * and change to using our exception vectors.
 */
        lis     r4,2f@h
        ori     r4,r4,2f@l
        tophys(r4,r4)
        li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
        FIX_SRR1(r3,r5)
        mtspr   SRR0,r4
        mtspr   SRR1,r3
        SYNC
        RFI
/* Load up the kernel context */
2:      bl      load_up_mmu

which is not clear for me. Here, the execution flow breaks
in RFI and never arrives to "bl load_up_mmu". The value of
SRR0 and SRR1 before RFI is:

8272>rd srr0
srr0: 0x000035f8  13816

8272>rd srr1
srr1: 0x00001002  4098

SRR0=0x35f8 is the EA where "bl load_up_mmu" instruction is
supposed to be.

So now I have no idea about what or why this is not working.
Any help would be very valuable. My knowledge about this
stuff is actually very limited.


Thanks,

Alex Bastos


Dan Malek <dan@embeddededge.com> wrote

> > When this code is executed, the kernel jumps directly to another
> > address, 0xc000984c,
>
> I suspect the MMU isn't yet set up to map the address of the BCSR.
> Access the address causes a fault, and the "jump" you see is the
> result of executing a bunch of exception handler instructions that
> you won't single step due to the exception priorities.
>
> 	-- Dan
