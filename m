Return-Path: <news@alea.gnuu.de>
Received: from uucp.gnuu.de (banki.eumelnet.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id BF8FADDE16
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 09:52:53 +1100 (EST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>) id 1Its4g-0005Ax-5V
	for linuxppc-dev@ozlabs.org; Sun, 18 Nov 2007 22:53:06 +0100
To: linuxppc-dev@ozlabs.org
From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: 2.6.24-rc3: High CPU load -- hardware interrupts
Date: Sun, 18 Nov 2007 21:53:06 +0000 (UTC)
Message-ID: <slrnfk1d21.229.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@alea.gnuu.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've installed the new kernel version and now suspend to RAM works. But I
saw that the CPU load is everytime 50% due to hardware interrupts. Is
this a known bug?

top - 22:51:19 up 21:58,  8 users,  load average: 0.36, 0.39, 0.40
Tasks:  66 total,   4 running,  62 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.7%us,  0.5%sy, 11.2%ni, 27.0%id,  0.0%wa, 60.6%hi,  0.0%si,  0.0%st

% diff <(cat /proc/interrupts) <(sleep 2; cat /proc/interrupts)
--- /proc/self/fd/11    2007-11-18 13:02:25.204839099 +0100
+++ /proc/self/fd/13    2007-11-18 13:02:25.228832847 +0100
@@ -1,16 +1,16 @@
            CPU0       
  21:          1   MPIC 1    Edge      PMac Output
  24:         68   MPIC 1    Level     ide1
- 25:    1337463   MPIC 1    Level     VIA-PMU
+ 25:    1337690   MPIC 1    Level     VIA-PMU
  26:        378   MPIC 1    Level     keywest i2c
  29:          1   MPIC 1    Level     ohci_hcd:usb2
  30:          1   MPIC 1    Edge      PMac Input
  39:     249347   MPIC 1    Level     ide0
  40:          3   MPIC 1    Level     ohci1394
  41:       3454   MPIC 1    Level     eth0
- 42:      30782   MPIC 1    Level     keywest i2c
- 47:      22021   MPIC 1    Level     GPIO1 ADB
- 48:      23892   MPIC 1    Level     radeon@pci:0000:00:10.0
+ 42:      30800   MPIC 1    Level     keywest i2c
+ 47:      22049   MPIC 1    Level     GPIO1 ADB
+ 48:      24014   MPIC 1    Level     radeon@pci:0000:00:10.0
  61:          0   MPIC 1    Edge      Sound Headphone Detection
  63:      94237   MPIC 1    Level     ehci_hcd:usb1, ohci_hcd:usb3, ohci_hcd:usb4
 BAD:          0

% cat /proc/cpuinfo
processor	: 0
cpu		: 7455, altivec supported
clock		: 798.720000MHz
revision	: 0.3 (pvr 8001 0303)
bogomips	: 48.41
timebase	: 18432000
platform	: PowerMac
machine		: PowerBook6,3
motherboard	: PowerBook6,3 MacRISC3 Power Macintosh
detected as	: 287 (iBook G4)
pmac flags	: 0000001b
L2 cache	: 256K unified
pmac-generation	: NewWorld

% uname -a
Linux ibook 2.6.24-rc3 #1 Sat Nov 17 16:06:21 CET 2007 ppc GNU/Linux

Bye, Jörg.
-- 
Es liegt in der Natur des Menschen, vernünftig zu denken und
unlogisch zu handeln! Das Gesagte ist nicht das Gemeinte und das Gehörte
nicht das Verstandene!
