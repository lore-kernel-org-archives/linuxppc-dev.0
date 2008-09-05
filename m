Return-Path: <dbeamonte@telnet-ri.es>
Received: from smtp242.efor.es (leela.efor.es [195.55.174.242])
	by ozlabs.org (Postfix) with ESMTP id 20D99DDF33
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 17:29:16 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by leela.efor.es (Postfix) with ESMTP id C96DE15F6B3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 09:20:49 +0200 (CEST)
Received: from [192.168.200.117] (unknown [213.0.25.185])
	by leela.efor.es (Postfix) with ESMTP id A03F415F6A3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 09:20:45 +0200 (CEST)
Message-ID: <48C0DD6F.8070205@telnet-ri.es>
Date: Fri, 05 Sep 2008 09:19:11 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Host USB issue on MPC8272
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to use USB host controller in an MPC8272. My board is based 
on ADS8272 with few modifications: FLASH and SDRAM models are different 
and several GPIOs and interrupts are not connected the same way.

The driver we are using is CPM2USB from sourceforge with a 2.6.21.5 
kernel version.

With my ADS8272 board it works quite fine, but with our board, the 
processor hangs when it starts sending data to the device.

This issue seems to be related to one problem that we have always had. 
We can't configure buffers of SMCs, SCCs, etc, to be in SDRAM, because 
the processor hangs. We always have to configure buffers in DPRAM. In 
other drivers this has not been a problem, because the buffer size is 
not very large, so we can allocate it in DPRAM, but for this one, the 
buffer size is 0x8000 (32Kb) which exceeds DPRAM size.

Has anybody had the same problem? Can it be an USB specific problem or a 
general one?

Thanks,

David
