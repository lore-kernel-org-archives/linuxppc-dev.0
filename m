Return-Path: <dbeamonte@telnet-ri.es>
Received: from smtp242.efor.es (leela.efor.es [195.55.174.242])
	by ozlabs.org (Postfix) with ESMTP id 33A2EDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Sep 2008 01:36:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by leela.efor.es (Postfix) with ESMTP id 8D4C515F710
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 17:36:42 +0200 (CEST)
Received: from [192.168.200.117] (unknown [213.0.25.185])
	by leela.efor.es (Postfix) with ESMTP id 5C14115F6D9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 17:36:40 +0200 (CEST)
Message-ID: <48DD0169.7090709@telnet-ri.es>
Date: Fri, 26 Sep 2008 17:36:09 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Interrupts get disabled on USB access on MPC8272
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

I'm trying to make USB driver work on my MPC8272 with kernel 2.6.21.

The driver detects properly the root hub (the embedded controller), but 
when it tries to communicate with a device, the system seems to hang.

I have debugged the kernel and what I can see is that, once the 
processor tries to send a buffer of the USB controller, interrupts get 
disabled. And so, there is no ethernet, serial port, or whatever way of 
communication to the processor. With my debugger I can see that the 
kernel keeps running and executing cpu_idle() and so on. Furtheremore, 
jiffies increase, but no other interrupts occur.

Has anyone experienced a problem like this?

It seems to happen when buffers try to access external memory. Can it be 
related to bus arbitration?

Regards,

David
