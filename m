Message-ID: <38E251F9.4D8DE2EA@email.sps.mot.com>
Date: Wed, 29 Mar 2000 17:56:57 -0100
From: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: no access to kernel symbols
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

i have big problems to access the symbols from the kernel. The mystique
is, that i can see all the symblols with:

# cat /proc/ksyms
c000283c clear_page_Rc0b2879e
c0005d78 do_signal_R6b4b6273
c0007d80 syscall_trace_R8994abdd
c0002000 transfer_to_handler_R90501868
c0002544 int_return_Rb0f19035
.........

also i see it with:

#ksyms -a
Address  Symbol         Defined by
C000283C clear_page_Rc0b2879e
C0005D78 do_signal_R6b4b6273
C0007D80 syscall_trace_R8994abdd
C0002000 transfer_to_handler_R90501868
C0002544 int_return_Rb0f19035
........

But this doesn't work:

# insmod -fv hello
Section 1: (.text) at 0x18537f8
Section 2: (.rela.text) at 0x1854f20
Section 3: (.data) at 0x1853878
Section 5: (.modinfo) at 0x1853878
Section 6: (.sdata) at 0x1853878
Section 7: (.rodata) at 0x1853880
Section 8: (.comment) at 0x18538b0
Section 9: (.shstrtab) at 0x1854f70
Section 10: (.symtab) at 0x1854fd0
Section 11: (.strtab) at 0x1855158
textseg = 0x18537f8
bss_size = 25508080
last byte = 0x18548f0
module size = 4344
jump table = 0x18538f0
versioned kernel: no
versioned module: no
ELF kernel
ELF module
printk undefined
Loading failed! The module symbols (from linux-2.2.13) don't match your
linux-2.2.13

With objdump i verify that all, the kernel, the hello module and the
insmod programm are all of the elf32-powerpc format. I compiled the
hello.c with the flags -c -Wall -DMODULE -D__KERNEL__ on the target
board (MBX860,NFS,egcs-2.92.33) with the same include files i used to
compile the kernel 2.2.13.

My hello.c file :
-------------------------------------------
#define __KERNEL__
#define MODULE
#include<linux/module.h>
#include<linux/kernel.h>
#include<linux/version.h>

char kernel_version[] = UTS_RELEASE;

int init_module(void)
{
  printk("<1> Hello, world\n");
  return 0;
}
void cleanup_module(void)
{
  printk("<1> Goodbye cruel world\n");
}
--------------------------------------------


If anyone have any suggestion, please send me. I don't have no more
ideas for the moment.


--

Regards,
     Stephan


------------------------
Stephan Ruettiger
Motorola Munich
r0337c@email.sps.mot.com
------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
