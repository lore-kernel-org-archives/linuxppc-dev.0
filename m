Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0198ADDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 05:23:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2TJNKYl020223
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Mar 2007 15:23:20 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2TJNKVs095418
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Mar 2007 13:23:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2TJNK2G016331
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Mar 2007 13:23:20 -0600
Subject: Re: Try to Disable PPC Interrupt
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <38067FD3-F201-4373-A067-CFED1589D6C3@kernel.crashing.org>
References: <175002.60794.qm@web15611.mail.cnb.yahoo.com>
	<38067FD3-F201-4373-A067-CFED1589D6C3@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 14:23:11 -0500
Message-Id: <1175196191.7553.140.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-29 at 13:41 -0500, Kumar Gala wrote:
> > It seems the 16th bit (EE) has been set to 0, but what should I do  
> > to make sure whether the external interrupt is disabled or not?  
> > Thank you very much.
> 
> What exactly are you asking?  If MSR[EE] = 0, interrupts are disabled.

Since you're on a 405, you can actually test this from within your code
still.  Use the SRS bits in the UICs to generate a spurious interrupt at
the UIC level for something that is currently enabled in the ER
register.  If you still get an interrupt at the CPU with MSR[EE] == 0,
then you've found a very odd bug indeed.

But as Kumar says, if MSR[EE] == 0, external interrupts are disabled.
Of course, that doesn't mean that debug, machine check, or critical
interrupts are.

(How to use the SRS bits in the UICs is an exercise left up to the
reader.)

josh
