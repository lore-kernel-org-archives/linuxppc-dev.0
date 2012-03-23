Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 640DFB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 09:18:37 +1100 (EST)
Message-ID: <1332541090.2882.14.camel@pasglop>
Subject: Re: Boot failure with next-20120208
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Date: Sat, 24 Mar 2012 09:18:10 +1100
In-Reply-To: <4F6CCDDC.5000802@linux.intel.com>
References: <20120212113805.c7e5d902c95a9d0f4037e12c@canb.auug.org.au>
 <16788.1329102254@neuling.org> <4F391BBA.5020506@linux.intel.com>
 <20120213120549.eab7e2b9.akpm@linux-foundation.org>
 <4F396FA9.90606@linux.intel.com>
 <20120323122244.132198e3.akpm@linux-foundation.org>
 <4F6CCDDC.5000802@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, gregkh@linuxfoundation.org,
 LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-23 at 12:24 -0700, Arjan van de Ven wrote:
> well yeah, PPC is throwing things in the spanner
> 
> we're now working on an x86-only patch with basically the same
> improvement, but done in a way that does not touch the other
> architectures
> 
> so by all means drop the patch

Or maybe make an arch flag to enable the behaviour ? I can have a look
at the problem & maybe even fix it next week (it's been under my radar
for some reason so far), but I know at least of a few places where we
have that sort of assumptions about the bringup of boot CPUs.

For example, on Apple G5s, we don't support real hotplug, so the hot
unplug path just puts them in a linux-controlled sleep loop. So the
early boot time bringup is different from the hotplug path. 

Among others, it needs access to things like i2c to synchronize the time
bases of the CPUs being brought up and we "release" that resource at the
end of the bringup.

So that needs fixing a way or another (and it's non trivial as other
drivers might try to get a lock on that i2c bus).

I'm sure I have a few other places with similar assumptions. And I
wouldn't be surprised if other architectures do as well :-)

So while your patch is a good / worthwhile idea, I think we need a bit
more time to sort things out before it can be applied.

(BTW. Arjan, can you send me privately your latest version of that
patch, for some reason I don't seem to be able to put my hand on it).

Cheers,
Ben.
