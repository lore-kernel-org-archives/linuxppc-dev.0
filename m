Return-Path: <htejun@gmail.com>
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com
 [IPv6:2607:f8b0:4002:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AF541A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 06:35:22 +1000 (AEST)
Received: by ykeo3 with SMTP id o3so46889528yke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:35:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 Jul 2015 16:35:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 David Rientjes <rientjes@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150715203516.GI15934@mtj.duckdns.org>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150702230202.GA2807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Jul 02, 2015 at 04:02:02PM -0700, Nishanth Aravamudan wrote:
> we currently emit at boot:
> 
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> 
> After this commit, we correctly emit:
> 
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 

JFYI, the numbers in the brackets aren't NUMA node numbers but percpu
allocation group numbers and they're not split according to nodes but
percpu allocation units.  In both cases, there are two units each
serving 0-3 and 4-7.  In the above case, because it wasn't being fed
the correct NUMA information, both got assigned to the same group.  In
the latter, they got assigned to different ones but even then if the
group numbers match NUMA node numbers, that's just a coincidence.

Thanks.

-- 
tejun
