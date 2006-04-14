Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DE8E0679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 18:48:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 7A94029ED3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 10:47:14 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18557-08 for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 10:47:13 +0200 (CEST)
Received: from archvile (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 937A729EC9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 10:47:13 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Trouble with 2.6.16 on ppc8xx ?
Date: Fri, 14 Apr 2006 10:50:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604141050.56757.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I just cg-update'd to the HEAD of the denx 2.6.x kernel tree (2.6.16 as 
released).
Our board-support stuff was succesfully moved along from 2.6.14 (when 
everything but the SCC3 and SCC4 uarts worked just fine).
I compiled a kernel without any special drivers, just console on ttyCPM0, but 
after "Uncompressing Kernel Image ... OK" there is no more output and no 
further activity on ethernet (it should boot from nfs-root) or any other 
device.

After "cg-seek DENX-v2.6.15; make clean uImage", it works again (everything 
seems fine, system boots).

Our board is based on a MPC852T and until now we used "MPC86X" as the 
BOARD_CHIP_NAME and it worked just fine with 2.6.14 and 2.6.15, but not with 
2.6.16 as described above.

When doing "cg-diff" and carfully examining it's output, I can only see our 
board-support stuff (not very much, not very special) and some custom drivers 
that are disabled anyway.

Any clue about where to start looking?

I didn't find any suspicious changes in arch/ppc/mm, arch/ppc/syslib and 
arch/ppc/kernel. Neither in drivers/serial/cpm_uart.

Which change from 2.6.15 to 2.6.16 could have broken 8xx support for us?

Is there perhaps a known issue with 2.6.16 and ppc8xx I am unaware of?

Greetings,

-- 
David Jander
