Return-Path: <jimix@watson.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4076DDF49
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 22:48:18 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6RCm9Yh019014
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 08:48:09 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6RCmApw216794
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 08:48:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6RCm9c9013300
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 08:48:09 -0400
Received: from [9.12.247.74] ([9.12.247.74])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6RCm9Tc013295
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 08:48:09 -0400
Message-Id: <B6E6E232-5793-4BBB-BD82-95B19716ACE4@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: [PATCH] Fix powerpc64 build if CONFIG_EPOLL=n
Date: Sun, 27 Jul 2008 08:48:09 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Declate compat_sys_epoll_pwait as a conditional syscall like the rest  
of the epoll interfaces.
We could have put an #ifdef around the entry in include/asm-powerpc/ 
systbl.h, but IMHO this is ultimately correct patch.

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
---

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 5b9b467..0fea0ee 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -59,6 +59,7 @@ cond_syscall(sys_epoll_create);
  cond_syscall(sys_epoll_ctl);
  cond_syscall(sys_epoll_wait);
  cond_syscall(sys_epoll_pwait);
+cond_syscall(compat_sys_epoll_pwait);
  cond_syscall(sys_semget);
  cond_syscall(sys_semop);
  cond_syscall(sys_semtimedop);
