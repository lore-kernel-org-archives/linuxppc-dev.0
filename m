Return-Path: <adam.kent@geckoaudio.com>
Received: from mail.opentransfer.com (mail2.opentransfer.com [69.49.238.3])
	by ozlabs.org (Postfix) with SMTP id 27FBA2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 18:42:39 +1100 (EST)
Message-ID: <41AC2253.20403@geckoaudio.com>
Date: Tue, 30 Nov 2004 18:33:39 +1100
From: Adam Kent <adam.kent@geckoaudio.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC8272ADS - devices on PCI bus 'freezing' board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am working on a project involving an MPC8272ADS development board 
with a MPC8247 processor, and am experiencing some issues with the PCI 
bus.

The problem is basically that generating traffic flow over an Ethernet 
card connected via the PCI bus on the board results in a board 
'freeze'.  Specifically, flooding another host on the network with 
ICMP ping packets will reproduce the problem.  This happens after a 
variable amount of time, anywhere from around 5 seconds to a few 
minutes of network activity.  It will crash even faster if the other 
host also pings the development board at the same time.  The freeze 
results in the board becoming totally unresponsive to any connections 
over the standard board Ethernet ports or further communication over 
the default serial console.  The board's "run" LED (LD18) also becomes 
permanently lit, indicating an infinite loop of some kind.

Details of setup:
- Using the monolithic Linux kernel image (2.4.26) provided by 
Arabella, a company that provides a free board support package for 
this board, and the standard Arabella-provided board file system 
mounted over NFS.
- A stock-standard PCI Ethernet card based on the RTL8139 chip set.
- Standard Linux kernel driver for the PCI Ethernet card (8139too) 
built using the Linux source tree provided by Arabella, and inserted 
as a module into the running kernel.
- A simple local network setup between another host running Linux, via 
a crossover CAT5 cable.

Has anyone experienced similar problems with the PCI bus on the 
MPC8272ADS?  More broadly, what kernel sources are people using on 
this board to use PCI-based devices?

We are also trying to get the latest linuxppc-2.4.28 kernel 
(downloaded yesterday from ppc.bkbits.net) running, but it seems that 
PCI support is not actually included in the standard kernel code for 
this board; it seems that the PCI support code is something that 
Arabella has specifically added to their kernel tree.

Thanks in advance for any help anyone can offer,

Adam Kent
Gecko Audio
