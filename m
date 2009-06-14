Return-Path: <avi@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3C8F9B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 21:53:27 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 8BEA3DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 21:53:26 +1000 (EST)
Message-ID: <4A34E4A5.3040306@redhat.com>
Date: Sun, 14 Jun 2009 14:53:09 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Torvalds wrote:
> On Sat, 13 Jun 2009, Linus Torvalds wrote:
>   
>> On Sat, 13 Jun 2009, Paul Mackerras wrote:
>>     
>>> Linus, Andrew: OK if this goes in via the powerpc tree?
>>>       
>> Ok by me.
>>     
>
> Btw, do 32-bit architectures really necessarily want 64-bit performance 
> counters? 
>
> I realize that 32-bit counters will overflow pretty easily, but I do 
> wonder about the performance impact of doing things like hashed spinlocks 
> for 64-bit counters. Maybe the downsides of 64-bit perf counters on such 
> architectures might outweight the upsides?
>   

An alternative implementation using 64-bit cmpxchg will recover most of 
the costs of hashed spinlocks.  I assume most serious 32-bit 
architectures have them?

-- 
error compiling committee.c: too many arguments to function
