Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B800F1007D4
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2011 18:57:36 +1100 (EST)
In-Reply-To: <1323040701.11728.27.camel@pasglop>
References: <20111202222623.GA31354@us.ibm.com>
 <144CAEA6-C129-4935-B6D1-A7D6F24530A5@kernel.crashing.org>
 <1323040701.11728.27.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10A299C4-5713-49BE-AB01-24ACE0621A11@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/1] Punch a hole in /dev/mem for librtas
Date: Mon, 5 Dec 2011 08:58:30 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +static inline int page_is_rtas_user_buf(unsigned long pfn)
>>> +{
>>> +	unsigned long paddr = (pfn << PAGE_SHIFT);
>>> +	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf +
>>> RTAS_RMOBUF_MAX))
>>
>> It probably cannot overflow with actual values of rtas_rmo_buf
>> and RTAS_RMOBUF_MAX, but otherwise it is an incorrect test;
>> please write
>>
>> 	if (paddr >= rtas_rmo_buf && paddr - rtas_rmo_buf < RTAS_RMOBUF_MAX)
>>
>> (and, _MAX?  Shouldn't it be the actual size here?  Or is _MAX
>> just a confusing name :-) )
>
> The original code is a lot more readable and perfectly correct for all
> possible values of rtas_rmo_buf :-)

You have to consider those possible values before you see it cannot
overflow.  So no, it's a lot _less_ readable IMHO.

It's also a dangerous habit to get into.  Just say no :-)


Segher
