Message-Id: <s12c93b6.087@EMAIL>
Date: Wed, 25 Aug 2004 13:20:38 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <oliver.king-smith@nuvation.com>
Subject: Re: Problem trying to address custom hardware
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Oliver,
I guess you are missing just the Chip Select initialization for the CPLD memory map.

--
Rupesh S

>>> Oliver King-Smith <oliver.king-smith@nuvation.com> 08/25/04 04:40AM >>>

Hello,

I am using a IBM405EP to run Linux.  I am trying to add a CPLD to the
system that has a few registers I want to read and write from. This
device is wired physically to respond when it sees
0x40000000-0x40000010 on the PPC address pins.  So I wrote the
following program:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>

#define CPLD_OFFSET    0x40000000

typedef struct{
        unsigned long register1;
        int register2;
}CPLD_REGISTERS;

#define CPLD_SIZE      sizeof(CPLD_REGISTERS)

int main()
{
        int memfd;
        volatile CPLD_REGISTERS *pCPLD;

        memfd = open("/dev/mem", O_RDWR);
        if (memfd){
               pCPLD = (CPLD_REGISTERS *) mmap(0,
                       CPLD_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE,
                       memfd, CPLD_OFFSET);
               if( pCPLD>0 )
               {
                       int readback;
                       printf( "CPLD located at virtual address %x\n",
                               (unsigned long) pCPLD );
                       pCPLD->register1 = 1;          // !!!CRASH!!!
...


It maps into a part of virtual space that make
sense from other setups shown in /proc/#/maps.  (i.e. pCPLD is 0x30150000)

The /proc/kmsg gives the following errors
<4>do_wp_page: bogus page at address 30015000 (page 0xc0d1f01c)
<4>VM: killing process mmap.out

This seems reasonable enough.  So I tried mapping in a page to VM using a
small driver.  I wrote the following code, and instantiated it with
insmod.

#define MODULE
#include <linux/module.h>

#define CPLD_P_ADDR     0x40000000
#define CPLD_V_ADDR     0xE8126000

typedef struct{
         unsigned long register1;
         unsigned long register2;
}CPLD_REGISTERS;

#define CPLD_SIZE       sizeof(CPLD_REGISTERS)

volatile CPLD_REGISTERS *pCPLD;

int init_module(void)
{
         printk( "<1> Hello World\n" );
         pCPLD = (volatile CPLD_REGISTERS *)ioremap( CPLD_P_ADDR,
CPLD_SIZE );
         if( pCPLD>0 )
         {
                 printk( "CPLD located at virtual address %x and held at
%x\n", (unsigned long)pCPLD, (unsigned long)&pCPLD );
                 pCPLD->register1 = 1; // !!! CRASH !!!
...

And I get a crash again.  The value for pCPLD is in the 0xC3xxxxxx range.
<1> init_module in cpld_module.c on line 22
<4>CPLD located at virtual address c3019000 and held at c3017390
<4>Data machine check in kernel mode.
<4>Oops: machine check, sig: 7
<4>NIP: C0014990 XER: 00000000 LR: C3017120 SP: C19ADDE0 REGS: c19add30
TRAP: 0200    Tainted: P
<4>MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>TASK = c19ac000[80] 'insmod' Last syscall: 128
<4>last math 00000000 last altivec 00000000
<4>PLB0: bear= 0x40000000 acr=   0x00000000 besr=  0x00c00000
<4>PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000
<4>
<4>GPR00: 01000000 C19ADDE0 C19AC000 C301724C 00000000 00000001
00000020 C01F0000
<4>GPR08: 000035BF C3019000 00000000 C19ADDEC 80042082 1003A0CC
00000000 00000000
<4>GPR16: 00000000 00000001 00000000 00000000 00009032 019ADF40
C19ADEA8 C1C25D00
<4>GPR24: 0000000B C19ADF0C 1003BA38 C3010000 C3010000 C19ADDE8
C3010000 C3010000
<4>Call backtrace:
<4>C0014AF0 C3017120 C0015D78 C000475C 1003BA38 10003A34 10004F2C
<4>10008CA8 10008EC8 0FECAC30 00000000

If anyone could tell me what I am doing wrong, I would greatly
appreciate it.

Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
