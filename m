Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AA1BDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 23:50:21 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ijxfe-0000xS-FC
	for linuxppc-embedded@ozlabs.org; Mon, 22 Oct 2007 06:50:18 -0700
Message-ID: <13342284.post@talk.nabble.com>
Date: Mon, 22 Oct 2007 06:50:18 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SystemACE driver problem
In-Reply-To: <fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13290652.post@talk.nabble.com>
	<fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>
	<13300089.post@talk.nabble.com>
	<fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I have partly solved my problem with the System ACE controller. And I think
it may be interesting for. I don't know the real cause of the problem,
because it is very difficult to reproduce it. But I think the problem is
anywhere in the initialization of the System ACE controller.

So, I started a new design with the Xilinx platform studio and wrote my own
code to read the first sector of the CF card. This code is not very
beautiful, but it works. So, I configured the FPGA and downloaded my
program. And wow... I get the first sector of the card.
Afterwards, I reseted the System ACE controller and downloaded the
zImage.elf from my kernel. Now, the kernel can initialize the CF card and
mount the root filesystem. Wonderful!

If the problem occurs again, I will have a closer look. 

For the sake of completeness, my init code:
================================
  XStatus status;
  XSysAce SysAce;
  int i=0;
  volatile short *ptr  = (short *)0x41800000;  // BASE Address of SYSACE
  volatile char  *cptr = (char *) 0x41800000; // BASE Address of SYSACE

  print("\r\nTesting SysAce for SysACE_CompactFlash...\r\n");
  status = XSysAce_Initialize(&SysAce, XPAR_SYSACE_COMPACTFLASH_DEVICE_ID);
  if(status != XST_SUCCESS)
  {
    print("Init... FAILED\r\n");
  }
  else 
  {
    print("Init... PASSED\r\n");
    printf("Base Address: %x\r\n",SysAce.BaseAddress);
    printf("Is Ready: %x\r\n",SysAce.IsReady);
    printf("sizeof(short): %d\r\n", sizeof(short));
    printf("Status0 value: %x\r\n",ptr[2]);
    printf("Status1 value: %x\r\n",ptr[3]);
    printf("Error0 value: %x\r\n",ptr[4]);
    printf("Error1 value: %x\r\n",ptr[5]);
    printf("Version value: %x\r\n",ptr[0xb]);
		
    printf("Ctrl0 value: %x\r\n",cptr[0x18]);
    printf("Ctrl0 value: %x\r\n",cptr[0x18]);
    ptr[0xc] = 0x0300;
    printf("Status0 value: %x\r\n",ptr[2]);
    while(!(ptr[2] & 0x0200));
    print("Lock granted\r\n");
    while(!(ptr[2] & 0x0001));
    print("Ready for command\r\n");
			
    ptr[8] = 0x0000; // LBA
    ptr[9] = 0x0000; // LBA
    ptr[10] = 0x0103;
			
    ptr[0xc] = 0x8000;
    while(!(ptr[3] & 0x0200));
    print("Busy cleared\r\n");
    printf("Status0 value: %x\r\n",ptr[2]);
    while(!(ptr[2] & 0x2000));
    print("Data Buffer is ready\r\n");
			
    for(i=0;i<256;i++)
    {
      printf("0x%04x\r\n", ptr[0x20]&0xffff);
    }
			
    ptr[0xc] = 0x0100;
    printf("Status0 value: %x\r\n",ptr[2]);
    printf("Ctrl0 value: %x\r\n",ptr[0xc]);
    printf("Ctrl1 value: %x\r\n",ptr[0xd]);

Cheers,
Andreas



Grant Likely-2 wrote:
> 
> On 10/19/07, aauer1 <aauer1@gmx.at> wrote:
>>
>>
>>
>> Grant Likely-2 wrote:
>> >
>> > On 10/19/07, aauer1 <aauer1@gmx.at> wrote:
>> >>
>> >> Hello
>> >>
>> >> I'm trying to boot a Linux Kernel 2.6.23-rc2 from Grant Likely (thanks
>> >> for
>> >> the great work) on a Xilinx ML403 board. I want to use the second
>> >> partition
>> >> of the Compact Flash Card as root filesystem. But the boot process
>> hangs
>> >> at
>> >> the initialization of the SystemACE module. A strange effect is that
>> the
>> >> DONE LED (configuration of the FPGA is done) turns off. So, this means
>> >> that
>> >> the FPGA loses his configuration.
>> >> Has anybody recognized a similar problem with the SystemACE module??
>> >>
>> >> The boot log:
>> >> ========
>> > [snipped]
>> >> [    0.268807] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a
>> >> uartlite
>> >> [    0.270399] console [ttyUL0] enabled
>> >> [    1.762725] RAMDISK driver initialized: 8 RAM disks of 8192K size
>> 1024
>> >> blocke
>> >> [    1.852062] Registering Xilinx SystemACE driver, major=254
>> >> [    1.919734] xsysace xsysace.0: ace_probe(c01638e0)
>> >
>> > Yes, I've seen that.  It means something went wrong with the setup and
>> > caused the sysace to reload the FPGA.  Is the systemace base address
>> > and bus width set correctly?
>> >
>> >
>>
>> The base address is the same as in the system.mhs file of my hardware
>> design. So, I think it should be correct. The bus width is set to 16 bits
>> (hardware design). So far as I can see, the sysace driver defines a 16
>> bit
>> data bus (hard coded), too.
> 
> Hmmm; that's all very odd.  I don't know what could be causing that.
> 
>> A paper of BlueCat Linux says that there is a problem with the System ACE
>> hardware module:
>> "Due to a known problem of the opb_sysace IP Core programmed into the
>> FPGA
>> (incorrect operation in the interrupt mode) the SystemACE Compact Flash
>> device is supported in the polling mode."
>>
>> Does anyone know something about the bug in the SystemACE IP core??
> 
> I don't know about the old xilinx supplied sysace driver, but the new
> xsysace.c driver is robust enough to work around missed interrupts.  I
> don't know of any other problems with the opb_sysace IP core.
> 
> Cheers,
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/SystemACE-driver-problem-tf4651846.html#a13342284
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
