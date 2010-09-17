Return-Path: <chris.friesen@genband.com>
Received: from exprod7og124.obsmtp.com (exprod7og124.obsmtp.com [64.18.2.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7159B70B8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 16:36:32 +1000 (EST)
Message-ID: <4C930C55.5030008@genband.com>
Date: Fri, 17 Sep 2010 00:36:05 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux support for freescale e5500 core?
References: <4C9278CD.10607@genband.com>	
	<20100916163911.6255d359@schlenkerla.am.freescale.net>	
	<4C928FC5.9050700@genband.com> <1284674628.30449.98.camel@pasglop>	
	<4C92998C.7000903@nortel.com> <1284681832.30449.101.camel@pasglop>	
	<7EDBB1DD-BB9D-417D-8F4E-B9D5D9E030EF@kernel.crashing.org>
	<1284701585.30449.102.camel@pasglop>
In-Reply-To: <1284701585.30449.102.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Scott Wood <scottwood@freescale.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2010 11:33 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2010-09-17 at 00:17 -0500, Kumar Gala wrote:
>> Not sure how the 970 bit worked, but this seems a bit problematic for
>> switching between kernel and application for how we do this on
>> e500mc/e5500.  We'd have to touch the control bit on every exception
>> path which seems ugly to me.
> 
> Unless the kernel uses dcbzl (feature fixup replacement ?)
> 
> In that case it's on context switch only.

This is basically what we did.  Kernel and system libraries (glibc and
friends) always use dcbzl, process flag indicates compatibility, touch
the control bit on task context switch if the prev and next processes
have different compatibility modes.

On the 970 you have to invalidate the entire icache whenever you change
the control bit.  This is a pain involving a loop that calls icbi on 512
cachelines.

Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
