Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 5B15467B5D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 01:30:58 +1000 (EST)
Message-ID: <42C2BF03.9000402@mrv.com>
Date: Wed, 29 Jun 2005 11:32:19 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050625145318.GA32117@logos.cnet>	
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>	
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>	
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>	
	<1119940208.5133.204.camel@gaston> <42C153E1.3060004@mrv.com>
	<1120018530.5133.241.camel@gaston>
In-Reply-To: <1120018530.5133.241.camel@gaston>
Content-Type: multipart/alternative;
	boundary="------------010701080805040006030305"
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS
 and	KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010701080805040006030305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Benjamin Herrenschmidt wrote:

>On Tue, 2005-06-28 at 09:42 -0400, Guillaume Autran wrote:
>  
>
>>Hi,
>>
>>I happen to notice a race condition in the mmu_context code for the 8xx 
>>with very few context (16 MMU contexts) and kernel preemption enable. It 
>>is hard to reproduce has it shows only when many processes are 
>>created/destroy and the system is doing a lot of IRQ processing.
>>
>>In short, one process is trying to steal a context that is in the 
>>process of being freed (mm->context == NO_CONTEXT) but not completely 
>>freed (nr_free_contexts == 0).
>>The steal_context() function does not do anything and the process stays 
>>in the loop forever.
>>
>>Anyway, I got a patch that fixes this part. Does not seem to affect 
>>scheduling latency at all.
>>
>>Comments are appreciated.
>>    
>>
>
>Your patch seems to do a hell lot more than fixing this race ... What
>about just calling preempt_disable() in destroy_context() instead ?
>  
>
I'm still a bit confused with "kernel preemption". One thing for sure is 
that disabling kernel preemption does indeed fix my problem.
So, my question is, what if a task in the middle of being schedule gets 
preempted by an IRQ handler, where will this task restart execution ? 
Back at the beginning of schedule or where it left of ?

The idea behind my patch was to get rid of that nr_free_contexts counter 
that is (I thing) redundant with the context_map.

Regards,
Guillaume.

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------010701080805040006030305
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
Benjamin Herrenschmidt wrote:<br>
<blockquote type="cite" cite="mid1120018530.5133.241.camel@gaston">
  <pre wrap="">On Tue, 2005-06-28 at 09:42 -0400, Guillaume Autran wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

I happen to notice a race condition in the mmu_context code for the 8xx 
with very few context (16 MMU contexts) and kernel preemption enable. It 
is hard to reproduce has it shows only when many processes are 
created/destroy and the system is doing a lot of IRQ processing.

In short, one process is trying to steal a context that is in the 
process of being freed (mm-&gt;context == NO_CONTEXT) but not completely 
freed (nr_free_contexts == 0).
The steal_context() function does not do anything and the process stays 
in the loop forever.

Anyway, I got a patch that fixes this part. Does not seem to affect 
scheduling latency at all.

Comments are appreciated.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Your patch seems to do a hell lot more than fixing this race ... What
about just calling preempt_disable() in destroy_context() instead ?
  </pre>
</blockquote>
I'm still a bit confused with "kernel preemption". One thing for sure
is that disabling kernel preemption does indeed fix my problem.<br>
So, my question is, what if a task in the middle of being schedule gets
preempted by an IRQ handler, where will this task restart execution ?
Back at the beginning of schedule or where it left of ?<br>
<br>
The idea behind my patch was to get rid of that nr_free_contexts
counter that is (I thing) redundant with the context_map.<br>
<br>
Regards,<br>
Guillaume.<br>
<br>
<pre class="moz-signature" cols="72">-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated" href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
</body>
</html>

--------------010701080805040006030305--
