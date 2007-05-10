Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E9BD6DDEA2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 21:11:19 +1000 (EST)
Message-ID: <4642FDD6.5090609@ru.mvista.com>
Date: Thu, 10 May 2007 11:11:18 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Performance Stats: Kernel patch
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508123214.11b4f25c.akpm@linux-foundation.org>
In-Reply-To: <20070508123214.11b4f25c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, wli@holomorphy.com, pavel@ucw.cz,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

>On Tue, 08 May 2007 16:26:51 +0000
>Maxim Uvarov <muvarov@ru.mvista.com> wrote:
>
>  
>
>>From: Maxim Uvarov <muvarov@ru.mvista.com>
>>To: Andrew Morton <akpm@linux-foundation.org>
>>Cc: pavel@ucw.cz
>>Cc: linuxppc-dev@ozlabs.org
>>Cc: wli@holomorphy.com
>>Cc: dada1@cosmosbay.com
>>Cc: pavel@ucw.cz
>>    
>>
>
>Strange that linux-ppc was the only mailing list you copied?
>
>  
>
Very strange. Possible stgit mail have limitation of CC.

>>Subject: [PATCH] Performance Stats: Kernel patch
>>Date: Tue, 08 May 2007 16:26:51 +0000
>>User-Agent: StGIT/0.12.1
>>
>>
>>Patch makes available to the user the following
>>task and process performance statistics:
>>	* Involuntary Context Switches (task_struct->nivcsw)
>>	* Voluntary Context Switches (task_struct->nvcsw)
>>	* Number of system calls (added new counter
>>	  thread_info->sysall_count)
>>	           
>>Statistics information is available from:
>>        1. taskstats interface (Documentation/accounting/)
>>	2. /proc/PID/status (task only).
>>
>>This data is useful for detecting hyperactivity
>>patterns between processes.
>>    
>>
>
>syscall entry is a super-hotpath and there will be a developer revolt
>if we go adding an incl to that path, sorry.
>
>  
>
Yes, I know that it is very critical part of code. May be protection with
ifdef CONFIG_TASKSTATS  in all entry.S can be solution?
In that case we can be sure that nothing wrong can not happen,
and if this functionality is needed we can turn on this.

>(Did that incl also cover the int 80 entry?)
>  
>
Actually not. But counter increments each time when syscall  calls.
But it is in very save place, just after
        SAVE_ALL
        GET_THREAD_INFO(%ebp)
So it is very hard to break something.

(I'm going to update patch.)
