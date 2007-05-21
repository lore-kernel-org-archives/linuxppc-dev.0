Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 90271DDE25
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 21:28:35 +1000 (EST)
Message-ID: <4651BA9B.6040108@ru.mvista.com>
Date: Mon, 21 May 2007 15:28:27 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Using kprobes [was Re: [PATCH] Performance Stats: Kernel patch
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508123214.11b4f25c.akpm@linux-foundation.org>
	<4642FDD6.5090609@ru.mvista.com>
	<20070510111242.dd42adae.akpm@linux-foundation.org>
	<20070511172304.GI4452@austin.ibm.com>
In-Reply-To: <20070511172304.GI4452@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	pavel@ucw.cz, wli@holomorphy.com, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:

>On Thu, May 10, 2007 at 11:12:42AM -0700, Andrew Morton wrote:
>  
>
>>I don't think the syscall-counting feature has a future, sorry.  Perhaps
>>you could do something like hooking it up on-demand by insertion of a kprobe,
>>dunno.
>>    
>>
>
>This is an interesting point. I've started fiddling with (a wrapper
>around) kprobes that allows me to pick any subroutine symbol in System.map,
>and then get an event whenever that subroutine gets called. Its pretty
>slick, and allows me to gather data on certain unusual events in the
>kernel.  (I'm not using this for performance monitoring, I'm trying to 
>do RAS).
>
>It makes a lot of sense to me to have a generic kprobe extension, where 
>you could give it a list of subroutine names, and it'll collect stats
>on the number of times that the routine was called. Some user-space thingy
>could poll for those stats, or you could put them in /sys or wherever.
>
>Its more complicted than just instriumenting syscalls, but a lot more
>useful, I would think ... 
>
>--linas
>
>  
>
Thanks Linas, but do you think that kprobes is safe for syscall counting?
I think that the overhead will be much bigger in that case. In my case it is
1 line asm instruction and it is defended with #ifdefs.

Kprobes is very good thing. But is not clear for me how to count 
per-thread statistics.
In my case I increased struct thread_info. In case with kprobes it is 
easy to count all
do_fork execution, for example, but not for each thread. And in any 
case, place for keeping this
counters is needed.

Maxim.
