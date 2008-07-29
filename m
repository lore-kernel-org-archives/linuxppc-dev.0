Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 7AD00DE059
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 02:33:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KNs89-0007Nu-VV
	for linuxppc-embedded@ozlabs.org; Tue, 29 Jul 2008 09:32:57 -0700
Message-ID: <18716235.post@talk.nabble.com>
Date: Tue, 29 Jul 2008 09:32:57 -0700 (PDT)
From: Tachwali <ytachwali@signalogic.com>
To: linuxppc-embedded@ozlabs.org
Subject: Read but not write on a PCI bus!
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I am facing a problem in writing to PMC module on cPCI board through local
PCI bus. The cPCI board is equipped with an mpc7447/7448 powerpc processor
as well as a Marvell system controller (mv64462). The board is working on
Gentoo Linux (kernel version 2.6.9 built using arch/ppc). 

I can read registers on a PMC module via local PCI interface, but we can't
write to any registers. I am wondering about the possible causes of such
behaviour. I need to mention that:
1- the same PMC module and driver works Ok on many x86 based systems.  
2- The PCI config space seems to be OK since the PMC module can be detected
by scanpci Linux command. The PMC module registers are in Bar0 mem space
(BASE0     0x23ffff88  addr 0x23ffff80  MEM PREFETCHABLE)
3- I checked MV64462 PCI config registers carefully, and the "write protect"
and "access protect" bits in these registers are not set.
4- I have tried another debugging utility which does a basic read/write to
memory and this utility experience the same problem as our driver (it can
only read the address space of the PCI bus but cannot write to it).

I am wondering if "posted writes" option in MV64462 can cause this problem.
Did anybody encounter any problem with this option or have any hints on the
possible causes of blocking writes to the PCI bus?
 
Thank you in advance for your help!

-- 
View this message in context: http://www.nabble.com/Read-but-not-write-on-a-PCI-bus%21-tp18716235p18716235.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
