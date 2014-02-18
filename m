Return-Path: <rientjes@google.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A8402C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 09:27:15 +1100 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kp14so17322107pab.34
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 14:27:13 -0800 (PST)
Date: Tue, 18 Feb 2014 14:27:11 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: ppc: RECLAIM_DISTANCE 10?
In-Reply-To: <20140218090658.GA28130@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.02.1402181424490.20772@chino.kir.corp.google.com>
References: <20140218090658.GA28130@dhcp22.suse.cz>
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

On Tue, 18 Feb 2014, Michal Hocko wrote:

> Hi,
> I have just noticed that ppc has RECLAIM_DISTANCE reduced to 10 set by
> 56608209d34b (powerpc/numa: Set a smaller value for RECLAIM_DISTANCE to
> enable zone reclaim). The commit message suggests that the zone reclaim
> is desirable for all NUMA configurations.
> 
> History has shown that the zone reclaim is more often harmful than
> helpful and leads to performance problems. The default RECLAIM_DISTANCE
> for generic case has been increased from 20 to 30 around 3.0
> (32e45ff43eaf mm: increase RECLAIM_DISTANCE to 30).
> 
> I strongly suspect that the patch is incorrect and it should be
> reverted. Before I will send a revert I would like to understand what
> led to the patch in the first place. I do not see why would PPC use only
> LOCAL_DISTANCE and REMOTE_DISTANCE distances and in fact machines I have
> seen use different values.
> 

I strongly suspect that the patch is correct since powerpc node distances 
are different than the architectures you're talking about and get doubled 
for every NUMA domain that the hardware supports.
