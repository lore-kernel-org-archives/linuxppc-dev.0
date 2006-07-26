Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 3CD8667B5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 20:42:23 +1000 (EST)
Message-ID: <44C747E0.2010207@ru.mvista.com>
Date: Wed, 26 Jul 2006 14:45:52 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Clint Thomas <cthomas@Soneticom.com>
Subject: Re: Booting Linux Kernel without bootloader
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
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

Hi Clint,

You may want to look at the arch/ppc/boot/simple bootwrapper.
This wrapper links together with the compressed kernel image
into single file. One just needs to load this file into memory
and pass control to the wrapper. The bootwrapper uncompresses
the kernel into memory and passes the board information in bd_t structure.

As an example, Xilinx ML300 or ML403 boards (without any firmware)
can be booted this way: load zImage.elf into RAM (e.g. using JTAG
debugger) and jump to the the wrapper entry point.

This stuff is not in arch/powerpc yet, but recently Mark Greer
has posted the patches to fix that:
[PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg patches

Thanks,
Andrei

Clint Thomas wrote:
> Hey guys,
> 
> I have gone through the Linuxppc embedded and dev lists for information 
> related to what I am trying to do, but was unable to find exactly what 
> i'm looking for.
> 
> Basically, the system I want linux running on does not require the 
> initialization of hardware that U-boot provides, or at least it does not 
> need it to boot the linux kernel. I want to load an uncompressed linux 
> kernel into memory and start the execution of the kernel, without using 
> any kind of bootloader. Is this possible? Or does linux need some kind 
> of firmware or other software to tell it to start executing? Thanks for 
> any info you might have.
>  
> Clinton Thomas
> cthomas@soneticom.com
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
