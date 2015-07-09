Return-Path: <rientjes@google.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E93D21A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:24:41 +1000 (AEST)
Received: by ieru20 with SMTP id u20so23966166ier.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2015 18:24:39 -0700 (PDT)
Date: Wed, 8 Jul 2015 18:24:37 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
In-Reply-To: <20150708231623.GB44862@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1507081823060.16585@chino.kir.corp.google.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150708040056.948A1140770@ozlabs.org>
 <20150708231623.GB44862@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Jul 2015, Nishanth Aravamudan wrote:

> > It looks like the symptom is that the per-cpu areas are all allocated on node
> > 0, is that all that goes wrong?
> 
> Yes, that's the symptom. I cc'd a few folks to see if they could help
> indicate the performance implications of such a setup -- sorry, I should
> have been more explicit about that.
> 

Yeah, not sure it's really a bugfix but rather a performance optimization 
since cpu_to_node() with CONFIG_USE_PERCPU_NUMA_NODE_ID is only about 
performance.
