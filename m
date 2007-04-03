Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (uncle.computing.dundee.ac.uk
	[134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EE28DE040
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Apr 2007 23:26:04 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l33D9m0T004326
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Apr 2007 14:09:49 +0100
Message-ID: <46125216.2080903@computing.dundee.ac.uk>
Date: Tue, 03 Apr 2007 14:09:42 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Using Linux 2.6.19 with Xilinx ML405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I am attempting to get a 2.6.19 kernel running on an ML405.  In the 
spirit of walking before I start to run, I have setup a very simple 
system with a 10/100 MAC, a UARTlite and the SystemACE controller (other 
than that, my EDK project has the DDR RAM,  some BRAM, an interrupt 
controller and the usual gubbins to get a system to work).  I am having 
some serious issues just getting the thing to compile so I was hoping to 
pick the brains of this list.  I would appreciate any tips on where I am 
going wrong.

First thing I did was to patch the kernel with the BSP from my EDK 
project (maybe this is my first mistake).  Several files #include 
config.h - I changed this to autoconf.h.  The ocp_def structure 
definition was being ignored because CONFIG_PPC_OCP was not defined - I 
altered some Kconfig files to ensure that when and an ML403 is selected 
XILINX_OCP is defined, and when that is defined PPC_OCP is also 
defined.  That solved that problem but left me with a missing definition 
for ppc_sys_platform_devices which was not present in virtex.c.  I added 
one but am a bit stuck as to what this should contain.  Another one I 
have seen lists a UART (which xilinx_ml403.c seems to depend upon).  But 
this is for a 8250-type UART.  How can I configure this for a UARTlite?  
Do I need to add an entry for the SystemACE?  I have already added an 
entry for the EMAC.

Any hints/experience would be gratefully received.

TIA,
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
