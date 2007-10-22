Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22F23DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 02:15:14 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Mon, 22 Oct 2007 20:12:20 +0400
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
	<E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
In-Reply-To: <E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710222012.20316.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 October 2007 17:24, Kumar Gala wrote:
> 
> On Oct 18, 2007, at 6:21 PM, Paul Mackerras wrote:
> 
> > Yuri Tikhonov writes:
> >
> >> The following patch adds support for 256KB PAGE_SIZE on ppc44x- 
> >> based boards.
> >> The applications to be run on the kernel with 256KB PAGE_SIZE have  
> >> to be
> >> built using the modified version of binutils, where the MAXPAGESIZE
> >> definition is set to 0x40000 (as opposite to standard 0x10000).
> >
> > Have you measured the performance using a 64kB page size?  If so, how
> > does it compare with the 256kB page size?
> 
> I was wondering about this as well?  Isn't this technically in  
> violation of the ABI?

 
 No it isn't the violation.

 As stated in "System V ABI. PowerPC processor supplement"
(on which the "Linux Standard Base Core Specification for PPC32"
is based): " ... Virtual addresses and file offsets for the PowerPC processor family 
segments are congruent modulo 64 Kbytes (0x10000) or larger powers of 2...".

 So, 256 Kbytes is just a larger case.

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
