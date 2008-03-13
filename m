Return-Path: <ahuja@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5D85DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 15:29:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2D4TPRZ020612
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 00:29:25 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2D4TOfm200822
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 22:29:24 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2D4TOoc025012
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 22:29:24 -0600
Message-ID: <47D8AD9C.2030106@austin.ibm.com>
Date: Wed, 12 Mar 2008 23:29:16 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linasvepstas@gmail.com
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
References: <47B90F55.2080606@austin.ibm.com>	
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>	
	<47C74A66.1060105@austin.ibm.com>
	<47C750CE.7050202@austin.ibm.com>	
	<1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
	<3ae3aa420803121052g6ded9c94xd23823a4e81f4bbf@mail.gmail.com>
In-Reply-To: <3ae3aa420803121052g6ded9c94xd23823a4e81f4bbf@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If Mike and Paul are okay, then I will leave this bit as is and fix all 
other issues and comments.

Thanks,
Manish



Linas Vepstas wrote:
> On 10/03/2008, Michael Ellerman <michael@ellerman.id.au> wrote:
>> On Thu, 2008-02-28 at 18:24 -0600, Manish Ahuja wrote:
> 
>>  > +
>>  > +/* Global, used to communicate data between early boot and late boot */
>>  > +static struct phyp_dump phyp_dump_global;
>>  > +struct phyp_dump *phyp_dump_info = &phyp_dump_global;
>>
>> I don't see the point of this. You have a static (ie. non-global) struct
>>  called phyp_dump_global, then you create a pointer to it and pass that
>>  around.
> 
> I did this. This is a style used to minimize disruption due to future
> design changes. Basically, the idea is that, at some later time, for
> some unknown reason, we decide that this structure shouldn't
> be global, or maybe shouldn't be statically allocated, or maybe
> should be per-cpu, or who knows.  By creating a pointer, and
> just passing that around, you isolate other code from this change.
> 
> I learned this trick after spending too many months of my life hunting
> down globals and replacing them by dynamically allocated structs.
> Its a long and painful process, on many levels, often requiring major
> code restructuring.  Code that touches globals directly is often
> poorly thought out, designed.  But going in the opposite direction
> is easy: if your code always passes everything it needs as args
> to subroutines,  then you are free & clear ... if one of those args
> just happens to be a pointer to a global, there's no loss (not even
> a performance loss -- the arg passing overhead is about the same
> as a global TOC lookup!)
> 
> So it may look weird if you're not used to seeing it; but the alternative
> is almost always worse.
> 
> --linas
