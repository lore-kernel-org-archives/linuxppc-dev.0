Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6CDE@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Rudolf Ladyzhenskii '" <rudolf.ladyzhenskii@act-aus.net>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: insmod / add-symbol-file
Date: Fri, 7 Dec 2001 11:29:40 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the advise; unfortunately, it does not work... :-<<

I did some additional tests, and all symbols in the .text-segment are OK,
the others use the same .text offset....

Fred



-----Original Message-----
From: Rudolf Ladyzhenskii
To: 'Goddeeris Frederic'
Sent: 12/7/01 1:38 AM
Subject: RE: insmod / add-symbol-file

try compiler option -ggdb

Rudolf

> -----Original Message-----
> From: Goddeeris Frederic [mailto:Frederic.Goddeeris@siemens.atea.be]
> Sent: Thursday, December 06, 2001 11:10 PM
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: insmod / add-symbol-file
>
>
>
>  Hi,
>
> I am loading a kernel module (insmod) on the target and get
> the following
> info:
> ....
> Sections:       Size      Address   Align
> .this           00000060  c4843000  2**2
> .text           00000470  c4843060  2**2
> .rodata         00000244  c48434d0  2**2
> .data           00000058  c4843714  2**2
> .sdata          00000014  c484376c  2**2
> .vtop_fixup     00000004  c4843780  2**1
> .kstrtab        0000008f  c4843784  2**0
> .bss            00000014  c4843814  2**2
> .plt            00000040  c4843830  2**4
> __ksymtab       00000058  c4843870  2**2
> .....
> c484376c d .sdata
> .....
> c4843774 D f_PWMCounter
> .....
>
> In GDB I load the symbol-table:
> (gdb) add-symbol-file TestDrv.o -T.text 0xc4843060 -T.sdata 0xc484376c
> -T.data 0xc4843714
> add symbol table from file "TestDrv.o" at
> 	.text_addr = 0xc4843060
> 	.sdata_addr = 0xc484376c
> 	.data_addr = 0xc4843714
>
> I am able to set breakpoints and step in the code, but gdb
> does think the
> variable f_PWMCounter is at 0xc4843068 (this is .text+8)
> while it is at
> 0xc4843774 (this is .sdata+8) ....
>
> (When I ask to show *((char*)0x0xc4843774), I get the correct
> value, so MMU
> translation is working...)
>
> When ask for an objdump of the file I see:
> 00000008 g     O .sdata 00000001 f_PWMCounter
>
> So I am wondering why gdb does not see this variable is in the .sdata
> section.
>
> I use the gcc and gdb from the MontaVista CDK 2.0 for
> PPC_8xx. I compiled
> the module with "-O2 -g" options.
>
> Thanks,
> Frederic
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
