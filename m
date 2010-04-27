Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1121BB7DBC
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:40:38 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3RFmKwR018935
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 21:18:20 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3RGeYmQ3191016
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 22:10:34 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3RGeXJM014953
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:40:34 +1000
Date: Tue, 27 Apr 2010 22:10:29 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [RFC Patch 0/1] [hw-bkpt BookE] hw-breakpoint interfaces for BookE
	- ver I
Message-ID: <20100427164029.GA8303@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,
	Please find a patch that implements hardware-breakpoint interfaces for
BookE processors. The patches are under continuous development and are sent
to receive early comments. For the moment, they are (only) compile tested (with
ppc64e_defconfig), further testing will accompany the ongoing development.

A few notes about the patchset, as below:
- The patch is designed with reference to BookIII-E type processors
  specification (having two DAC/DVC registers).
- Instruction breakpoint requests are not implemented through the generic
  breakpoint interfaces. Such requests are still possible for user-space through 
  ptrace.
- Breakpoint exceptions are designed to 'trigger-after-execute', although the
  processors raise the exception before instruction execution. To achieve this,
  the causative insruction is single-stepped over and the breakpoint handler is 
  invoked in the ICMP exception handler.
- The patches are dependant on the recent submissions (not yet integrated into
  mainline) that bring support for hw-breakpoint weight (patchset from Frederic
  Weisbecker LKML ref:1271999639-23605-1-git-send-regression-fweisbec@gmail.com)
  and PPC64 hw-breakpoint support (linuxppc-dev
  ref:20100414034340.GA6571@in.ibm.com).

Here are a few items identified to work upon in the successive versions.
TO DO
------
- Modify ptrace requests to use the generic hw-breakpoint interfaces 
 (PTRACE_<GET><SET>_DEBUGREG, PTRACE_SETHWDEBUG)
- Explore intergration of BookE and BookS code intergration 
 (hw_breakpoint.c and hw_breakpoint_booke.c) 
- Code clean-up and reduction.

Kindly let me know about comments/suggestions, if any.

Thank You,
K.Prasad
