Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFE881A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 20:46:46 +1000 (AEST)
Message-ID: <1443610005.10198.1.camel@ellerman.id.au>
Subject: Re: [1/5] powerpc/perf: Drop the branch sample when 'from' cannot
 be fetched
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com,
 dja@axtens.net
Date: Wed, 30 Sep 2015 20:46:45 +1000
In-Reply-To: <560BA55A.70309@linux.vnet.ibm.com>
References: <20150727041915.63106140326@ozlabs.org>
 <55B6F225.4070902@linux.vnet.ibm.com> <560BA55A.70309@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-30 at 14:33 +0530, Anshuman Khandual wrote:
> On 07/28/2015 08:38 AM, Anshuman Khandual wrote:
> > On 07/27/2015 09:49 AM, Michael Ellerman wrote:
> >> > On Tue, 2015-30-06 at 08:20:27 UTC, Anshuman Khandual wrote:
> >>> >> BHRB (Branch History Rolling Buffer) is a rolling buffer. Hence we
> >>> >> might end up in a situation where we have read one target address
> >>> >> but when we try to read the next entry indicating the from address
> >>> >> of the target address, the buffer just overflows. In this case, the
> >>> >> captured from address will be zero which indicates the end of the
> >>> >> buffer.
> >> > 
> >> > Right. But with SMT8 the size of the buffer is very small, so we will actually
> >> > hit this case somewhat often. When we originally wrote this we decided it was
> >> > better to get some information, ie. the from address, than no information at
> >> > all.
> > You are right. But practically as of now we are not using this kind of
> > (from, 0) branch entries any where as a special case. More over for
> > certain kind of workloads which has a small code and a few branches,
> > the chances of getting this kind of branch (from, 0) increases a lot
> > making them probably one of the highest percentage entries in the final
> > perf report. Now with this change of code, the workload session might
> > have overall less number of branch entries, but in my opinion represents
> > more accurate branch profile of the given workload in percentage wise.
> > 
> >> > 
> >>> >> 	This patch drops the entire branch record which would have
> >>> >> otherwise confused the user space tools.
> >> > 
> >> > Does it confuse the tools? Can you show me before/after output from perf?
> > The word 'confuse' might be little misleading. But the point as
> > explained above that the relative branch percentage profile of
> > certain workloads might be distorted and that I believe is true.
> > Also branch entries like "from ----> 0" in the perf report might
> > be confusing to users who dont expect to see this kind of entries
> > in the final perf report and will never get into "perf report -D"
> > to figure out what really happened.
> 
> Hey Michael,
> 
> As I had explained earlier, is not it a good idea to drop these
> kind of branch records from the final output ? I will request
> consideration of this patch along with others in the series.

I think it's too late to change it. ie. we've shipped several kernel versions
that did emit them, so we just have to stick with that. If it was obviously a
bug fix we could change it, but it's not obviously correct either way.

So please drop that patch and repost the series.

cheers
