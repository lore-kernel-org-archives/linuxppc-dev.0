Return-Path: <kylo@veriwave.com>
Received: from cia.veriwave.com (mail.veriwave.com [198.107.59.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A55267AC7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 05:29:25 +1000 (EST)
Received: from [192.168.100.42] (ion13.veriwave.com [192.168.100.42])
	(authenticated bits=0)
	by cia.veriwave.com (8.12.8/8.12.8) with ESMTP id j3CJLIGT029039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Apr 2005 12:21:19 -0700
Message-ID: <425C1FAE.1000602@veriwave.com>
Date: Tue, 12 Apr 2005 12:21:18 -0700
From: Kylo Ginsberg <kylo@veriwave.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: bdi2000 + mpc8560ads, very early breakpoints
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm running a bdi2000 (with mpc85xx-gdb f/w 1.03) with a mpc8560ads 
target, and I'm trying to set breakpoints early on in linux startup (in 
the head_e500.S code that sets up tlb's).   I'm setting the breakpoints 
from within the bdi telnet interface.

I can:
--succesfully hit a breakpoint set up to any instruction <= the address 
of the first 'tlbwe'.
--single step (with the bdi "TI" command) past that 'tlbwe' as far as 
I've cared to try

I cannot:
--hit a breakpoint once the first 'tlbwe' has executed.  If I attempt to 
do so, linux startup doesn't proceed, I lose further communication with 
the target and the BDI claims "COP Freeze" and I have to reset the target.

Btw, the 'tlbwe' in question marks invalid the first tlb1 entry setup by 
u-boot, which pointed at flash address space.  Code is running out of 
ram at this point.

I'm probably missing something very basic here.  Any ideas?

Thanks,
Kylo
