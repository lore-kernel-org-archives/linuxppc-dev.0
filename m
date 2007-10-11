Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14D5ADDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:23:06 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9B7MWia025104
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:32 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9B7MV0Y3731552
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:31 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9B7MVL9022744
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:31 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9B7MVg6022737
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:31 +1000
Received: from ubrain (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with SMTP id 9E7D273602
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:30 +1000 (EST)
Message-Id: <20071011071558.676463639@au1.ibm.com>
Date: Thu, 11 Oct 2007 17:15:58 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 0/2] add Altivec/VMX state to coredumps
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-- 
Here's the new and improved patch to add Altivec/VMX state into the coredump.

It's now two patches:
* the first patch makes the note type of the state dumped by
  elf_core_copy_task_xfpregs() a #define and adds the appropriate #defines so
  that archs that support SSE still have their note type as NT_PRXFPREG
* the second patch actually adds the Altivec/VMX state to the coredumps and
  uses a note type of NT_PPC_VMX that's #defined as 0x100. Thus SPE could use
  a note type of NT_PPC_SPE and 0x101, for example.

The second patch is essentially the same as the single patch that was posted on
2007-09-25, but with the addition of the new NT_PPC_VMX note type.
