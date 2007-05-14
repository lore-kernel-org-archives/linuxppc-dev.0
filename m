Return-Path: <stevewin@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0214DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 04:25:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4EIM6Gv026305
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 14:22:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EIPdeX119064
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 12:25:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EIPdFl024937
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 12:25:39 -0600
In-Reply-To: <200705141631.04546.g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Subject: Re: USB support for Bamboo/440EP (Yosemite/440EPx)
Message-ID: <OFC56C5EA1.CC32B615-ON872572DB.0063BF4F-852572DB.00653577@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Mon, 14 May 2007 14:25:38 -0400
Content-Type: text/plain; charset="US-ASCII"
Cc: g.jaeger@sysgo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gerhard Jaeger <g.jaeger@sysgo.com> wrote on 05/14/2007 10:31:04 AM:
> Hi Stephen, 
> 
> I also played with Bamboo and Yosemite USB and found out, that the OHCI
> ISR contains an assumption that makes the 440 OHCI implementation 
sometimes 
> stop when having a timeout condition. Find the following sequence @ 
function
> ohci_irq() (in file ohci-hcd.c) and disable the following code:
> 
>         if ((ohci->hcca->done_head != 0)
>                         && ! (hc32_to_cpup (ohci, 
&ohci->hcca->done_head)
>                                 & 0x01)) {
>                 ints =  OHCI_INTR_WDH;
>    }
> 
> This should make the USB host work reliably on the 440s.
> 
Thanks Gerhard.  This definitely makes things work better - I have had 
100% success in both the kernel and X recognizing the devices and having X 
boot with this update.

However, I am occasionally still having an issue after X comes up with the 
keyboard not working (mouse working fine).  Just to be clear - I only want 
to comment out the code you indicated above - not also any/either of the 
else/if clauses, correct?

So has this never been formally reported/patched?  Do you know also why 
the USB support has not been configured in the mainline kernel for these 
platforms - is it due to known existing issues? 
