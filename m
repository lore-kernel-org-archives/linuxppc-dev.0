Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sg0486HBxzDsl2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 00:58:32 +1000 (AEST)
Date: Thu, 22 Sep 2016 09:58:26 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <acme@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
 <treeze.taeung@gmail.com>, <naveen.n.rao@linux.vnet.ibm.com>,
 <markus@trippelsdorf.de>, <namhyung@kernel.org>, <pawel.moll@arm.com>,
 <chris.ryder@arm.com>, <jolsa@kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v7 0/6] perf annotate: Cross arch support + few fixes
Message-Id: <20160922095826.e3e5986e5acf0b2f692ef55b@arm.com>
In-Reply-To: <57E36995.4090101@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160921143427.8db0abae30690baadc18de01@arm.com>
 <57E36995.4090101@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Sep 2016 10:48:13 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> On Thursday 22 September 2016 01:04 AM, Kim Phillips wrote:
> > On Wed, 21 Sep 2016 21:17:50 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >> Kim, I don't have arm test machine. Can you please help me to test
> >> this on arm.
> > This works for me:  hitting return on return instructions yields
> > "Invalid jump offset", but I'll get that later.
> 
> Thanks Kim.
> 
> Hmm.. so, ins__find_arm does not contain logic for return instructions. Navigation
> with return instruction is working fine for x86 and powerpc.

Right, for ARM, in order to match return instructions, 'lr' must be
found to be the operand of the branch instruction, which is not
contained in the 'name' variable passed to ins__find().

I don't want this to inhibit acceptance of this series, however: I plan
on addressing it afterwards, unless, of course, it is perceived as a
problem somehow (compatibility-wise, it is not because it is an error
at the moment).

Thanks,

Kim
