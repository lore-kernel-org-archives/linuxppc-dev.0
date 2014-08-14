Return-Path: <cl@linux.com>
Received: from qmta06.emeryville.ca.mail.comcast.net
 (qmta06.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:56])
 by lists.ozlabs.org (Postfix) with ESMTP id 1F3021A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 00:44:00 +1000 (EST)
Date: Thu, 14 Aug 2014 09:35:37 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/4] topology: add support for node_to_mem_node()
 to determine the fallback node
In-Reply-To: <20140814001422.GJ11121@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.11.1408140934290.25902@gentwo.org>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
 <20140814001422.GJ11121@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, David Rientjes <rientjes@google.com>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Aug 2014, Nishanth Aravamudan wrote:

> +++ b/include/linux/topology.h
> @@ -119,11 +119,20 @@ static inline int numa_node_id(void)
>   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
>   */
>  DECLARE_PER_CPU(int, _numa_mem_);
> +extern int _node_numa_mem_[MAX_NUMNODES];

Why are these variables starting with an _ ?
Maybe _numa_mem was defined that way because it is typically not defined.
We dont do this in other situations.
