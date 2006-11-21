Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CA0BF67BF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 22:45:20 +1100 (EST)
Message-ID: <4562E546.9070401@ru.mvista.com>
Date: Tue, 21 Nov 2006 14:38:46 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: goudard@esrf.fr
Subject: Re: Memec v4fx12lc - problem booting linux on ppc
References: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>	<JG200611211159003.3859000@co-nss.co.jp>
	<1164102298.21858.4.camel@l-cb312-1.esrf.fr>
In-Reply-To: <1164102298.21858.4.camel@l-cb312-1.esrf.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, andy.gotz@esrf.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Olivier,

As you haven't seen *any* output from UART, it looks like
the problems start well before the bootwrapper passes
control to the linux kernel.

 > XMD% dow zImage.embedded
 >         section, .text: 0x00400000-0x004048b0
 >         section, .data: 0x00405000-0x004af000
 >         section, .bss: 0x004af000-0x004b21e4

- these three sections are not from the linux kernel;
this is the bootwrapper (see arch/ppc/boot/simple/).
As you can see, the bootwrapper's code is 18kBytes or so
(0x48b0) and is loaded 4MBytes above 0 (0x400000).
700kBytes (0xaa000) of .data contain the compressed kernel
plus some bootwrapper's stuff.

The bootloader is linked together with the compressed kernel image
(zvmlinux target in the arch/ppc/boot/simple/Makefile; vmlinux.gz
is put into .image section which gets into .data according to
arch/ppc/boot/ld.script). The bootwrapper uncompresses the kernel
to 0x00000000 and then passes control to the kernel.

 > XMD%
 > Processor stopped at PC: 0x00401a10

This address does not correspond to 0xc0001a10.
This is inside the bootwrapper, and MMU is still off.
You may want to disassemble zImage.embedded itself
to check what is at this address.

If you look at arch/ppc/boot/simple/misc-embedded.c, load_kernel()
you will notice, that before uncompressing the kernel
the bootwrapper sends the following to the 16x50-compatible UART
(this may be not true for UART Lite):

   loaded at:     00400000 0053B13C
   board data at: 00539124 0053913C
   relocated to:  004051D4 004051EC
   zimage at:     00405A2D 00538651
   avail ram:     0053C000 04000000

   Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/nfs rw
   Uncompressing Linux...done

Usually the board hangs after "Uncompressing Linux...done" :)
I.e. right after control is passed to vmlinux.
If you use 16x50-compatible UART, CONFIG_SERIAL_8250_CONSOLE
is defined, and you don't see "loaded at:" et al, then the
UART configuration in the kernel (and the bootwrapper) is
very wrong.

Have you created your own platform or use existing xilinx_ml<something>?
Have you used the proper xparameters<something_else>.h file
to build the kernel?
And what kernel version is it BTW? (I was looking at 2.6 when
writing this message; 2.4 shouldn't be very different).

Thanks,
Andrei

Olivier Goudard wrote:
> Yoshio San,
> 
> thank you for your reply. We tried what you suggest. Here is the output
> from xmd :
> 
> XMD% dow zImage.embedded
>         section, .text: 0x00400000-0x004048b0
>         section, .data: 0x00405000-0x004af000
>         section, .bss: 0x004af000-0x004b21e4
> Downloaded Program zImage.embedded
> Setting PC with program start addr = 0x00400000
> PC reset to 0x00400000, Clearing MSR Register
> XMD% run
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
> RUNNING> stop
> XMD%
> XMD%
> Processor stopped at PC: 0x00401180
> 
> XMD% run
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
> RUNNING> stop
> XMD%
> XMD%
> Processor stopped at PC: 0x00401a18
> 
> XMD% run
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
> RUNNING> stop
> XMD%
> XMD%
> Processor stopped at PC: 0x00401180
> 
> XMD% run
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
> RUNNING> stop
> XMD%
> XMD%
> Processor stopped at PC: 0x00401a10
> 
> The two address where the processor stops correspond to this assembler
> code :
> 
> c0001100 <DTLBMiss>:
> c0001100:       7e 90 43 a6     mtsprg  0,r20
> c0001104:       7e b1 43 a6     mtsprg  1,r21
> c0001108:       7e d4 43 a6     mtsprg4 r22
> c000110c:       7e f5 43 a6     mtsprg5 r23
> c0001110:       7e a0 00 26     mfcr    r21
> c0001114:       7e d1 ea a6     mfpid   r22
> c0001118:       7e b7 43 a6     mtsprg7 r21
> c000111c:       7e d6 43 a6     mtsprg6 r22
> c0001120:       7e 95 f2 a6     mfdear  r20
> c0001124:       76 95 80 00     andis.  r21,r20,32768
> c0001128:       41 82 00 18     beq-    c0001140 <DTLBMiss+0x40>
> c000112c:       3e a0 c0 14     lis     r21,-16364
> c0001130:       62 b5 d0 00     ori     r21,r21,53248
> c0001134:       3a e0 00 00     li      r23,0
> c0001138:       7e f1 eb a6     mtpid   r23
> c000113c:       48 00 00 0c     b       c0001148 <DTLBMiss+0x48>
> c0001140:       7e b3 42 a6     mfsprg  r21,3
> c0001144:       82 b5 00 0c     lwz     r21,12(r21)
> c0001148:       3e b5 40 00     addis   r21,r21,16384
> c000114c:       52 95 65 3a     rlwimi  r21,r20,12,20,29
> c0001150:       82 b5 00 00     lwz     r21,0(r21)
> c0001154:       56 b6 00 27     rlwinm. r22,r21,0,0,19
> c0001158:       41 82 00 2c     beq-    c0001184 <DTLBMiss+0x84>
> c000115c:       3e d6 40 00     addis   r22,r22,16384
> c0001160:       52 96 b5 3a     rlwimi  r22,r20,22,20,29
> c0001164:       82 b6 00 00     lwz     r21,0(r22)
> c0001168:       72 b7 00 02     andi.   r23,r21,2
> c000116c:       41 82 00 18     beq-    c0001184 <DTLBMiss+0x84>
> c0001170:       62 b5 04 00     ori     r21,r21,1024
> c0001174:       92 b6 00 00     stw     r21,0(r22)
> c0001178:       3a c0 0c e2     li      r22,3298
> c000117c:       7e b5 b0 78     andc    r21,r21,r22
> c0001180:       48 00 0f e4     b       c0002164 <finish_tlb_load>
> c0001184:       7e d6 42 a6     mfspr   r22,278
> c0001188:       7e b7 42 a6     mfspr   r21,279
> c000118c:       7e d1 eb a6     mtpid   r22
> c0001190:       7e af f1 20     mtcr    r21
> c0001194:       7e f5 42 a6     mfspr   r23,277
> c0001198:       7e d4 42 a6     mfspr   r22,276
> c000119c:       7e b1 42 a6     mfsprg  r21,1
> c00011a0:       7e 90 42 a6     mfsprg  r20,0
> c00011a4:       4b ff f6 5c     b       c0000800 <DataAccess>
> 
> and this :
> 
> c0001a00 <Trap_1A>:
> c0001a00:       7e 90 43 a6     mtsprg  0,r20
> c0001a04:       7e b1 43 a6     mtsprg  1,r21
> c0001a08:       7e 80 00 26     mfcr    r20
> c0001a0c:       7e b2 42 a6     mfsprg  r21,2
> c0001a10:       2c 15 00 00     cmpwi   r21,0
> c0001a14:       40 82 00 0c     bne-    c0001a20 <Trap_1A+0x20>
> c0001a18:       3e a1 40 00     addis   r21,r1,16384
> c0001a1c:       3a b5 ff 40     addi    r21,r21,-192
> c0001a20:       92 95 00 a8     stw     r20,168(r21)
> c0001a24:       92 d5 00 68     stw     r22,104(r21)
> c0001a28:       92 f5 00 6c     stw     r23,108(r21)
> c0001a2c:       7e 90 42 a6     mfsprg  r20,0
> c0001a30:       92 95 00 60     stw     r20,96(r21)
> c0001a34:       7e d1 42 a6     mfsprg  r22,1
> c0001a38:       92 d5 00 64     stw     r22,100(r21)
> c0001a3c:       7e 88 02 a6     mflr    r20
> c0001a40:       92 95 00 a0     stw     r20,160(r21)
> c0001a44:       7e c9 02 a6     mfctr   r22
> c0001a48:       92 d5 00 9c     stw     r22,156(r21)
> c0001a4c:       7e 81 02 a6     mfxer   r20
> c0001a50:       92 95 00 a4     stw     r20,164(r21)
> c0001a54:       7e da 02 a6     mfsrr0  r22
> c0001a58:       3e 80 00 04     lis     r20,4
> c0001a5c:       7e fb 02 a6     mfsrr1  r23
> 
> Unfortunately we are not linux kernel experts so we do not know what
> these two routines correspond to. Do you are anyone have an idea. It
> looks like the linux kernel is stopping almost immediately i.e. before
> trying to do anything visible on the screen.
> 
> Has anyone seen similar behaviour ? We are stuck with this board and
> before we abandon the project (or change boards) we would like to make a
> final attempt.
> 
> Thanks for any help again
> 
> Olivier
> 
>> Olivier San,
>>
>> The address of each device driver of LSP of MontaVista Linux and the
>> address of each IP of the generated circuit match?
>>
>> Although your detailed environment is not known, the general way of
>> investigating is as follows.
>>
>> Check where the processor was stopped by the stop command and the
>> processor has stopped after runing from xmd.
>> If compared with stopped address and the address of System.map or
>> disassembling list of vmlinux, it should be able to be decided by
>> which processing it has hangs.
>> Disassembling of vmlinux can be displayed by powerpc-linux-objdump -D 
>> vmlinux.
>>
>> Best Regards,
>>
>> Yoshio Kashiwagi - Nissin Systems
>>
>>> Hi,
>>>
>>> we have a v4fx12lc fpga board from memec which we are trying to get
>>> Linux to boot on the ppc processor. We have generated a linux kernel 
>> for
>>> nfs using the MontaVista support package. We generate a bitfile with 
>> the
>>> following hardware peripherals in it :
>>>
>>> RS232
>>> Ethernet_MAC
>>> Led_4bit
>>> Push_buttons_3bits
>>> DIP_switches_8bit
>>> OPB_INTC_0
>>>
>>> When we download the linux image with xmd we see nothing on the screen.
>>> When we type "run" nothing appears on the screen and Linux does not
>>> boot.
>>>
>>> Has anyone had a similar problem ? We are stuck! Any ideas would be
>>> appreciated.
>>>
>>> We can boot a linux ramdisk kernel provided by Memec on the same board
>>> using their bitfile. So the board seems to be working in general.
>>>
>>> Thansk for any pointers and excuse us if we are posting to the wrong
>>> list (this is the only list we could find which seemed useful) ! 
>>>
>>> Olivier Goudard
>>
>>
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
