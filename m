Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2165CDDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 02:40:09 +1100 (EST)
Message-ID: <47BC438B.60605@mock.com>
Date: Wed, 20 Feb 2008 07:13:15 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 linuxppc-embedded@ozlabs.org
Subject: Re: Sample driver
References: <15582059.post@talk.nabble.com>
	<20080220060653.7593ffa9@zod.rchland.ibm.com>
In-Reply-To: <20080220060653.7593ffa9@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Silwer star <fariyaf@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
>> Does anyone have sample drivers in Linux for the EBC interface for PPC405Ex?
>> I would be thankful if someone could put in a sample code here. 
> 
> Linux typically doesn't touch the EBC itself.  That is normally set up
> by firmware such as U-Boot and Linux uses it as-is.
> 

True, but there's always a lot of ways to do it.  Here's an example that 
might help you get started configuring the EBC from Linux.  Here's a 
device driver directory from a recent 440GX project:
 
http://www.mock.com/wsvn/listing.php?repname=mock.pdev&path=%2Ftrunk%2Fsw%2Fdriver%2F#_trunk_sw_driver_

You might look at pdev-gxctl.c.  It is a simple module that sets up the 
EBC address space for two sets of address ranges with 16-bit data paths. 
  These are for simple register read/writes to control some FPGAs. 
Pdev-gxctl provides an mmap() interface to /dev/xxx so user code can 
easily access the FPGA registers mapped onto the EBC.  The difference 
for the 405Ex should be pretty small.

jeff
