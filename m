Return-Path: <rientjes@google.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 248F32C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 19:20:26 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id lf10so67633pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 00:20:23 -0800 (PST)
Date: Wed, 19 Feb 2014 00:20:21 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: ppc: RECLAIM_DISTANCE 10?
In-Reply-To: <20140219081644.GA14783@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.02.1402190017480.7280@chino.kir.corp.google.com>
References: <20140218090658.GA28130@dhcp22.suse.cz>
 <alpine.DEB.2.02.1402181424490.20772@chino.kir.corp.google.com>
 <20140219081644.GA14783@dhcp22.suse.cz>
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

> > I strongly suspect that the patch is correct since powerpc node distances 
> > are different than the architectures you're talking about and get doubled 
> > for every NUMA domain that the hardware supports.
> 
> Even if the units of the distance is different on PPC should every NUMA
> machine have zone_reclaim enabled? That doesn't right to me.
> 

In my experience on powerpc it's very correct, there's typically a 
significant latency in remote access and we don't have the benefit of a 
SLIT that actually defines the locality between proximity domains like we 
do on other architectures.  We have had significant issues with thp, for 
example, being allocated remotely instead of pages locally, much more 
drastic than on our x86 machines, particularly AMD machines.
