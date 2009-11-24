Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 3EBD1B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 04:09:17 +1100 (EST)
Message-ID: <4B0C1337.6070309@yahoo.es>
Date: Tue, 24 Nov 2009 18:09:11 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake
	ram 	regions
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>	
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>	
	<4B0AED90.6050600@yahoo.es> <1259019909.31172.63.camel@concordia>
In-Reply-To: <1259019909.31172.63.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> Would it be acceptable to create a global var __allow_ioremap_normal_ram that by default would have a value of 0 and would be set _only_ for those platforms needing it?
>>
>> The other solutions I see is:
>> - add support for discontiguous memory to powerpc 32-bits (which is not something that I can look into now)
>> - don't use the precious second 64MB area (which is a waste)
> 
> - Implement your own ppc_md.ioremap(), see iseries & cell for example.
> 
> Currently that's only called on 64-bit, but you could change that.
> 
> If I'm reading your patch right, you should be able to do that check in
> your platform's ioremap() and then call the generic implementation to do
> the actual work.
> 
> cheers

I could use ppc_md.ioremap to duplicate ioremap except for the ioremap ram check.
But calling the stock ioremap without modifying it is not possible because it checks and bails out when ioremapping a region marked as ram (even if it's not real ram and it's memreserved).

Is the list of memreserved areas preserved once the kernel is running?
If it is preserved another option would be to unban ioremapping ram if memreserved.

Thanks for your input,
Albert
