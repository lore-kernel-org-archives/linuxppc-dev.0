Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5143DDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:17:01 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4L7Gpci027102
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:46:51 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4L7Gprq565336
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:46:51 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4L7Gp0s003816
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:16:51 +1000
Date: Thu, 21 May 2009 12:46:50 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 0/6] PPC64: Hardware Breakpoint interfaces - ver III
Message-ID: <20090521071650.GA693@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,
        Please find a new patchset that includes suggestions from the community
and a few issues discovered during code inspection and testing. The changes are
as documented below.

Kindly let me know your comments on the same, in the absence of which I intend
to submit the patchset for upstream inclusion in the subsequent iteration.

Changelog - ver III
------------------
(Ver I: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html) 
(Ver II: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072106.html)
19th May 2009
--------------

- Patches are based on commit 08f16e060bf54bdc34f800ed8b5362cdeda75d8b of -tip
tree.

- The declarations in arch/powerpc/include/asm/hw_breakpoint.h are done only if
CONFIG_PPC64 is defined. This eliminates the need to conditionally include this
header file.

- load_debug_registers() is done in start_secondary() i.e. during CPU
initialisation.

- arch_check_va_<> routines in hw_breakpoint.c are now replaced with a much
simpler is_kernel_addr() check in arch_validate_hwbkpt_settings()

- Return code of hw_breakpoint_handler() when triggered due to Lazy debug
register switching is now changed to NOTIFY_STOP.

- The ptrace code no longer sets the TIF_DEBUG task flag as it is proposed to
be done in register_user_hw_breakpoint() routine.

- hw_breakpoint_handler() is now modified to use hbp_kernel_pos value to
  determine if the trigger was a user/kernel space address. The DAR register
  value is checked with the address stored in 'struct hw_breakpoint' to avoid
  handling of exceptions that belong to kprobe/Xmon.

Thanks,
K.Prasad
