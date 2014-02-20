Return-Path: <cl@linux.com>
Received: from qmta08.emeryville.ca.mail.comcast.net
 (qmta08.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:80])
 by ozlabs.org (Postfix) with ESMTP id D77A92C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 03:05:43 +1100 (EST)
Date: Thu, 20 Feb 2014 10:05:39 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
In-Reply-To: <20140219231714.GB413@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402201004460.11829@nuc>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Feb 2014, Nishanth Aravamudan wrote:

> We can call local_memory_node() before the zonelists are setup. In that
> case, first_zones_zonelist() will not set zone and the reference to
> zone->node will Oops. Catch this case, and, since we presumably running
> very early, just return that any node will do.

Really? Isnt there some way to avoid this call if zonelists are not setup
yet?
