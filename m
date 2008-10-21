Return-Path: <wiseker@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 962C1DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 01:09:25 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so393377yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 07:09:23 -0700 (PDT)
Message-ID: <3ec3b8250810210709g5fca6bbdtc9346cb6bc2c4979@mail.gmail.com>
Date: Tue, 21 Oct 2008 22:09:23 +0800
From: wiseker <wiseker@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: [HELP]: Question about MPC8321E PCI configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, every one.

Now I want to port MPC8321E PCI support to linux2.4.20 from
linux2.6.20. I have read the patch
http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg13903.html,
but some problems also occured.

When the linux kernel PCI subsystem initialize, it can probe 2 PCI devices.
Found 00:00 [1957/00a6] 000b20 00
Found 00:50 [14e4/b624] 000280 00

The first is the powerpc CPU (class PCI_CLASS_PROCESSOR_POWERPC,
mpc8321e), and the second is BCM56624 chip. (In my opinion, the first
one should be PCI_CLASS_BRIDGE_HOST, is this correct?)

When the kernel assign resources to each device, a problem occured,
PCI: Failed to allocate resource 2(0-7fffffff) for 00:00.0
PCI: Failed to allocate resource 4(0-ffffffff) for 00:00.0
code: pcibios_assign_resources->pci_assign_resource

and the code ignores the host bridge device:
		if (!class || class == PCI_CLASS_BRIDGE_HOST)
			continue;

so it strength my idea that the device gives a wrong class (should be
PCI_CLASS_BRIDGE_HOST, not PCI_CLASS_PROCESSOR_POWERPC).

Can you tell me why this happen? Should I do some extra configurations?

Any ideas or suggestions is welcome, thank you!!!

--
wiseker
