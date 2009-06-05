Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58F74B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 01:48:59 +1000 (EST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B42F4DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 01:48:57 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n55F5uZ4016801
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 20:35:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n55Fmp232330722
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 21:18:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n55FmpRF019733
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 21:18:51 +0530
Message-ID: <4A293E62.4090700@in.ibm.com>
Date: Fri, 05 Jun 2009 21:18:50 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
References: <4A290195.3080807@in.ibm.com> <20090605150429.GA29614@csn.ul.ie>
In-Reply-To: <20090605150429.GA29614@csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mel Gorman wrote:
> That patch fixes a different problem. The assertion shouldn't have been
> made for hugetlbfs regions. I can only assume we are not triggering the
> same problem.  According to your .config, DEBUG_VM is not even set so
> this is some other problem.
>
> Do you know what line triggered the problem? Eric Munson is currently
> investigating this as I'm chasing down another bug but my understanding is that
> right now he can't reproduce the problem. How reproducible is this for you?
I cannot recreate this consistently. Sometimes i am able to recreate , 
but it's random. I have
seen this problem on 2 out of 4 power boxes.

Here are last few lines from the hugetlbfs test run.

get_huge_pages (32):	PASS
get_huge_pages (64):	PASS
quota (32):	PASS
quota (64):	PASS
counters (32):	PASS
counters (64):	PASS
mmap-gettest 10 20 (32):	PASS
mmap-gettest 10 20 (64):	PASS
mmap-cow 19 20 (32):	PASS
mmap-cow 19 20 (64):	PASS
set shmmax limit to 335544320
shm-fork 10 10 (32):	PASS
shm-fork 10 10 (64):	PASS
shm-fork 10 20 (32):	

shm-fork was executed when the oops occurred.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
