Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58CC5DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 02:34:04 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n53GWLNH015952
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 02:32:21 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n53GY47H471188
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 02:34:04 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n53GY3xW008687
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 02:34:03 +1000
Date: Wed, 3 Jun 2009 22:03:42 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver V
Message-ID: <20090603163342.GA5197@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,
	Please find a new patchset that addresses your comments and contains
the changes as listed below.

Changelog - ver V
------------------
(Ver I: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html) 
(Ver II: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072106.html)
(Ver III: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072387.html
(Ver IV: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072518.html
--------------

- Breakpoint requests from ptrace (for user-space) are designed to be one-shot
in PPC64. The patch contains changes to retain this behaviour by returning early
in hw_breakpoint_handler() [without re-initialising DABR] and unregistering the
user-space request in ptrace_triggered(). It is safe to make a
unregister_user_hw_breakpoint() call from the breakpoint exception context
[through ptrace_triggered()] without giving rise to circular locking-dependancy.
This is because there can be no kernel code running on the CPU (which received
the exception) with the same spinlock held.

- Minor change in 'type' member of 'struct arch_hw_breakpoint' from u8 to 'int'.

Kindly let me know if you think that the patchset is ready for upstream
acceptance.

Thanks,
K.Prasad
