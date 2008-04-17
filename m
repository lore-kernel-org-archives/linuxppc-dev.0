Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BD14DE202
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:00:01 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3HDxvl5098768
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 13:59:57 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3HDxvdj2093212
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 14:59:57 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3HDxurI029861
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 13:59:57 GMT
Message-ID: <48075805.2030602@linux.vnet.ibm.com>
Date: Thu, 17 Apr 2008 16:00:37 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 4 of 4] [KVM POWERPC] PowerPC 440 KVM
	implementation
References: <442f314cd08ea6addd39.1208406489@localhost.localdomain>
	<4807311D.3020402@qumranet.com> <4807324F.70202@qumranet.com>
In-Reply-To: <4807324F.70202@qumranet.com>
Content-Type: multipart/mixed; boundary="------------040208000503080501090909"
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Hollis Blanchard <hollisb@us.ibm.com>, kvm-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040208000503080501090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Avi Kivity wrote:
> Avi Kivity wrote:
>> Hollis Blanchard wrote:
>>> +config KVM
>>> + tristate "Kernel-based Virtual Machine (KVM) support"
>>> + depends on EXPERIMENTAL
>>> + select PREEMPT_NOTIFIERS
>>> + select ANON_INODES
>>> + ---help---
>>> + Support hosting virtualized guest machines. You will also
>>> + need to select one or more of the processor modules below.
>>> +
>>> + This module provides access to the hardware capabilities through
>>> + a character device node named /dev/kvm.
>>> +
>>> + To compile this as a module, choose M here: the module
>>> + will be called kvm.
>>> +
>>> + If unsure, say N.
>>
>> In my ignorance, I set KVM=m on a non-44x build, which then failed. 
>> This needs either to depend on 44x, or to be fixed to compile.
> 
> Setting 44x, I get
>> AS [M] arch/powerpc/kvm/booke_interrupts.o
>> arch/powerpc/kvm/booke_interrupts.S: Assembler messages:
>> arch/powerpc/kvm/booke_interrupts.S:351: Error: unsupported relocation 
>> against VCPU_HOST_TLB
>> arch/powerpc/kvm/booke_interrupts.S:352: Error: unsupported relocation 
>> against VCPU_SHADOW_TLB

Afaik we just don't support building kvm as module atm. So a simple and fast solution would be to change the Kconfig options from tristate to bool.
Additionally we still have some cross references between the code build on the two used symbols (KVM&KVM_BOOKE_HOST) which means that we need to ensure that if KVM if configured for powerpc we also select exactly one host implementation. To do so I changed the second option to a choice field which eventually has always selected one suboption.

To ensure that the only existent suboption we have atm can be selected we need the smallest commonality as dependency at the KVM config option which atm put "depends 44x" there.
We can change that once we support modules and/or separate selections.

A patch for that is attached, but I would like to wait for Hollis comments on that before you apply that.


> So further Kconfig restrictions are needed, or perhaps a patch. .config 
> attached.
> 
> 
[...]

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization

--------------040208000503080501090909
Content-Type: text/x-patch;
 name="fix_kvmppc_nomodule_build.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_kvmppc_nomodule_build.diff"

--- arch/powerpc/kvm/Kconfig.save	2008-04-17 15:21:54.000000000 +0200
+++ arch/powerpc/kvm/Kconfig	2008-04-17 15:58:52.000000000 +0200
@@ -15,8 +15,8 @@
 if VIRTUALIZATION
 
 config KVM
-	tristate "Kernel-based Virtual Machine (KVM) support"
-	depends on EXPERIMENTAL
+	bool "Kernel-based Virtual Machine (KVM) support"
+	depends on EXPERIMENTAL && 44x
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	---help---
@@ -31,13 +31,22 @@
 
 	  If unsure, say N.
 
+choice
+	prompt "KVM host PowerPC processor support"
+	depends on KVM && 44x
+	default KVM_BOOKE_HOST
+	help
+	  This option sets the Kind of PowerPC processor to virtualize.
+
 config KVM_BOOKE_HOST
-	tristate "KVM host support for Book E PowerPC processors"
+	bool "Book E"
 	depends on KVM && 44x
 	---help---
 	  Provides host support for KVM on Book E PowerPC processors. Currently
 	  this works on 440 processors only.
 
+endchoice
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION

--------------040208000503080501090909--
