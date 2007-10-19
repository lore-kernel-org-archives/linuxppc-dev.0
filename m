Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C857DDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Oct 2007 04:13:38 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IiwLn-0002hC-FN
	for linuxppc-embedded@ozlabs.org; Fri, 19 Oct 2007 11:13:35 -0700
Message-ID: <13300089.post@talk.nabble.com>
Date: Fri, 19 Oct 2007 11:13:35 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SystemACE driver problem
In-Reply-To: <fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13290652.post@talk.nabble.com>
	<fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




Grant Likely-2 wrote:
> 
> On 10/19/07, aauer1 <aauer1@gmx.at> wrote:
>>
>> Hello
>>
>> I'm trying to boot a Linux Kernel 2.6.23-rc2 from Grant Likely (thanks
>> for
>> the great work) on a Xilinx ML403 board. I want to use the second
>> partition
>> of the Compact Flash Card as root filesystem. But the boot process hangs
>> at
>> the initialization of the SystemACE module. A strange effect is that the
>> DONE LED (configuration of the FPGA is done) turns off. So, this means
>> that
>> the FPGA loses his configuration.
>> Has anybody recognized a similar problem with the SystemACE module??
>>
>> The boot log:
>> ========
> [snipped]
>> [    0.268807] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a
>> uartlite
>> [    0.270399] console [ttyUL0] enabled
>> [    1.762725] RAMDISK driver initialized: 8 RAM disks of 8192K size 1024
>> blocke
>> [    1.852062] Registering Xilinx SystemACE driver, major=254
>> [    1.919734] xsysace xsysace.0: ace_probe(c01638e0)
> 
> Yes, I've seen that.  It means something went wrong with the setup and
> caused the sysace to reload the FPGA.  Is the systemace base address
> and bus width set correctly?
> 
> 

The base address is the same as in the system.mhs file of my hardware
design. So, I think it should be correct. The bus width is set to 16 bits
(hardware design). So far as I can see, the sysace driver defines a 16 bit
data bus (hard coded), too. 

A paper of BlueCat Linux says that there is a problem with the System ACE
hardware module:
"Due to a known problem of the opb_sysace IP Core programmed into the FPGA
(incorrect operation in the interrupt mode) the SystemACE Compact Flash
device is supported in the polling mode."

Does anyone know something about the bug in the SystemACE IP core?? 

Thanks,
Andreas

-- 
View this message in context: http://www.nabble.com/SystemACE-driver-problem-tf4651846.html#a13300089
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
