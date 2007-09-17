Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id EAFD6DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 04:35:10 +1000 (EST)
Message-Id: <20070917183507.332345000@sgi.com>
Date: Mon, 17 Sep 2007 11:35:07 -0700
From: travis@sgi.com
To: sfr@canb.auug.org.au,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/1] ppc64: Convert cpu_sibling_map to a per_cpu data array
	ppc64 v2
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
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
> On Mon, 17 Sep 2007 16:28:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> 	the topology (on my POWERPC5+ box) is not correct:
>>
>> cpu0/topology/thread_siblings:0000000f
>> cpu1/topology/thread_siblings:0000000f
>> cpu2/topology/thread_siblings:0000000f
>> cpu3/topology/thread_siblings:0000000f
>>
>> it used to be:
>>
>> cpu0/topology/thread_siblings:00000003
>> cpu1/topology/thread_siblings:00000003
>> cpu2/topology/thread_siblings:0000000c
>> cpu3/topology/thread_siblings:0000000c
> 
> This would be because we are setting up the cpu_sibling map before we
> call setup_per_cpu_areas().

The following patch hopefully should fix this problem.  I'm
not able to build or test it but the few references to 
cpu_sibling_map seem to all occur well after setup_per_cpu_areas
is called.

Thanks Stephen for checking this out!

-- 
