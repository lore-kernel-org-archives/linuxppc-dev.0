Return-Path: <chandru@in.ibm.com>
Received: from e23smtp06.au.ibm.com (unknown [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66A87DDF20
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 19:20:29 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.31.250])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n0M8KSPR018314
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 19:20:28 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0M8KRps303760
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 19:20:28 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0M8KRdh021122
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 19:20:27 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Thu, 22 Jan 2009 13:50:21 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901191700.03580.chandru@in.ibm.com>
	<1232584180.27278.86.camel@nimitz>
In-Reply-To: <1232584180.27278.86.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901221350.21601.chandru@in.ibm.com>
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

On Thursday 22 January 2009 05:59:39 Dave Hansen wrote:
> Let's take, for instance, a 1-byte reservation.  With this code, you've
> suddenly turned that into a 0-byte reservation, and that *can't* be
> right.  The same thing happens if you have a reservation that spans two
> pages.  If you unconditionally round it down, then you might miss the
> part that spans a portion of the second page.
> 
> It needs to be rounded down like you are suggesting here, but only in
> the case where we've gone over the *CURRENT* node's boundary.  This is
> kinda what that "if (end_pfn > node_ar.end_pfn)" check is doing.  But,
> it evidently screws it up if the overlap isn't by an entire page or
> something.

I assumed the condition 'while (start_pfn < end_pfn  && .. )' asks for atleast
a PAGE_SIZE difference between them and hence went ahead with that patch.
My guess was a 1-byte , 2-byte or a (PAGE_SIZE -1)-byte reservations may not even
go into that loop.  However we just need a fix for this problem. So if there is a 
better fix that you have please post it to lkml. 

Thanks,
Chandru
