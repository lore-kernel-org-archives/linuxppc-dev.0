Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 3E8F467A7E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 01:06:42 +1100 (EST)
Message-ID: <424177FB.7090101@mrv.com>
Date: Wed, 23 Mar 2005 09:06:51 -0500
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
	<20050322175815.GB7846@logos.cnet>
In-Reply-To: <20050322175815.GB7846@logos.cnet>
Content-Type: multipart/alternative;
	boundary="------------040901050208080902080300"
Cc: "Smith, Craig" <craig.d.smith@siemens.com>, paulus@samba.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
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
--------------040901050208080902080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Marcelo Tosatti wrote:

>On Tue, Mar 22, 2005 at 03:57:08PM -0500, Dan Malek wrote:
>  
>
>>On Mar 22, 2005, at 8:04 AM, Marcelo Tosatti wrote:
>>
>>    
>>
>>>I'm quite puzzled. Why v2.6 calls the "tlbie" instruction 100-or-so
>>>less times than v2.4 ?
>>>      
>>>
>
>That was rather a _factor_ of "100-or-so" less.
>
>  
>
>>Oh my ...  I'm more worried about the high number of TLB misses
>>in 2.6 compared to 2.4.  That's really bad.  
>>    
>>
>
>Newbie question: What prevents the initial kernel map (tuple of 8Mbyte I/D-TLB entries) 
>and the IMMR 8Mbyte D-TLB entry from getting unmapped by translation pressure,
>in case CONFIG_PIN_TLB is disabled ? 
>
>  
>
>>How did you instrument the tlbie measurement? 
>>    
>>
>
>By a counter at the end of _tlbie function, similar to other counters which 
>you suggested.
>
>  
>
>>It could be that 2.4 used lots more 'tlbia' which were replaced by tlbie in 2.6.
>>    
>>
>
>Dont think thats the case given that v2.4 calls tlbia through flush_tlb_mm() at exit_mmap() 
>only. And at vmalloc_free which shouldnt be called at all.
>
>I just noticed this conditional at switch_mm() (v2.6), which _can_ partly 
>explain the reduced tlbie's  (its just a guess for now, though):
>
>static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>                             struct task_struct *tsk)
>{
>#ifdef CONFIG_ALTIVEC
>        asm volatile (
> BEGIN_FTR_SECTION
>        "dssall;\n"
>#ifndef CONFIG_POWER4
>         "sync;\n" /* G4 needs a sync here, G5 apparently not */
>#endif
> END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>         : : );
>#endif /* CONFIG_ALTIVEC */
>                                                                                            
>        tsk->thread.pgdir = next->pgd;
>                                                                                            
>        /* No need to flush userspace segments if the mm doesnt change */
>	if (prev == next) 				<--------------
>		return;   				<--------------
>                                                                                            
>        /* Setup new userspace context */
>        get_mmu_context(next);
>        set_context(next->context, next->pgd);
>}
>
>I'm about to disable it and retry.
>
>Spent part of the day reading the MMU section of 860 manual, I think I have kind 
>of a clue how things are supposed to work at the lowlevel now. 
>
>I'll continue tracking it down - any help is appreciated.
>
>PS: I can't reproduce the invalid TLB crash anymore. i.e. even by removing
>the _tlbie() at update_mmu_cache() everything is working as expected.
>
>How can I reproduce it again? Guillaume, what kernel version are you using?
>
>  
>
It is very timing dependant. Running 2.6.11, ldconfig crashes in 
__flush_dcache_icache(...) just after boot time (first time called). 
Unfortunatly, it only happens every now and then. And of course, never 
when my BDI2000 is plugged in. :(

I also noticed that with kernel preemption disable, oops are less 
frequent. Probably does not mean anything anyway...

Guillaume.


-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------040901050208080902080300
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=us-ascii">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
Marcelo Tosatti wrote:<br>
<blockquote type="cite" cite="mid20050322175815.GB7846@logos.cnet">
  <pre wrap="">On Tue, Mar 22, 2005 at 03:57:08PM -0500, Dan Malek wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mar 22, 2005, at 8:04 AM, Marcelo Tosatti wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">I'm quite puzzled. Why v2.6 calls the "tlbie" instruction 100-or-so
less times than v2.4 ?
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
That was rather a _factor_ of "100-or-so" less.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Oh my ...  I'm more worried about the high number of TLB misses
in 2.6 compared to 2.4.  That's really bad.  
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Newbie question: What prevents the initial kernel map (tuple of 8Mbyte I/D-TLB entries) 
and the IMMR 8Mbyte D-TLB entry from getting unmapped by translation pressure,
in case CONFIG_PIN_TLB is disabled ? 

  </pre>
  <blockquote type="cite">
    <pre wrap="">How did you instrument the tlbie measurement? 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
By a counter at the end of _tlbie function, similar to other counters which 
you suggested.

  </pre>
  <blockquote type="cite">
    <pre wrap="">It could be that 2.4 used lots more 'tlbia' which were replaced by tlbie in 2.6.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Dont think thats the case given that v2.4 calls tlbia through flush_tlb_mm() at exit_mmap() 
only. And at vmalloc_free which shouldnt be called at all.

I just noticed this conditional at switch_mm() (v2.6), which _can_ partly 
explain the reduced tlbie's  (its just a guess for now, though):

static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                             struct task_struct *tsk)
{
#ifdef CONFIG_ALTIVEC
        asm volatile (
 BEGIN_FTR_SECTION
        "dssall;\n"
#ifndef CONFIG_POWER4
         "sync;\n" /* G4 needs a sync here, G5 apparently not */
#endif
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
         : : );
#endif /* CONFIG_ALTIVEC */
                                                                                            
        tsk-&gt;thread.pgdir = next-&gt;pgd;
                                                                                            
        /* No need to flush userspace segments if the mm doesnt change */
	if (prev == next) 				&lt;--------------
		return;   				&lt;--------------
                                                                                            
        /* Setup new userspace context */
        get_mmu_context(next);
        set_context(next-&gt;context, next-&gt;pgd);
}

I'm about to disable it and retry.

Spent part of the day reading the MMU section of 860 manual, I think I have kind 
of a clue how things are supposed to work at the lowlevel now. 

I'll continue tracking it down - any help is appreciated.

PS: I can't reproduce the invalid TLB crash anymore. i.e. even by removing
the _tlbie() at update_mmu_cache() everything is working as expected.

How can I reproduce it again? Guillaume, what kernel version are you using?

  </pre>
</blockquote>
It is very timing dependant. Running 2.6.11, ldconfig crashes in
__flush_dcache_icache(...) just after boot time (first time called).
Unfortunatly, it only happens every now and then. And of course, never
when my BDI2000 is plugged in. :(<br>
<br>
I also noticed that with kernel preemption disable, oops are less
frequent. Probably does not mean anything anyway...<br>
<br>
Guillaume.<br>
<br>
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

--------------040901050208080902080300--
