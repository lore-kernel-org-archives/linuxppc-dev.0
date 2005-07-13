Return-Path: <johnzhan@sinovee.com>
Received: from sinovee.com (unknown [210.192.120.203])
	by ozlabs.org (Postfix) with ESMTP id 1B59767BD0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 14:02:45 +1000 (EST)
Message-ID: <001f01c5875b$71c31070$0300a8c0@amd64>
From: "John Zhan" <johnzhan@sinovee.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 13 Jul 2005 11:32:06 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Subject: About MPC8245 software reboot
Reply-To: John Zhan <johnzhan@sinovee.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,all

Most of MPC8245 kernel port are using watchdog reset manner to get software 
reboot.

I notice that every implement of whaterverplatform_restart()  always enter 
dead loop and then wait for WDT reset.. My idea is, if there has possible to 
implement a software restart function in kernel. Like Uboot doing reset 
command.

Because in my case,the WDT on my customize MPC8245 board has a long timeout 
period, about 30 seconds.

So,

I had to try to replace platform_restart() with do_reset() which found in 
Uboot.

But I got thease, I guess something wrong in memory map.



sh-2.05a# reboot
INIT: Switching to runlevel: 6

Broadcast message from root (console) Thu Dec 4 00:01:21 2003...

The system is going down for reboot NOW !!
INIT: Sending processes the TERM signal
DEBUG: first run the kill scripts
DEBUG:now run the start scripts
Starting killall: [ OK ]
/etc/rc6.d/S01reboot: enable: kill: not a shell builtin
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Unmounting proc file system:
Please stand by while rebooting the system...
Restarting system.


U-Boot 1.1.2 (Jan 25 2005 - 14:55:00) [svm]

CPU: MPC8245 Revision 1.1 at 299.999 MHz: 16 kB I-Cache 16 kB D-Cache
Board: SVM_SC8245 Local Bus at 99.999 MHz
I2C: ready
DRAM: Scan SDRAM memory........................
64 MB
Top of RAM usable for U-Boot at: 04000000
Reserving 460k for U-Boot at: 03f8c000
Reserving 128k for malloc() at: 03f6c000
Reserving 56 Bytes for Board Info at: 03f6bfc8
Reserving 48 Bytes for Global Data at: 03f6bf98
Stack Pointer at: 03f6bf78
New Stack Pointer is: 03f6bf78
Now running in RAM - U-Boot at: 03f8c000
FLASH: 512 kB
PCI Scan: Found Bus 0, Device 22, Function 0
PCI Config: I/O=0x80000000, Memory=0x80000000, Command=0x7
00 16 10ec 8139 0200 0b
PCI Scan: Found Bus 0, Device 23, Function 0
PCI Config: I/O=0x81000000, Memory=0x81000000, Command=0x7
00 17 8086 1209 0200 0c
PCI Scan: Found Bus 0, Device 24, Function 0
00 18 8086 1209 0200 0e
In: serial
Out: serial
Err: serial
U-Boot relocated to 03f8c000
DOC: No DiskOnChip found
Net: Bad trap at PC: fffffffc, SR: 1000, vector=800
NIP: FFFFFFFC XER: 00000000 LR: 00001288 REGS: 03f6bd00 TRAP: 0800 DAR: 
00000000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 00000048 03F6BDF0 FFFFFF1F 03F6C1E8 00000000 00000006 00000000 
01F3F7E0
GPR08: 03FCF1D8 BFFBF000 03FECC8C 0000000E 00000000 10019924 03FF2000 
0408C000
GPR16: 00000000 00000000 00000000 00000000 00009032 00000001 00000000 
C0005E28
GPR24: 03F6BF98 03F6BFC8 00000002 00000002 03F6C1E8 03F6BF98 03FF2788 
03F6C1E8
Call backtrace:
Exception in kernel pc fffffffc signal 0
Exception in kernel pc fffffffc signal 0



then Uboot restart  again.



U-Boot 1.1.2 (Jan 25 2005 - 14:55:00) [svm]

CPU: MPC8245 Revision 1.1 at 299.999 MHz: 16 kB I-Cache 16 kB D-Cache
Board: SVM_SC8245 Local Bus at 99.999 MHz
......................



In the meantime,if I re-power the board,it's running okay. I guess MMU not 
fully reset. Platform_restart() maybe needs more jobs to do.



Here is my implement,



static void sc8245_restart(char *cmd){

        ulong msr, addr;



        /* Interrupts and MMU off */

        __asm__ ("mtspr    81, 0");

        /* Interrupts and MMU off */

        __asm__ __volatile__ ("mfmsr    %0":"=r" (msr):);

        msr &= ~0x1030;

        __asm__ __volatile__ ("mtmsr    %0"::"r" (msr));

        /*

         * Trying to execute the next instruction at a non-existing address

         * should cause a machine check, resulting in reset

         */

        addr = 0xfff00100;

        ((void (*)(void)) addr) ();

        return 1;

}







I do not have idea to get it settle. I knew you guys are very kind,so 
,please help.





Thank you in advanced.



 --

John Zhan.
