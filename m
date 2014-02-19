Return-Path: <rientjes@google.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CFFA02C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 08:45:20 +1100 (EST)
Received: by mail-pd0-f172.google.com with SMTP id p10so915491pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 13:45:16 -0800 (PST)
Date: Wed, 19 Feb 2014 13:45:14 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: ppc: RECLAIM_DISTANCE 10?
In-Reply-To: <20140219091959.GD14783@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.02.1402191339000.31921@chino.kir.corp.google.com>
References: <20140218090658.GA28130@dhcp22.suse.cz>
 <alpine.DEB.2.02.1402181424490.20772@chino.kir.corp.google.com>
 <20140219081644.GA14783@dhcp22.suse.cz>
 <alpine.DEB.2.02.1402190017480.7280@chino.kir.corp.google.com>
 <20140219091959.GD14783@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 19 Feb 2014, Michal Hocko wrote:

> Interesting. So is the PPC NUMA basically about local vs. very distant?

The point is that it's impossible to tell how distant they are from one 
NUMA domain to the next NUMA domain.

> Should REMOTE_DISTANCE reflect that as well? Or can we have 
> distance < REMOTE_DISTANCE and it would still make sense to have
> zone_reclaim enabled?
> 

Ppc doesn't want to allocate in a different NUMA domain unless required, 
the latency of a remote access is too high.  Everything that isn't in the 
same domain has a distance >10 and is setup as 2^(domain hops) * 10.  We 
don't have the ability like with a SLIT to define remote nodes to have 
local latency vs remote or costly latency so the safe setting is a 
RECLAIM_DISTANCE of 10.
