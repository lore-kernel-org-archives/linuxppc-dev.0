Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11951DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:11:43 +1000 (EST)
Message-ID: <48767AD1.9050708@freescale.com>
Date: Thu, 10 Jul 2008 16:10:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>	<48766E4D.5060607@freescale.com>
	<48767696.6090603@windriver.com> <48767636.3090906@freescale.com>
	<487679B1.3040900@freescale.com>
In-Reply-To: <487679B1.3040900@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> Scott Wood wrote:
>> Paul Gortmaker wrote:
>>> OK, so does that mean that the cuboot wrapper is explicitly
>>> not supported for all the 83xx, 85xx, and 86xx boards?
>>
>> No (except 86xx, which doesn't have cuboot, because it never existed 
>> in arch/ppc and thus there's no compatibility to maintain), it just 
>> means that chosen was never added to those dts files, and thus cuboot 
>> has no console output.
> 
> Also note that nothing stops the causal kernel booter

As opposed to the spontaneous kernel booter? :-)

> from _starting_ with an arch/powerpc/boot/dts/ file,
> adding a node to it, and using _that_.

The "casual" user shouldn't need to make any changes, especially for the 
kernel's own dts files to work with the kernel's own wrapper.

The decision on whether to put the chosen node in the device tree should 
be based on which version of u-boot it's more important to maintain 
compatibility with (for some platforms, no chosen-duplicating version of 
u-boot supported device trees on the platform), and what the 
consequences of each form of incompatibility are (e.g. no console output 
during the bootwrapper, versus no boot arguments or initrd in the kernel).

-Scott
