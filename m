Message-ID: <00b901c18531$20928710$1a11efcb@industrialDiv.hanasys.co.kr>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC755 Porting Problem
Date: Sat, 15 Dec 2001 15:24:18 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi?
I'm porting linux for a MPC755 board which I designed,
and having some trouble with arch/ppc/kernel/head.S
I load the kernel at phiscal address 0x00000000
and head.S seams to relocate it to 0xc0000000
The code is like this

        mfmsr   r0 /* Inst and data addr translations are disabled */
        ori     r0,r0,MSR_DR|MSR_IR /* enable Inst and data addr translation */
        mtspr   SRR1,r0
        lis     r0,start_here@h
        ori     r0,r0,start_here@l
        mtspr   SRR0,r0
        SYNC
        RFI /* jump to SRR0 */

start_here:
        /* Call setup_cpu for CPU 0 */
        li      r3,0            /* data offset */
        li      r24,0           /* cpu# */
        bl      call_setup_cpu

It is running at base address 0x00000000.
start_here is at address 0xc000369c.
And the IBAT0, and DBAT0 is C0001FFE-00000002.
So after RFI it should go to start_here.

But If I insert some code like 'bl serial_hello',
which prints hello? to serial console after start_here.
It never prints a message. It works before the RFI.

Where can I start to debug it?

serial_hello is like this.

void
serial_hello()
{
        serial_putc(SCC_A_ADDRESS,'h');
        serial_putc(SCC_A_ADDRESS,'e');
        serial_putc(SCC_A_ADDRESS,'l');
        serial_putc(SCC_A_ADDRESS,'l');
        serial_putc(SCC_A_ADDRESS,'o');
        serial_putc(SCC_A_ADDRESS,'?');
        serial_putc(SCC_A_ADDRESS,'\n');
        serial_putc(SCC_A_ADDRESS,'\r');
}
Thanks in advance.
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
