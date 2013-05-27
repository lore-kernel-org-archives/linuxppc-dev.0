Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE6442C043F
 for <linuxppc-dev@ozlabs.org>; Mon, 27 May 2013 20:02:46 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 27 May 2013 19:57:09 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5EA30357804A
 for <linuxppc-dev@ozlabs.org>; Mon, 27 May 2013 20:02:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4R9mRwh19792076
 for <linuxppc-dev@ozlabs.org>; Mon, 27 May 2013 19:48:27 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4RA2fxO016039
 for <linuxppc-dev@ozlabs.org>; Mon, 27 May 2013 20:02:42 +1000
Message-ID: <51A32F1F.5020109@linux.vnet.ibm.com>
Date: Mon, 27 May 2013 15:32:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc, perf: Ignore separate BHRB privilege state
 filter request
References: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369201667-9048-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1369206855.12874.9.camel@concordia> <519C88D9.30009@linux.vnet.ibm.com>
In-Reply-To: <519C88D9.30009@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2013 02:29 PM, Anshuman Khandual wrote:
>>
>> Your description from patch 0 should be here.
> Does it sound better ?
> 
>>
>>> -	if ((br_privilege != 7) && (br_privilege != 0))
>>> -		return -1;
>>> +
>>> +	if (br_privilege)
>>> +		pr_info("BHRB privilege state filter request %llx ignored\n",
>>> +								br_privilege);
>>
>> Don't do that. Ignoring the br_privilege is either the right thing to do
>> in which case we do it and print nothing,
> 
> 
> I thought the informational print would at least make the user aware
> of the fact that the separate filter request for BHRB went ignored.
> Can we add this some where in the documentation ?

So, what we decide here ? We will just ignore any separate BHRB
privilege state filter request without printing any informational
event or warning ?
