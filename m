Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BD52667BB4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 02:55:40 +1100 (EST)
Message-ID: <456C5C11.1050605@ru.mvista.com>
Date: Tue, 28 Nov 2006 18:56:01 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: RE : Using Linux on ML405: Some basic questions
References: <000001c712c4$8252e870$c900a8c0@CRESITTLAB>
	<456C14F0.5020103@computing.dundee.ac.uk>
In-Reply-To: <456C14F0.5020103@computing.dundee.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Mendham wrote:
> alayrac wrote:
>> <----> I have a few questions, I was wondering if someone could help me
>> <----> out:
>> <----> 
>> <----> 1) I don't really understand how the kernel image gets loaded from
>> <----> the .ace file.  I've seen articles which say that the SystemAce
>> <----> controller puts the kernel image directly into RAM, but on
>> <----> inspection of the datasheet I can't see any capability other that
>> <----> JTAG programming and acting as a slave to a processor.  Can anyone
>> <----> explain the way this works?
>>
>> XACCACE can load an ace file from a FAT16 partition into the FPGA fabric
>> using boundary scan chain (JTAG).
>>
>> First of all it loads the FPGA fabric, the bitsream file. If you have a
>> look in Applications in the ML405 project there should be a bootloop
>> code marked as activated and as used to initialized BRAM. 
>> This code is loaded at address 0xFFFFFFFC (where there is a BRAM) wich
>> is the reset address of the powerpc. Thus after bitstream dowload, the
>> powerpc is in an infinite loop so that it won't try to access any
>> peripheral, especially memory.
>>
>> Then systemeace will downlaod the elf file, in your case the kernel
>> image (it could be standalone apllication as well as uboot).
>>
>> To do so the systemace take controle of powerpc through jtag chain (just
>> as you are dowing with the JTAG cable when you are debugging you code on
>> powerpc inside the FPGA). In fact the FPGA fabric include a JTAG daisy
>> chain, so that the PowerPC is seen on JTAG chain after FPGA
>> initialization (if you start an xps design from scratch you will see in
>> the wizard that you can select the debug chain of your powerpc from JTAG
>> or stub...)
>>
>> So just to finish, as soon as system ace can see the PowerPC through
>> JTAG, it can see and use all powerpc peripherals and espaecially the
>> memory in your case. So it read the destination address of the elf image
>> to laod (from the elf file itself) and just copy the data at the
>> specific address. Then it put the PC at this address and sart the
>> powerpc.
>>   
> Wow.  Thanks Chris, that makes a lot of sense, although I had no idea 
> that the SystemAce chip was quite so clever.  I take it that the 
> bitstream in the .ace file is specially constructed by the tools to do 
> the DRAM download?  What is it that produces the text:
> loaded at:     00400000 004E21E4
> board data at: 004DF13C 004DF154
> relocated to:  00405660 00405678
> zimage at:     00405C25 004DE92F
> avail ram:     004E3000 04000000
> I have always assumed that it is a piece of software that does this.  Is 
> that correct?

This is from the bootwrapper code (arch/ppc/boot/simple/)

> Thanks very much for replying, the information is really helpful.
> -- Peter
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
