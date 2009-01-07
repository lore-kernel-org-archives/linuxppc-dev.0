Return-Path: <chandru@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87200DE4CD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 23:58:19 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n07CwB7A029341
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 18:28:11 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n07CuXId3903578
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 18:26:33 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n07CwBST004440
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 23:58:11 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Wed, 7 Jan 2009 18:28:13 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901051919.52327.chandru@in.ibm.com>
	<1231173033.19452.190.camel@nimitz>
In-Reply-To: <1231173033.19452.190.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901071828.13719.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 05 January 2009 22:00:33 Dave Hansen wrote:
> OK, I had to think about this for a good, long time.  That's bad. :)
>
> There are two things that we're dealing with here: "active regions" and
> the NODE_DATA's.  The if() you've pasted above resizes the reservation
> so that it fits into the current active region.  However, as you noted,
> we haven't resized it so that it fits into the NODE_DATA() that we're
> looking at.  We call into the bootmem code, and BUG_ON().
>
> The thing I don't like about this is that it might hide bugs in other
> callers.  This really is a ppc-specific thing and, although what you
> wrote will fix the bug on ppc, it will probably cause someone in the
> future to call reserve_bootmem_node() with too large a reservation and
> get a silent failure (not reserving the requested size) back.
>
> We really do need to go take a hard look at the whole interaction
> between lmb's, node active regions, and the NUMA code some day.  It has
> kinda grown to be a bit ungainly.
>
> How about we just consult the NODE_DATA() in
> mark_reserved_regions_for_nid() instead of reserve_bootmem_node()?

I don't know how you wanted NODE_DATA() to be consulted here. i.e before 
calling reserve_bootmem_node() should we have a condition 

	if (PFN_UP(physbase+reserve_size) > node_end_pfn) 
	then
		resize reserve_size again so that PFN_UP() will equate to node_end_pfn ??
	end 

Also I was wondering if in reserve_bootmem_node()
	end = PFN_DOWN() ; will do.. 

With the recent changes from you that went into 2.6.28 stable 
(commit:a4c74ddd5ea3db53fc73d29c222b22656a7d05be), it worked on the system 
with PFN_DOWN(). 

Thanks,
Chandru
