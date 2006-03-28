Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 2CDE067A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 01:39:31 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id E6E7BFB863
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 16:39:28 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id D2EF9FB863
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 16:39:28 +0200 (CEST)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id 0952F20E697
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 16:39:28 +0200 (CEST)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: pci-x
Date: Tue, 28 Mar 2006 16:51:52 +0200
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<24661B8C-C4DF-4D9C-8F4A-F2E6600AFFE2@kernel.crashing.org>
	<200603241607.35267.carlos.mitidieri@sysgo.com>
In-Reply-To: <200603241607.35267.carlos.mitidieri@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603281651.53196.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On Friday 24 March 2006 15:53, Kumar Gala wrote:
> > That seems like a driver problem.  Does lspci show your devices after
> > you boot?  Also, what kernel ver are you using?
>
> No, the device behind the bridge is not recognized, although the bridge
> itself is. I am using kernel 2.6.15.

I am trying to use a PCI-X bridge (Intel 31154) on a mpc8540ads running kernel 
2.6.15.  A USB controller is behind the bridge. 

When the mpc8540ads is booted with the PCI-X switch disabled, the device 
behind the bridge is detected (and actually works), and the following 
messages are printed:

PCI: bridge rsrc 0..ffffff (100), parent c01ce78c
PCI: bridge rsrc 80000000..9fffffff (200), parent c01ce770
PCI: bridge rsrc fff000..ffffff (101), parent c0217038
PCI: bridge rsrc 9ff00000..9fffffff (200), parent c0217054
PCI: bridge rsrc 9fe00000..9fefffff (1201), parent c0217054
PCI:0000:01:06.0: Resource 0: 9ffff000-9fffffff (f=200)
PCI:0000:01:06.0: Resource 1: 9ffe0000-9ffeffff (f=1208)
PCI:0000:01:06.0: Resource 2: 9ffd0000-9ffdffff (f=200)
 
The last three lines are for the usb controller.
On the other hand, if the PCI-X is enabled, the usb controller is not detected 
anymore and the messages become:

PCI: bridge rsrc 0..ffffff (100), parent c01ce78c
PCI: bridge rsrc 80000000..9fffffff (200), parent c01ce770
PCI: bridge rsrc 0..fff (101), parent c0217038
PCI: bridge rsrc 0..fffff (200), parent c0217054
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: bridge 1 resource 1 moved to 9ff00000..9fffffff
PCI: bridge rsrc 0..fffff (1201), parent c0217054
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to 9fe00000..9fefffff

In the 3rd and 4th lines, the resource addresses are different for the two 
runs.  What could be the reason?

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
