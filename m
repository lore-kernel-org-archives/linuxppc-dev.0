Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id B3EB167BD0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 04:27:52 +1000 (EST)
Message-ID: <42D40BF0.6040605@mrv.com>
Date: Tue, 12 Jul 2005 14:29:04 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <42D3D277.106@mrv.com> <20050712163921.GE25918@gate.ebshome.net>
In-Reply-To: <20050712163921.GE25918@gate.ebshome.net>
Content-Type: multipart/alternative;
	boundary="------------090303040808040407010407"
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix destroy_context() race condition
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
--------------090303040808040407010407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eugene, destroy_context(..) can be called from other place outside of 
the scheduler and switch_mm(...). See mmdrop(...) for example.
In many of those cases, the task will run with preemption enable.

Guillaume.


Eugene Surovegin wrote:

>On Tue, Jul 12, 2005 at 10:23:51AM -0400, Guillaume Autran wrote:
>  
>
>>Fix for a race condition when a task gets preempted by another task
>>while executing the destroy_context(...) in a FEW_CONTEXTS environment.
>>mm->context == NO_CONTEXT but the context_map may indicate all contexts
>>are in use.
>>The solution to this problem is to disable kernel preemption while
>>destroying a MMU context.
>>
>>Signed-off-by: Guillaume Autran <gautran@mrv.com>
>>
>>---
>>
>>diff -Nru a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
>>--- a/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
>>+++ b/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
>>@@ -149,6 +149,7 @@
>>*/
>>static inline void destroy_context(struct mm_struct *mm)
>>{
>>+	preempt_disable();
>>	if (mm->context != NO_CONTEXT) {
>>		clear_bit(mm->context, context_map);
>>		mm->context = NO_CONTEXT;
>>@@ -156,6 +157,7 @@
>>		atomic_inc(&nr_free_contexts);
>>#endif
>>	}
>>+	preempt_enable();
>>}
>>
>>static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>
>>    
>>
>
>Could you explain, why this patch is needed?
>
>AFAIK, destroy_context() is only called from switch_mm(), which in 
>turn is called from schedule() with preemption already disabled. If 
>not, IMHO we have bigger problems, and "fixing" destroy_context() will 
>only hide such problems.
>
>  
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------090303040808040407010407
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=us-ascii">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Eugene, destroy_context(..) can be called from other place outside of
the scheduler and switch_mm(...). See mmdrop(...) for example.<br>
In many of those cases, the task will run with preemption enable. <br>
<br>
Guillaume.<br>
<br>
<br>
Eugene Surovegin wrote:<br>
<blockquote type="cite"
 cite="mid20050712163921.GE25918@gate.ebshome.net">
  <pre wrap="">On Tue, Jul 12, 2005 at 10:23:51AM -0400, Guillaume Autran wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Fix for a race condition when a task gets preempted by another task
while executing the destroy_context(...) in a FEW_CONTEXTS environment.
mm-&gt;context == NO_CONTEXT but the context_map may indicate all contexts
are in use.
The solution to this problem is to disable kernel preemption while
destroying a MMU context.

Signed-off-by: Guillaume Autran <a class="moz-txt-link-rfc2396E" href="mailto:gautran@mrv.com">&lt;gautran@mrv.com&gt;</a>

---

diff -Nru a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
--- a/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
+++ b/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
@@ -149,6 +149,7 @@
*/
static inline void destroy_context(struct mm_struct *mm)
{
+	preempt_disable();
	if (mm-&gt;context != NO_CONTEXT) {
		clear_bit(mm-&gt;context, context_map);
		mm-&gt;context = NO_CONTEXT;
@@ -156,6 +157,7 @@
		atomic_inc(&amp;nr_free_contexts);
#endif
	}
+	preempt_enable();
}

static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Could you explain, why this patch is needed?

AFAIK, destroy_context() is only called from switch_mm(), which in 
turn is called from schedule() with preemption already disabled. If 
not, IMHO we have bigger problems, and "fixing" destroy_context() will 
only hide such problems.

  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="80">-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated" href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
</body>
</html>

--------------090303040808040407010407--
