Return-Path: <avi@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 837E4B70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 23:04:47 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id E5639DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 23:04:46 +1000 (EST)
Message-ID: <4A34F564.2010500@redhat.com>
Date: Sun, 14 Jun 2009 16:04:36 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>	<4A34E4A5.3040306@redhat.com>
	<18996.60235.178618.531664@cargo.ozlabs.ibm.com>
In-Reply-To: <18996.60235.178618.531664@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Avi Kivity writes:
>
>   
>> An alternative implementation using 64-bit cmpxchg will recover most of 
>> the costs of hashed spinlocks.  I assume most serious 32-bit 
>> architectures have them?
>>     
>
> Have a 64-bit cmpxchg, you mean?  x86 is the only one I know of, and
> it already has an atomic64_t implementation using cmpxchg8b (or
> whatever it's called).
>   

Yes (and it is cmpxchg8b).  I'm surprised powerpc doesn't have DCAS support.

> My thinking is that the 32-bit non-x86 architectures will be mostly
> UP, so the overhead is just an interrupt enable/restore.  Those that
> are SMP I would expect to be small SMP -- mostly just 2 cpus and maybe
> a few 4-way systems.
>   

The new Nehalems provide 8 logical threads in a single socket.  All 
those threads share a cache, and they have cmpxchg8b anyway, so this 
won't matter.

-- 
error compiling committee.c: too many arguments to function
