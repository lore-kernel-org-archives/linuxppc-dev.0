Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0ED172C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:17:48 +1000 (EST)
Message-ID: <1371514650.21896.160.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 18 Jun 2013 10:17:30 +1000
In-Reply-To: <1371513683.9073.6@snotra>
References: <1371513683.9073.6@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-17 at 19:01 -0500, Scott Wood wrote:
> I really doubt the exception scratch registers need to be saved --  
> we're not trying to restore into the middle of an exception  
> prolog/epilog.
> 
> book3s has the PACA as well and they don't save it.  Don't we rely on  
> things like boot-time memory allocations happening in the same place  
> when we resume?  extlb is part of the PACA, so the same applies.

I doubt we seriously tested hibernation :-) The PACA SPR should
definitely be saved/restored.

> Granted, this isn't performance critical so it may seem better to  
> save/restore just in case, but there's value in not unnecessarily  
> deviating from what book3s does.

Cheers,
Ben.
