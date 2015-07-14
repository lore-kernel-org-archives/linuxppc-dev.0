Return-Path: <rientjes@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A87451A0163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 07:31:24 +1000 (AEST)
Received: by ietj16 with SMTP id j16so20754658iet.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 14:31:22 -0700 (PDT)
Date: Tue, 14 Jul 2015 14:31:20 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
In-Reply-To: <20150710162531.GE44862@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1507141430370.16182@chino.kir.corp.google.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1507081811280.16585@chino.kir.corp.google.com>
 <20150710162531.GE44862@linux.vnet.ibm.com>
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

On Fri, 10 Jul 2015, Nishanth Aravamudan wrote:

> > After the percpu areas on initialized and cpu_to_node() is correct, it 
> > would be really nice to be able to make numa_cpu_lookup_table[] be 
> > __initdata since it shouldn't be necessary anymore.  That probably has cpu 
> > callbacks that need to be modified to no longer look at 
> > numa_cpu_lookup_table[] or pass the value in, but it would make it much 
> > cleaner.  Then nobody will have to worry about figuring out whether 
> > early_cpu_to_node() or cpu_to_node() is the right one to call.
> 
> When I worked on the original pcpu patches for power, I wanted to do
> this, but got myself confused and never came back to it. Thank you for
> suggesting it and I'll work on it soon.
> 

Great, thanks for taking it on!  I have powerpc machines so I can test 
this and try to help where possible.
