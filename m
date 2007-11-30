Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C82BADDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 18:28:43 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id lAU7S9x4004922
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 12:58:09 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAU7S9Vi3878918
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 12:58:09 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id lAU7S8Lu010819
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 07:28:09 GMT
Message-ID: <474FBB86.5000004@linux.vnet.ibm.com>
Date: Fri, 30 Nov 2007 12:58:06 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] 2.6.24-rc3-git2 softlockup detected
References: <474D0AAC.5010005@linux.vnet.ibm.com>
	<20071127225328.9e3f3827.akpm@linux-foundation.org>
	<474D15FF.5080508@linux.vnet.ibm.com>
	<20071127232552.ad16e95c.akpm@linux-foundation.org>
	<474E5CAC.9000108@linux.vnet.ibm.com>
	<20071129003533.54b4b20e.akpm@linux-foundation.org>
	<20071130063929.GD2754@fattire.cabal.ca>
	<20071129230047.1b482562.akpm@linux-foundation.org>
	<20071129230204.8698f47e.akpm@linux-foundation.org>
In-Reply-To: <20071129230204.8698f47e.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-scsi@vger.kernel.org,
	Matthew Wilcox <willy@debian.org>, LKML <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Thu, 29 Nov 2007 23:00:47 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Fri, 30 Nov 2007 01:39:29 -0500 Kyle McMartin <kyle@mcmartin.ca> wrote:
>>
>>> On Thu, Nov 29, 2007 at 12:35:33AM -0800, Andrew Morton wrote:
>>>> ten million is close enough to infinity for me to assume that we broke the
>>>> driver and that's never going to terminate.
>>>>
>>> how about this? doesn't break things on my pa8800:
>>>
>>> diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
>>> index 463f119..ef01cb1 100644
>>> --- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
>>> +++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
>>> @@ -1037,10 +1037,13 @@ restart_test:
>>>  	/*
>>>  	 *  Wait 'til done (with timeout)
>>>  	 */
>>> -	for (i=0; i<SYM_SNOOP_TIMEOUT; i++)
>>> +	do {	
>>>  		if (INB(np, nc_istat) & (INTF|SIP|DIP))
>>>  			break;
>>> -	if (i>=SYM_SNOOP_TIMEOUT) {
>>> +		msleep(10);
>>> +	} while (i++ < SYM_SNOOP_TIMEOUT);
>>> +
>>> +	if (i >= SYM_SNOOP_TIMEOUT) {
>>>  		printf ("CACHE TEST FAILED: timeout.\n");
>>>  		return (0x20);
>>>  	}
>>> diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.h b/drivers/scsi/sym53c8xx_2/sym_hipd.h
>>> index ad07880..85c483b 100644
>>> --- a/drivers/scsi/sym53c8xx_2/sym_hipd.h
>>> +++ b/drivers/scsi/sym53c8xx_2/sym_hipd.h
>>> @@ -339,7 +339,7 @@
>>>  /*
>>>   *  Misc.
>>>   */
>>> -#define SYM_SNOOP_TIMEOUT (10000000)
>>> +#define SYM_SNOOP_TIMEOUT (1000)
>>>  #define BUS_8_BIT	0
>>>  #define BUS_16_BIT	1
>>>  
>> That might be the fix, but do we know what we're actually fixing?  afaik
>> 2.6.24-rc3 doesn't get this timeout, 2.6.24-rc3-mm2 does get it and we
>> don't know why?
>>
> 
> <looks at Subject:>
> 
> <Checks that Rafael was cc'ed>
> 
> So 2.6.24-rc3 was OK and 2.6.24-rc3-git2 is not?

Yes, the 2.6.24-rc3 was Ok and this is seen from 2.6.24-rc3-git2/3/4.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
