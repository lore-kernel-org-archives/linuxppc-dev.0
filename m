Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C480ADDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 02:10:42 +1000 (EST)
Message-ID: <48DBB402.8090402@ovro.caltech.edu>
Date: Thu, 25 Sep 2008 08:53:38 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: How do I access nvRAM from user space?
References: <OFFC64870C.57753273-ON882574CF.001088E7-882574CF.001228E4@selinc.com>
In-Reply-To: <OFFC64870C.57753273-ON882574CF.001088E7-882574CF.001228E4@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bruce,

> Sorry for the dumb question, I just can figure out the right google search 
> to find what I'm trying to do.  I'm running 2.6.27-rc4 on an mpc8347 with 
> a 32KiB nvSRAM (Cypress CY14B256L) on the local bus.  We just want to be 
> able to access this memory from user space seperately from "main" memory. 
> We've got a process that needs to be able to remember info through power 
> cycles.  Can anyone point me to an article or some code snippet that does 
> something like this so I can sink my teeth into it?

Assuming your bootloader sets up the local bus access windows
(physical address of the SRAM) and timing so that you can
read/write to the SRAM, then once Linux boots, you should be
able to just use /dev/mem as you would to access any other
device registers at a specific address.

Cheers,
Dave
