Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01DD4DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Dec 2008 03:09:35 +1100 (EST)
Message-ID: <49510D2A.4010906@freescale.com>
Date: Tue, 23 Dec 2008 10:09:14 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
References: <loom.20081219T062005-806@post.gmane.org>	<494BFE2B.2010103@freescale.com>
	<loom.20081223T003725-939@post.gmane.org>
In-Reply-To: <loom.20081223T003725-939@post.gmane.org>
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

Daniel Ng wrote:
> Scott Wood <scottwood <at> freescale.com> writes:
>> cuboot-824x is for 8240, 8245, and similar chips.  You want cuboot-pq2.
> 
> Hi Scott et al,
> 
> I seem to get further with the cuboot-824x file- with the cuboot-pq2 file 

Nonetheless, cuboot-pq2 is the correct one.

> the boot sequence doesn't even reach the 'zImage starting' stage. The machine 
> reboots just before it should be printing out 'zImage starting'. 

What does it print before it reboots?  Try disabling the PCI and 
localbus setup.

> Is there a way I can get more detailed debug to see what's happening?

printf(). :-)

> Do settings from bd_info struct override the settings from the DTS file?

Yes.

> Also, a lot of the settings passed from u-boot in our 2.6.14 environment are 
> plain wrong eg. wrong memory, wrong processor speed. In this case, the correct 
> settings are set elsewhere (for memory, it is a kernel parameter ie. mem=32M, 
> and the processor speed is set in the 2.6.14 'make menuconfig'). Therefore, 
> the machine still boots into Linux correctly. For 2.6.27, would these 
> incorrect settings be causing my problems?

Yes, if u-boot is providing junk, then you'll probably want to hack up 
the wrapper to ignore it.  Or just upgrade u-boot to one that works. :-)

-Scott
