Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYN7B6MC4zDrLN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 09:42:46 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HNd4Qh066679
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:42:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cdmac1wjd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:42:44 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 17 Aug 2017 19:42:43 -0400
Date: Thu, 17 Aug 2017 16:42:31 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
 linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
 <87shhgdx5i.fsf@linux.vnet.ibm.com>
 <87d18fu6o1.fsf@concordia.ellerman.id.au>
 <87d18fw9it.fsf@linux.vnet.ibm.com>
 <871sous3xd.fsf@concordia.ellerman.id.au>
 <20170817233555.GC5427@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817233555.GC5427@ram.oc3035372033.ibm.com>
Message-Id: <20170817234231.GA5445@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2017 at 04:35:55PM -0700, Ram Pai wrote:
> On Wed, Aug 02, 2017 at 07:40:46PM +1000, Michael Ellerman wrote:
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > 
> > > Michael Ellerman <mpe@ellerman.id.au> writes:
> > >
> > >> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > >>> Ram Pai <linuxram@us.ibm.com> writes:
> > >> ...
> > >>>> +
> > >>>> +	/* We got one, store it and use it from here on out */
> > >>>> +	if (need_to_set_mm_pkey)
> > >>>> +		mm->context.execute_only_pkey = execute_only_pkey;
> > >>>> +	return execute_only_pkey;
> > >>>> +}
> > >>>
> > >>> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
> > >>> are read 3 times in total, and AMR is written twice. IAMR is read and
> > >>> written twice. Since they are SPRs and access to them is slow (or isn't
> > >>> it?),
> > >>
> > >> SPRs read/writes are slow, but they're not *that* slow in comparison to
> > >> a system call (which I think is where this code is being called?).
> > >
> > > Yes, this code runs on mprotect and mmap syscalls if the memory is
> > > requested to have execute but not read nor write permissions.
> > 
> > Yep. That's not in the fast path for key usage, ie. the fast path is
> > userspace changing the AMR itself, and the overhead of a syscall is
> > already hundreds of cycles.
> > 
> > >> So we should try to avoid too many SPR read/writes, but at the same time
> > >> we can accept more than the minimum if it makes the code much easier to
> > >> follow.
> > >
> > > Ok. Ram had asked me to suggest a way to optimize the SPR reads and
> > > writes and I came up with the patch below. Do you think it's worth it?
> > 
> > At a glance no I don't think it is. Sorry you spent that much time on it.
> > 
> > I think we can probably reduce the number of SPR accesses without
> > needing to go to that level of complexity.
> > 
> > But don't throw the patch away, I may eat my words once I have the full
> > series applied and am looking at it hard - at the moment I'm just
> > reviewing the patches piecemeal as I get time.
> 

Thiago's patch does save some cycles. I dont feel like throwing his
work. I agree, It should be considered after applying all the patches. 
 
RP

-- 
Ram Pai
