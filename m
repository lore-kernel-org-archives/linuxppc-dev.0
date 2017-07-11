Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x65Gz05WxzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 12:13:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>, "Jin\,
 Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, kan.liang@intel.com, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, Linux-kernel@vger.kernel.org, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
In-Reply-To: <20170710131049.GA13471@gate.crashing.org>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
 <20170710131049.GA13471@gate.crashing.org>
Date: Tue, 11 Jul 2017 12:13:46 +1000
Message-ID: <87vamz7mat.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Mon, Jul 10, 2017 at 07:46:17PM +0800, Jin, Yao wrote:
>> 1. We all agree these definitions:
>> 
>> +	PERF_BR_COND		= 1,	/* conditional */
>> +	PERF_BR_UNCOND		= 2,	/* unconditional */
>> +	PERF_BR_IND		= 3,	/* indirect */
>> +	PERF_BR_CALL		= 4,	/* call */
>> +	PERF_BR_IND_CALL	= 5,	/* indirect call */
>> +	PERF_BR_RET		= 6,	/* return */
>> +	PERF_BR_SYSCALL		= 7,	/* syscall */
>> +	PERF_BR_SYSRET		= 8,	/* syscall return */
>> +	PERF_BR_IRET		= 11,	/* return from interrupt */
>
> Do we?  It does not map very well to PowerPC branch types.

I think they map well enough to the types of branches that are actually
used in practice.

To represent the full range of possibilities we'd need to switch to a
bitmap of flags, ie. COND, IND, CALL, RET, SYSCALL, INT, etc. But it
would need more than 4 bits and I don't think there's that much added
value in being able to represent all the bizarre combinations.

But maybe that is the best option as it makes the API more flexible and
means we don't have to get the list of branches correct up front?


I ran some quick numbers on a kernel I had here (powernv w/gcc 7):

  Type      Percent
  -----------------
  cond      40.92%	beq (79166) bne (57379) ble (10411) bgt (9587) blt (6248) bge (3704) bdnz (1251) bdz (353) bns (30) bdnzf (2) bdnzt (1)
  uncond    14.89%	b (61182) 
  indirect  0.10%	bctr (418)
  call      33.33%	bl (136926)
  ind call  1.44%	bctrl (5912)
  return    9.23%	blr (37943)
        =   99.91%

If we add cond call/return that covers another 0.08% taking us to 99.99%
of branches.

I know future compilers and or different code might use a different
distribution, but I doubt it will change all that much.

Maybe cond could be broken down further, but the only really meaningful
sub category I can think of is the decrementing type, and those are
quite rare.

cheers
