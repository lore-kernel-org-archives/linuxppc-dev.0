Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E1C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147F62081B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147F62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438zSL0t1PzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 00:03:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438ytp3rvvzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 23:37:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438ytd6ssyz9s3C;
 Wed,  5 Dec 2018 23:37:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual
 address
In-Reply-To: <20181204171327.GL26700@rapoport-lnx>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
 <87woophasy.fsf@concordia.ellerman.id.au>
 <20181204171327.GL26700@rapoport-lnx>
Date: Wed, 05 Dec 2018 23:37:44 +1100
Message-ID: <87mupkkv3b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mike Rapoport <rppt@linux.ibm.com> writes:
> On Tue, Dec 04, 2018 at 08:59:41PM +1100, Michael Ellerman wrote:
>> Hi Mike,
>> 
>> Thanks for trying to clean these up.
>> 
>> I think a few could be improved though ...
>> 
>> Mike Rapoport <rppt@linux.ibm.com> writes:
>> > diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
>> > index 913bfca..fa884ad 100644
>> > --- a/arch/powerpc/kernel/paca.c
>> > +++ b/arch/powerpc/kernel/paca.c
>> > @@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
>> >  		nid = early_cpu_to_node(cpu);
>> >  	}
>> >  
>> > -	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
>> > -	if (!pa) {
>> > -		pa = memblock_alloc_base(size, align, limit);
>> > -		if (!pa)
>> > -			panic("cannot allocate paca data");
>> > -	}
>> > +	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
>> > +					 limit, nid);
>> > +	if (!ptr)
>> > +		panic("cannot allocate paca data");
>>   
>> The old code doesn't zero, but two of the three callers of
>> alloc_paca_data() *do* zero the whole allocation, so I'd be happy if we
>> did it in here instead.
>
> I looked at the callers and couldn't tell if zeroing memory in
> init_lppaca() would be ok.
> I'll remove the _raw here.
  
Thanks.

>> That would mean we could use memblock_alloc_try_nid() avoiding the need
>> to panic() manually.
>
> Actual, my plan was to remove panic() from all memblock_alloc* and make all
> callers to check the returned value.
> I believe it's cleaner and also allows more meaningful panic messages. Not
> mentioning the reduction of memblock code.

Hmm, not sure.

I see ~200 calls to the panicking functions, that seems like a lot of
work to change all those.

And I think I disagree on the "more meaningful panic message". This is a
perfect example, compare:

	panic("cannot allocate paca data");
to:
	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);

The former is basically useless, whereas the second might at least give
you a hint as to *why* the allocation failed.

I know it's kind of odd for a function to panic() rather than return an
error, but memblock is kind of special because it's so early in boot.
Most of these allocations have to succeed to get the system up and
running.

cheers
