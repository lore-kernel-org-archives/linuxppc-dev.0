Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2362D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Nov 2004 12:01:00 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by 127.0.0.1 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 2 Nov 2004 00:54:13 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26888-05 for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Nov 2004 03:54:12 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 2 Nov 2004 03:54:39 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411020354.39610.vova-ks@yandex.ru>
Subject: Problem with user-space programs on 405GP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All !
I'm trying to run linux (2.4.22) on embedded PowerPC (405GP). It boots nice,
but when it tries to execute /sbin/init it hangs. Last console messages
are:

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init 4k prep

I've tried to replace /sbin/init by my own executable - it's definitely have 
not been executed.
I've traced it to the "last point" in kernel-mode (instruction rfi in file 
arch/ppc/kernel/entry.S:389). Before this point everything is all right. But 
after this instruction kernel just hangs.
After this sysrq-t prints that process init are running at c0007190 (this is 
in the arch_kernel_thread).
sysrq-p does not print any registers, just the line "SysRq : Show Regs".

Could someone give me any tips how to fix this trouble ?

-- 
         Vladimir
