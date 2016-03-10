Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22C2E1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:40:25 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31568140AD9
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:40:24 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id n5so16008725pfn.2
 for <linuxppc-dev@ozlabs.org>; Wed, 09 Mar 2016 16:40:24 -0800 (PST)
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
To: Torsten Duwe <duwe@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
 <20160309091904.GA23039@lst.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56E0C26F.9070702@gmail.com>
Date: Thu, 10 Mar 2016 11:40:15 +1100
MIME-Version: 1.0
In-Reply-To: <20160309091904.GA23039@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/03/16 20:19, Torsten Duwe wrote:
> On Wed, Mar 09, 2016 at 05:59:40PM +1100, Balbir Singh wrote:
>> The previous revision was nacked by Torsten, but compared to the alternatives
> I nacked it because I was confident it couldn't work. Same goes
> for this one, sorry. My good intention was to save us all some work.
I don't doubt that. I added it to the changelog to keep the history.
I've been working with the constraints we have to get a solution that
does not put the burden on the patch writer. That is why this is marked
experimental as it needs a lot of testing. I think we should mark livepatching
on PPC as experimental to begin with

>> @@ -1265,6 +1271,51 @@ ftrace_call:
>>  	ld	r0, LRSAVE(r1)
>>  	mtlr	r0
>>  
>> +#ifdef CONFIG_LIVEPATCH
>> +	beq+	4f		/* likely(old_NIP == new_NIP) */
>> +	/*
>> +	 * For a local call, restore this TOC after calling the patch function.
> This is the key issue.
>
> Ftrace_caller can gather and save the current r2 contents, no problem;
> but the point is, it needs to be restored *after* the replacement function.
> I see 3 ways to accomplish this:
>
> 1st: make _every_ replacement function aware of this, and make it restore
>      the TOC manually just before each return statement.
>
Yes and I think -pg without -mprofile-kernel does a good job of doing it.
In my patch I try to detect a call via stub and one without. The one with the
stub will do the right thing (global calls). For local calls I have the store
in CR+4 hook.
> 2nd: provide a global hook to do the job, and use a stack frame to execute it.
>
> 3rd: have a global hook like solution 2, but let it have its own data
>      structure, I'd call it a "shadow stack", for the real return addresses.
>      See struct fgraph_cpu_data in kernel/trace/trace_functions_graph.c
We thought of a shadow stack as well, but the copying can be expensive. I;ve
not looked at trace_functions_graph.c in detail, will look
> Using heuristics to determine whether the call was local or global
> makes me feel highly uncomfortable; one day it will break and
> nobody will remember why.
It could break, but as with any code, the code is only as good as the
test cases it passes :) We can document our design in detail
>
> Balbir, the problem with your patch is that it goes only half the way from
> my solution 2 towards solution 1. When you call a helper function on return,
> you need a place to store the real return address.
>
> I'll try to demonstrate a solution 1 as well, but you'll probably won't like
> that either...
Sure, look forward to it. I am keen on getting live-patching working. I think
v4 with the documented limitation is fine - see Michael's email as well
> 	Torsten
>
Thanks for looking into this,
Balbir Singh.
