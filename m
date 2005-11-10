Return-Path: <robin@india.tejasnetworks.com>
Received: from anche.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30BCE686FA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 01:43:39 +1100 (EST)
Message-ID: <43735DD0.9030205@india.tejasnetworks.com>
Date: Thu, 10 Nov 2005 20:18:48 +0530
From: Robin Mathew <robin@india.tejasnetworks.com>
MIME-Version: 1.0
To: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicholas Basker <nbasker@india.tejasnetworks.com>
Subject: SCC QMC driver for 8247
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello:

We are working on implementing driver for SCC operating in QMC mode that 
supports multiple HDLC channels. The details of the system we are using 
are the following.

CPU Version = 8247 based on 82xx family of processor(PVR 80822014)
The Linux OS Version = DENKS Linux version 2.4.20.
The Peripherals used are = FCC1 in 10/100 ethernet
                                            FCC2 in 10/100 ethernet
                                            SCC1 currently not used, but 
proposed to be used in HDLC mode.
                                            SCC3 is not used.
                                            SCC4 operating in QMC mode 
with super -channel capability. Trying to operate 192kbps HDLC channel 
(using 3x64kbps QMC channels).
                                            SMC2 in UART mode (as a 
simple debug port without any modem signals).
                                            SPI interface currently not 
used but shall be used in future.
                                            I2C is being used.

01. Can the channel specific parameters of the SCC4 in QMC mode be 
relocated from DPRAM base address?? There is no mention in the 
8272RM.pdf about configuring the base address of channel specific 
parameters. From the QMC memory structure diagram, it looks like the 
channel specific parameters will be taken from the the DPRAM base 
address. Can you please confirm it?

02. We have changed the function m8260_cpm_dpalloc() used for DPRAM 
allocation in the linux source code. It was allocating memory from 
128Byte location to 8KByte location in DPRAM. But since QMC requires the 
lower 4KByte for channel specific parameters, we changed the function to 
allocate DPRAM from 4KByte location. Will this change lead to any 
problem for proper linux operation?

03. We are encountering a strange problem with scc4 parameter RAM. When 
the driver is coming up, its trying to initialize the SCC4 parameter RAM 
for QMC. In the location (immr + 0x8318), we are writing the value 
0x8320 but the value magically changes to 0x8300. We tried to write to 
the location using BDI and again the problem is seen. Is this a known 
problem with the processor?? This problem doesnot appear everytime. Is 
there any known cause for this problem?

Regards,
Robin
