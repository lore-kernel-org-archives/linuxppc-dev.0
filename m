Return-Path: <dbruce@ll.mit.edu>
Received: from ll.mit.edu (LLMAIL.LL.MIT.EDU [129.55.12.40])
	by ozlabs.org (Postfix) with ESMTP id AB49E67A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 06:38:28 +1100 (EST)
Received: (from smtp@localhost) by ll.mit.edu (8.12.10/8.8.8) id j2EJIsjN025453
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Mar 2005 14:18:54 -0500 (EST)
Message-ID: <4235E387.4000807@ll.mit.edu>
Date: Mon, 14 Mar 2005 14:18:31 -0500
From: David Bruce <dbruce@ll.mit.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re:problem opening I2C device on MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Look back into the February logs of this group that was having simular 
discussions.
In short:
a.) 2.6 has some problems with the I2C. You may have to port over 2.4 
i2c code. I don't know the specific details.
b.) you need an adapter interface to create your device(s) (/dev/i2c-0). 
See ./drivers/i2c/i2c-pm826.c. You should be able to use this untouched. 
It is part of the configuration in 2.4.x.
c.) The 2.4 version of i2c-algo-8260.c has a potential bug where all the 
__pa()'s need to be replaced by iopa().

I am using 2.4.24 of the ELDK and had problems with the i2c. Items b & c 
corrected them except that with "b" I had to load it *after* boot as a 
module. Don't know why but it works and have successfully used the i2c 
since.
-- 
David Bruce
MIT Lincoln Laboratory
244 Wood Street
Lexington, MA 02420
781.981.3863
mailto:dbruce@ll.mit.edu
