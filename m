Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 9F6E0DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 04:49:03 +1000 (EST)
Date: Tue, 22 May 2007 14:48:59 -0400
From: Dave Jones <davej@redhat.com>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070522184859.GD12157@redhat.com>
References: <20070522171950.23728.95735.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522171950.23728.95735.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 05:19:52PM +0000, Maxim Uvarov wrote:

 > diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
 > index 4b187bb..bccfd6a 100644
 > --- a/include/asm-i386/thread_info.h
 > +++ b/include/asm-i386/thread_info.h
 > @@ -33,6 +33,7 @@ struct thread_info {
 >  	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 >  
 >  
 > +	unsigned long		syscall_count;	/* Syscall counter */
 >  	mm_segment_t		addr_limit;	/* thread address space:
 >  					 	   0-0xBFFFFFFF for user-thead
 >  						   0-0xFFFFFFFF for kernel-thread

It seems a bit unkind to bloat up the thread_info for every process
of every user when the common case will be people that don't care about
this feature at all.

Especially when the same information could be got from ptrace.

	Dave

-- 
http://www.codemonkey.org.uk
