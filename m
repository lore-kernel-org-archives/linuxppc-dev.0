Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1038767A44
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 02:24:25 +1000 (EST)
Date: Thu, 22 Jun 2006 09:23:58 -0700
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
Message-ID: <20060622162358.GA13300@pb15.lixom.net>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
	<17561.56593.481580.556093@cargo.ozlabs.ibm.com>
	<C468730C-7E39-4B17-869D-CB2BA802A709@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C468730C-7E39-4B17-869D-CB2BA802A709@watson.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2006 at 10:35:28PM -0400, Jimi Xenidis wrote:
> 
> On Jun 21, 2006, at 7:58 PM, Paul Mackerras wrote:
> 
> > Jimi Xenidis writes:
> >
> >> The following patch avoids accessing Hypervisor privilege HID
> >> registers when running on a Hypervisor (MSR[HV]=0).
> >
> > Why?  Aren't the writes defined to be no-ops when not in hypervisor
> > mode?
> 
> The write are no-ops but look at the instructions required to be  
> around the write for some of them.
> I believe read may have performance issues as well.

Are you aware that this code runs only once per processor during
boot (and/or during cpu hotplug)? A few extra cycles there won't kill
anyone.

That being said, not touching the registers makes sense, but I don't buy
the performance motivation. :-)

> I juts think its good practice and as Xell and newer processes come  
> along we may want to start using the PACA(?) rather then peeking at  
> the msr all the time.

PACA means it's a mfspr + dependent load + test instead of mfmsr + mask,
right? It'd need benchmarking on several processors to show if it's
better or not.


-Olof
