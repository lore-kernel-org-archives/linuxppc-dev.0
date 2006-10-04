Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4F53167D4E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 05:33:49 +1000 (EST)
Message-ID: <45240C92.6010006@freescale.com>
Date: Wed, 04 Oct 2006 14:33:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add of_platform_device_scan().
References: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
	<200610040118.09416.arnd@arndb.de> <4523E214.5060404@freescale.com>
	<200610041837.47317.arnd@arndb.de>
In-Reply-To: <200610041837.47317.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 04 October 2006 18:32, Scott Wood wrote:
> 
>>What I'd really like (long-term, of course) is if platform_device and 
>>of_device were merged, with device tree support (or at least a means of 
>>passing on properties that *could* come from a device tree without 
>>special glue code that knows about each property) in arch-neutral code; 
>>the mechanism for discovering devices ideally shouldn't depend on the 
>>CPU's instruction set.
> 
> 
> My guess is that this won't happen, because other architectures
> normally don't describe their platform devices in a way that is
> anywhere near what we have on powerpc.

They wouldn't need to, unless they want to support a driver that 
requires it.  It would simply be an architecture-neutral mechanism for 
attaching a dynamic list of properties and OF-compatible matching 
criteria (or more generally the ability to match on any set of dynamic 
properties) to platform devices; the source of the platform data could 
choose to use it to represent an OF device tree, to supply a few 
properties needed by a specific driver, or not at all.

Ideally, users of static structure-based platform data would gradually 
migrate to dynamic properties, but there's a benefit to the integration 
even if they don't.  The main issue that I forsee being a problem is 
clashing with another standard for the naming and content of properties. 
  There could be tagging to indicate which standard is being followed by 
a given property, but that could lead to some ugliness in drivers that 
need to support more than one if the differences can't be easily 
abstracted by get-me-this-piece-of-information accessor functions (or by 
  code that generically converts properties from one standard to 
another, which is similar to what we've already got in fsl_soc.c, but 
hopefully less device-specific).

-Scott
