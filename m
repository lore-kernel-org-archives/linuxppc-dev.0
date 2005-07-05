Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id E985F67C6F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 23:10:41 +1000 (EST)
Message-ID: <42CA8727.8060504@mrv.com>
Date: Tue, 05 Jul 2005 09:12:07 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
References: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>	<20050626143004.GA5198@logos.cnet>	<20050627133930.GA9109@logos.cnet>	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>	<1119940208.5133.204.camel@gaston>
	<42C153E1.3060004@mrv.com>	<1120018530.5133.241.camel@gaston>
	<42C2BF03.9000402@mrv.com>	<20050629155445.GA3560@logos.cnet>	<1120087568.31924.14.camel@gaston>	<20050629193846.GA4748@logos.cnet>
	<42C3F978.2070305@mrv.com>
In-Reply-To: <42C3F978.2070305@mrv.com>
Content-Type: multipart/mixed; boundary="------------040603080000030706090803"
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
--------------040603080000030706090803
Content-Type: multipart/alternative;
	boundary="------------030805030209040904050803"


--------------030805030209040904050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late reply. I was away for the long weekend. However, my 
validation test ran all the way through the long weekend ! So, we can 
consider this a fix.
See the patch attached.

Thanks,
Guillaume.


Guillaume Autran wrote:

> Well, disabling preemption in the get_mmu_context() does not help much...
> I'm trying to disable preemption only inside destroy_mmu_context() as 
> suggested.
> Will keep you posted.
>
> Guillaume.
>
>
>
> Marcelo Tosatti wrote:
>
>>On Thu, Jun 30, 2005 at 09:26:07AM +1000, Benjamin Herrenschmidt wrote:
>>  
>>
>>>>Execution is resumed exactly where it has been interrupted.
>>>>
>>>>      
>>>>
>>>>>The idea behind my patch was to get rid of that nr_free_contexts counter 
>>>>>that is (I thing) redundant with the context_map.
>>>>>        
>>>>>
>>>>Apparently its there to avoid the spinlock exactly on !FEW_CONTEXTS machines.
>>>>
>>>>I suppose that what happens is that get_mmu_context() gets preempted after stealing
>>>>a context (so nr_free_contexts = 0), but before setting next_mmu_context to the 
>>>>next entry
>>>>
>>>>next_mmu_context = (ctx + 1) & LAST_CONTEXT;
>>>>      
>>>>
>>>Ugh ? Can switch_mm() be preempted at all ? Did I miss yet another
>>>"let's open 10 gazillion races for gun" Ingo patch ?
>>>    
>>>
>>
>>Doh nope it can't - my bad.
>>
>>  
>>
>>>>So if the now running higher prio tasks calls switch_mm() (which is likely to happen)
>>>>it loops forever on atomic_dec_if_positive(&nr_free_contexts), while steal_context()
>>>>sees "mm->context == CONTEXT".
>>>>      
>>>>
>>>I think the race is only when destroy_context() is preempted, but maybe
>>>I missed something.
>>>    
>>>
>>
>>Nope, I think you are right. My "theory" is obviously flawed now. 
>>
>>There seem to be several contexts where destroy_context() could be called
>>with preempt enabled - I should have been shutup in the first place :)
>>
>>Lets wait for Guillaume to test...
>>
>>  
>>
>
>-- 
>=======================================
>Guillaume Autran
>Senior Software Engineer
>MRV Communications, Inc.
>Tel: (978) 952-4932 office
>E-mail: gautran@mrv.com
>======================================= 
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------030805030209040904050803
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Sorry for the late reply. I was away for the long weekend. However, my
validation test ran all the way through the long weekend ! So, we can
consider this a fix.<br>
See the patch attached.<br>
<br>
Thanks,<br>
Guillaume.<br>
<br>
<br>
Guillaume Autran wrote:<br>
<blockquote type="cite" cite="mid42C3F978.2070305@mrv.com">
  <title></title>
Well, disabling preemption in the get_mmu_context() does not help
much... <br>
I'm trying to disable preemption only inside destroy_mmu_context() as
suggested.<br>
Will keep you posted.<br>
  <br>
Guillaume.<br>
  <br>
  <br>
  <br>
Marcelo Tosatti wrote:<br>
  <blockquote type="cite" cite="mid20050629193846.GA4748@logos.cnet">
    <pre wrap="">On Thu, Jun 30, 2005 at 09:26:07AM +1000, Benjamin Herrenschmidt wrote:
  </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">Execution is resumed exactly where it has been interrupted.

      </pre>
        <blockquote type="cite">
          <pre wrap="">The idea behind my patch was to get rid of that nr_free_contexts counter 
that is (I thing) redundant with the context_map.
        </pre>
        </blockquote>
        <pre wrap="">Apparently its there to avoid the spinlock exactly on !FEW_CONTEXTS machines.

I suppose that what happens is that get_mmu_context() gets preempted after stealing
a context (so nr_free_contexts = 0), but before setting next_mmu_context to the 
next entry

next_mmu_context = (ctx + 1) &amp; LAST_CONTEXT;
      </pre>
      </blockquote>
      <pre wrap="">Ugh ? Can switch_mm() be preempted at all ? Did I miss yet another
"let's open 10 gazillion races for gun" Ingo patch ?
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Doh nope it can't - my bad.

  </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">So if the now running higher prio tasks calls switch_mm() (which is likely to happen)
it loops forever on atomic_dec_if_positive(&amp;nr_free_contexts), while steal_context()
sees "mm-&gt;context == CONTEXT".
      </pre>
      </blockquote>
      <pre wrap="">I think the race is only when destroy_context() is preempted, but maybe
I missed something.
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Nope, I think you are right. My "theory" is obviously flawed now. 

There seem to be several contexts where destroy_context() could be called
with preempt enabled - I should have been shutup in the first place :)

Lets wait for Guillaume to test...

  </pre>
  </blockquote>
  <br>
  <pre class="moz-signature" cols="72">-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated"
 href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
  <pre wrap="">
<hr width="90%" size="4">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
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

--------------030805030209040904050803--

--------------040603080000030706090803
Content-Type: text/plain;
 name="preempt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="preempt.patch"

diff -Nru linux-2.6.12/include/asm-ppc/mmu_context.h linux-2.6.12.new/include/asm-ppc/mmu_context.h
--- linux-2.6.12/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12.new/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
@@ -149,6 +149,7 @@
  */
 static inline void destroy_context(struct mm_struct *mm)
 {
+	preempt_disable();
 	if (mm->context != NO_CONTEXT) {
 		clear_bit(mm->context, context_map);
 		mm->context = NO_CONTEXT;
@@ -156,6 +157,7 @@
 		atomic_inc(&nr_free_contexts);
 #endif
 	}
+	preempt_enable();
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,

--------------040603080000030706090803--
