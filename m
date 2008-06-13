Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A2C5DDF16
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 05:11:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5DJ70F8022698
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:07:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DJBLxr161640
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 13:11:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5DJBKjV022088
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 13:11:20 -0600
Message-ID: <4852C655.8030409@austin.ibm.com>
Date: Fri, 13 Jun 2008 14:11:17 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 02/19] powerpc: Split processor entitlement retrieval
	and gathering to helper routines
References: <20080612215312.GF30916@linux.vnet.ibm.com>	<20080612220858.GI30916@linux.vnet.ibm.com>
	<20080613102313.0ce30d4d.sfr@canb.auug.org.au>
In-Reply-To: <20080613102313.0ce30d4d.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Robert,
> 
> On Thu, 12 Jun 2008 17:08:58 -0500 Robert Jennings <rcj@linux.vnet.ibm.com> wrote:
>> -		seq_printf(m, "R4=0x%lx\n", h_entitled);
>> -		seq_printf(m, "R5=0x%lx\n", h_unallocated);
>> -		seq_printf(m, "R6=0x%lx\n", h_aggregation);
>> -		seq_printf(m, "R7=0x%lx\n", h_resource);
> 
> This changes a user visible interface by removing the above.  I don't
> know if this matters (probably not), but it should be mentioned in the
> changelog.
>

You're right this should have been mentioned. The values it is printing 
out are the raw values returned from the H_GET_PPP hcall.  The values 
were then parsed and pretty printed afterwards.  I don't see a need to 
print these values out twice.

>> +	if (new_entitled)
>> +		*new_weight = current_weight;
>> +
>> +	if (new_weight)
>> +		*new_entitled = current_entitled;
> 
> These look fishy - checking one pointer for NULL and then updating via
> the other pointer.
> 

I thought something about this looked strange...

Unfortunately this code gets slightly updated again in patch 3/19 of 
this patch series.  The point you make is valid though, should not be 
de-referencing the pointers without validating them.

I'll update this patch with a new changelog and pull the change from 
patch 3/19 into this pach where it belongs.

-Nathan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
