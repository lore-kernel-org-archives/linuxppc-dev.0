Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 41CDEDDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 01:31:11 +1000 (EST)
Message-ID: <46EE9BCF.3040303@sgi.com>
Date: Mon, 17 Sep 2007 08:22:55 -0700
From: Mike Travis <travis@sgi.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 09/10] ppc64: Convert cpu_sibling_map to a per_cpu data
	array (v3)
References: <20070912015644.927677070@sgi.com>	<20070912015647.486500682@sgi.com>
	<20070917162831.b2a9d675.sfr@canb.auug.org.au>
In-Reply-To: <20070917162831.b2a9d675.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Tue, 11 Sep 2007 18:56:53 -0700 travis@sgi.com wrote:
>> Convert cpu_sibling_map to a per_cpu cpumask_t array for the ppc64
>> architecture.  This fixes build errors in block/blktrace.c and
>> kernel/sched.c when CONFIG_SCHED_SMT is defined.
>>
>> Note: these changes have not been built nor tested.
> 
> After applying all 10 patches, the ppc64_defconfig builds but:
> 
> 	vmlinux is larger:
> 
>    text    data     bss     dec     hex filename
> 7705776 1756984  504624 9967384  981718 ppc64/vmlinux
> 7706228 1757120  504624 9967972  981964 trav.bld/vmlinux
> 
> 	the topology (on my POWERPC5+ box) is not correct:
> 
> cpu0/topology/thread_siblings:0000000f
> cpu1/topology/thread_siblings:0000000f
> cpu2/topology/thread_siblings:0000000f
> cpu3/topology/thread_siblings:0000000f
> 
> it used to be:
> 
> cpu0/topology/thread_siblings:00000003
> cpu1/topology/thread_siblings:00000003
> cpu2/topology/thread_siblings:0000000c
> cpu3/topology/thread_siblings:0000000c
> 
> Similarly on my iSeries box, the topology is displayed as above
> while it used to be:
> 
> cpu0/topology/thread_siblings:00000001
> cpu1/topology/thread_siblings:00000002
> cpu2/topology/thread_siblings:00000004
> cpu3/topology/thread_siblings:00000008
> 

Thanks Stephen for the feedback.  It may be the same situation
that some of the other arch's encounter in that the per_cpu
area is being accessed before it's setup.  I'll investigate
that a bit more.

Mike
