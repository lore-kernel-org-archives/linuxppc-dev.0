Message-ID: <025b01c2c355$199c8600$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Jason Park" <jason@amadeus.kist.re.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001701c2c33f$298715f0$5e207aa1@fish>
Subject: Re: How do you change the program counter (PC)
Date: Fri, 24 Jan 2003 11:02:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> now, i want to test and check whether the ppcboot loader will work properly
> before i overwrite the planetcore bootloader code.  how can i change the PC
> (which states 0xfff0 0100 when i type "info" at the BDI prompt)...
go 0xffc00100
or
ti  0xffc00100


> also, whats the main difference between the 3 files created by ppcboot.
> (ELF, BIN, SREC)  besides size..  is there an advantage/disadvantage using
> one over the other?  is it dependant on the debugger?
ELF: portable binary format, which has program headers/sections and others
information. You can't excute the ELF file directly. It needs intepreter(or named
loader) to load it to proper memory address. BDI can do it. But remember not to
program it to flash for excuting directly.

BIN: pure binary format, which has nothing but cpu instrctions(and data). If you
want to program it to flash, it's the proper choise.

SREC: (I am not much sure) It seems an old format used mostly by motorola.
It's like BIN format, but has other information used for downloading. It seems
some bootloaders need SREC format for downloading.

Don't trust me. For ELF & SREC, you can download the specification if you do
have interesting, and for BIN file, you do can disassemble it if you really want
to know what's in it (of course, ELF format is the best choise for disassembling).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
