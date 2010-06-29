Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 303D9B6EF0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:51:57 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5TGlfoR029700
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:47:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5TGpuB71425462
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:51:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5TGpuW3001220
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:51:56 +1000
Received: from in.ibm.com ([9.124.213.87])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o5TGpqZi001145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:51:55 +1000
Date: Tue, 29 Jun 2010 22:21:52 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 0/1] hw-breakpoint interfaces for BookE - ver II
Message-ID: <20100629165152.GA8586@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,
	Please find a new version of the patch that implements generic
hw-breakpoint interfaces for PowerPC BookIII E.

While there are several improvements over the previous version in terms
of code placement, support for ptrace and fixes for incorrect issues, the
patch remains compile-tested (only)(against 44x/iss476-smp_defconfig config)
and is yet to be tested on hardware (for functionality).
		
Changelog Version II
(Version I:linuxppc-dev message-id: 20100427164029.GA8303@in.ibm.com)
-------------------------------------------------------------------------
- ptrace requests (through PTRACE_SET_DEBUGREG and PTRACE_GET_DEBUGREG) are
  now supported.
- Changes in original arch/powerpc/kernel/hw_breakpoint.c have been percolated
  down to hw_breakpoint_booke.c (such as introduction of thread_change_pc(),
  arch_unregister_hw_breakpoint() and changes to hw_breakpoint_handler())
  along with some code re-arrangement (for brevity/clarity).

The usage of CONFIG (in this patch) option doesn't largely represent a
form that it would turn into after enabling the use of DVCs, DACs by non-ptrace
breakpoint requests. They should turn correct as versions of this patch progress.

Kindly let me know your comments.

Thanks,
K.Prasad
