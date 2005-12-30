Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8306368949
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Dec 2005 05:18:02 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D5FE4784-0908-4A8E-9231-D1741F5592DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 30 Dec 2005 12:17:56 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: powerpc.git broken for ARCH=ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

It looks like you broke ARCH=ppc builds:

arch/ppc/kernel/time.c: In function `wakeup_decrementer':
arch/ppc/kernel/time.c:125: warning: implicit declaration of function  
`last_jiffy_stamp'
arch/ppc/kernel/time.c:125: error: invalid lvalue in assignment
arch/ppc/kernel/time.c: In function `timer_interrupt':
arch/ppc/kernel/time.c:189: error: invalid lvalue in assignment
arch/ppc/kernel/time.c: In function `time_init':
arch/ppc/kernel/time.c:331: error: invalid lvalue in assignment

In asm-powerpc/hardirq.h you removed the defn of last_jiffy_stamp.   
Suggestions on what the right fix is for arch=ppc?

- kumar
