Return-Path: <sonny@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50AD64770B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:21:04 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAKJK8Ym013130
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 12:20:08 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAKJKw1s127818
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 12:20:58 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAKJKv9G029309
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 12:20:58 -0700
Date: Thu, 20 Nov 2008 13:20:57 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20081120192057.GC16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
	<20081117072613.GO16240@us.ibm.com>
	<18723.37096.243151.673526@cargo.ozlabs.ibm.com>
	<20081119170438.GA16240@us.ibm.com>
	<18724.39197.32453.148515@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18724.39197.32453.148515@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 09:54:21AM +1100, Paul Mackerras wrote:
> Sonny Rao writes:
> 
> > On Wed, Nov 19, 2008 at 03:07:04PM +1100, Paul Mackerras wrote:
> > > I think we should be checking that dev->bsr_len == 4096 here.
> > > 
> > > Paul.
> > 
> > Well, dev->bsr_len could be 4096 or 8192
> 
> Isn't the dev->bsr_len == 8192 case the one where we'll only map 4096
> bytes and therefore not do what the user expected?  Sounds to me like
> we want to return an error for that case.

Well, the problem is that we can't tell if the user asked for 4k or
8k (since we only know the size of the VMA).  

If we fail whenever dev->bsr_len is 8k then the user could never
map that device on a 64k page kernel. Is that what we want?


-- 
Sonny Rao, LTC OzLabs, BML team
