Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D97DDDF28
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Dec 2008 07:04:10 +1100 (EST)
Message-ID: <494BFE2B.2010103@freescale.com>
Date: Fri, 19 Dec 2008 14:03:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
References: <loom.20081219T062005-806@post.gmane.org>
In-Reply-To: <loom.20081219T062005-806@post.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> We are migrating our PowerPC 8272-based board from 2.6.14 to 2.6.27.
> 
> One of the big changes is the need for a Device Tree for bootup.
> 
> So far, my bootup looks like the below (using u-boot).
> 
> I am just using arch/powerpc/boot/cuboot-824x.c 

cuboot-824x is for 8240, 8245, and similar chips.  You want cuboot-pq2.

> When I change the settings in mpc8272ads.dts and do a fresh recompile, the 
> settings do not change. However, if I use another cuboot*.c file, I get a 
> different set of printed settings eg. 2 ethernet ports instead of 1. This is 
> fine, but I don't see where in the cuboot*.c file these settings are 
> specified. Can someone suggest where these might be?

The cuboot file defines things like TARGET_CPM2 or TARGET_824x, which 
influences the compilation of the bd_t struct.  It's messy, which is why 
we use device trees now. :-)

-Scott
