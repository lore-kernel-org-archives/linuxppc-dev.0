Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 61EADDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 00:46:26 +1000 (EST)
Message-ID: <49EF2E82.9080905@embeddedarm.com>
Date: Wed, 22 Apr 2009 07:49:38 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: FPGA IRQ design question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm working on a board based on the Yosemite AMCC 440EP. We have an FPGA 
connected via the PCI bus, and has an IRQ line connected directly to the 440EP. 
The FPGA implements two registers to indicate which core generated the 
interrupt. So now the question is from a design standpoint is it preferable to 
setup the IRQ as a single external IRQ then have each driver request this same 
IRQ. In each ISR the driver is responsible for checking the FPGA registers to 
see if the interrupt is intended for itself. Or would it be preferable to modify 
the lower level irq routines such that multiple software/virtual(not sure what 
the right term is here) irqs are created corresponding to the single external 
IRQ. Then abstract the details of the FPGA interrupt registers from each driver. 
Such that each driver request the proper software/virtual IRQ and requires no 
knowledge of the fpga irq registers. Any comments would be appreciated.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
