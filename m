Message-ID: <3E54E4E1.D60F5A7@tataelxsi.co.in>
Date: Thu, 20 Feb 2003 19:53:29 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem booting Linux on MPC8260ADS board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

I am facing a problem in booting the Linux on MPC8260ADS board.
Linux version : 2.4.17 (MontaVista)

I have added the patches required to MPC8260ADS board like setting up
the memory map and BATs.

Control enters "start_here" subroutine
(linux2.4.17_mvl121/arch/ppc/kernel). But it hangs before calling
"load_mmu" subroutine.

--- Code begins ---
/*
 * Go back to running unmapped so we can load up new values
 * for SDR1 (hash table pointer) and the segment registers
 * and change to using our exception vectors.
 */
 lis r4,2f@h
 ori r4,r4,2f@l
 tophys(r4,r4)
 li r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
 FIX_SRR1(r3,r5)
 mtspr SRR0,r4
 mtspr SRR1,r3
 SYNC
 RFI        (**** <= After this, MPC8260 hangs ****)

/* Load up the kernel context */
2:
--- Code ends ---

Is there any reason for this to happen??? And any solutions to get the
linux going...

Am i using the wrong file in compilation, by any chance?

Any help is appreciated.
Thanks and regards,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
