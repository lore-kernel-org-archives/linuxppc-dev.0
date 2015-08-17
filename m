Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 9BACF1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 21:00:44 +1000 (AEST)
Message-ID: <55D1BED4.4040808@c-s.fr>
Date: Mon, 17 Aug 2015 13:00:36 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
CC: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc32: optimise csum_partial() loop
References: <cover.1435655733.git.christophe.leroy@c-s.fr>
 <67cf476f657e87b2ea586951a57ae3ba3c1e3c0c.1435655733.git.christophe.leroy@c-s.fr>
 <20150806003059.GD18479@gate.crashing.org>
 <1438828301.2097.126.camel@freescale.com>
 <20150806043938.GE18479@gate.crashing.org>
 <1438901145.2097.170.camel@freescale.com>
 <20150806232506.GB22196@gate.crashing.org> <55D1BDF0.4090008@c-s.fr>
In-Reply-To: <55D1BDF0.4090008@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/08/2015 12:56, leroy christophe a écrit :
>
>
> Le 07/08/2015 01:25, Segher Boessenkool a écrit :
>> On Thu, Aug 06, 2015 at 05:45:45PM -0500, Scott Wood wrote:
>>> If this makes performance non-negligibly worse on other 32-bit 
>>> chips, and is
>>> an important improvement on 8xx, then we can use an ifdef since 8xx 
>>> already
>>> requires its own kernel build.  I'd prefer to see a benchmark 
>>> showing that it
>>> actually does make things worse on those chips, though.
>> And I'd like to see a benchmark that shows it *does not* hurt 
>> performance
>> on most chips, and does improve things on 8xx, and by how much. But it
>> isn't *me* who has to show that, it is not my patch.
> Ok, following this discussion I made some additional measurement and 
> it looks like:
> * There is almost no change on the 885
> * There is a non negligeable degradation on the 8323 (19.5 tb ticks 
> instead of 15.3)
>
> Thanks for pointing this out, I think my patch is therefore not good.
>
Oops, I was talking about my other past, the one that was to optimise 
ip_csum_fast.
I still have to measure csum_partial

Christophe
