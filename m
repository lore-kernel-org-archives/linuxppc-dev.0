Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0ACE1DE092
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 00:11:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m83EBANF017233
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 10:11:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m83EAxEu066416
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 08:11:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m83EAwL9030370
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 08:10:59 -0600
Message-ID: <48BE9B02.1020505@linux.vnet.ibm.com>
Date: Wed, 03 Sep 2008 09:11:14 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
References: <20080902050510.GB12965@yookeroo.seuss>
	<20080902124442.GD29766@csn.ul.ie>
	<1220389507.13010.147.camel@pasglop>
	<48BDBB2D.3050401@linux.vnet.ibm.com>
	<1220396000.13010.183.camel@pasglop>
In-Reply-To: <1220396000.13010.183.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-09-02 at 17:16 -0500, Jon Tollefson wrote:
>   
>> Benjamin Herrenschmidt wrote:
>>     
>>>> Actually, Jon has been hitting an occasional pagetable lock related
>>>> problem. The last theory was that it might be some sort of race but it's
>>>> vaguely possible that this is the issue. Jon?
>>>>     
>>>>         
>>> All hugetlbfs ops should be covered by the big PTL except walking... Can
>>> we have more info about the problem ?
>>>
>>> Cheers,
>>> Ben.
>>>   
>>>       
>> I hit this when running the complete libhugetlbfs test suite (make
>> check) with base page at 4K and default huge page size at 16G.  It is on
>> the last test (shm-getraw) when it hits it.  Just running that test
>> alone has not caused it for me - only when I have run all the tests and
>> it gets to this one.  Also it doesn't happen every time.  I have tried
>> to reproduce as well with a 64K base page but haven't seen it happen there.
>>     
>
> I don't see anything huge pages related in the backtraces which is
> interesting ...
>
> Can you get us access to a machine with enough RAM to test the 16G
> pages ?
>
> Ben.
>
>   
You can use the machine I have been using.  I'll send you a note with
the details on it after I test David's patch today.

Jon

<snip>
