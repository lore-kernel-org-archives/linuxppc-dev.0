Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 964D32C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 20:20:04 +1100 (EST)
Date: Wed, 19 Feb 2014 10:19:59 +0100
From: Michal Hocko <mhocko@suse.cz>
To: David Rientjes <rientjes@google.com>
Subject: Re: ppc: RECLAIM_DISTANCE 10?
Message-ID: <20140219091959.GD14783@dhcp22.suse.cz>
References: <20140218090658.GA28130@dhcp22.suse.cz>
 <alpine.DEB.2.02.1402181424490.20772@chino.kir.corp.google.com>
 <20140219081644.GA14783@dhcp22.suse.cz>
 <alpine.DEB.2.02.1402190017480.7280@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1402190017480.7280@chino.kir.corp.google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 19-02-14 00:20:21, David Rientjes wrote:
> On Wed, 19 Feb 2014, Michal Hocko wrote:
> 
> > > I strongly suspect that the patch is correct since powerpc node distances 
> > > are different than the architectures you're talking about and get doubled 
> > > for every NUMA domain that the hardware supports.
> > 
> > Even if the units of the distance is different on PPC should every NUMA
> > machine have zone_reclaim enabled? That doesn't right to me.
> > 
> 
> In my experience on powerpc it's very correct, there's typically a 
> significant latency in remote access and we don't have the benefit of a 
> SLIT that actually defines the locality between proximity domains like we 
> do on other architectures. 

Interesting. So is the PPC NUMA basically about local vs. very distant?
Should REMOTE_DISTANCE reflect that as well? Or can we have 
distance < REMOTE_DISTANCE and it would still make sense to have
zone_reclaim enabled?

[...]

Thanks!
-- 
Michal Hocko
SUSE Labs
