Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FBD5DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 15:29:10 +1000 (EST)
In-Reply-To: <18118.13541.470351.661964@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<18117.22358.723442.148999@cargo.ozlabs.ibm.com>
	<D6CFE4FC-5112-450B-B13F-2DC40165EB71@kernel.crashing.org>
	<18118.13541.470351.661964@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FB356616-F3EE-403F-AC39-8FA932A0A881@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Date: Sat, 18 Aug 2007 00:30:59 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 6:53 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Its a regression in that the ULI M1575 doesn't really work properly
>> on some of these boards in certain situations.
>
> Well, "it doesn't work" isn't of itself a regression, a regression is
> "it used to work and now it doesn't".

Interesting, maybe I was grouping both of these together as things  
that could go in after the -rc1.  I was under the impression that bug  
fixes could also go in post -rc1.

> In any case the lateness x largeness product (LxL) of that patch is a
> bit too high.  Is there a simpler way to fix it that doesn't involve
> moving all that code around?

I'm not really sure how to accomplish that.  I could possibly  
duplicate the 'fixes' in each board port but that seems pointless and  
I doubt would reduce the code modifications amount any.

Most of this has to due with the kernel / firmware / device tree  
interface.  If we have a new firmware that modifies the memory map  
and requires changes to the device tree and kernel is that a fix?

I understand the concern related to the LxL.  I'd also say the set of  
users this effects is very small since its just the two boards.

I leave it up to you if you want to grab this patch or not for  
2.6.23.  If not please pull all these into your for-2.6.24 branch.

- k
