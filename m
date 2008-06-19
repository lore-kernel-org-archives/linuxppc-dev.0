Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37E11DDEF3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 23:25:10 +1000 (EST)
Message-Id: <A7512E17-3986-4E05-8BAA-635E4D6AC865@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1213868019.8011.68.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
Date: Thu, 19 Jun 2008 08:24:58 -0500
References: <20080618004734.0B72E70296@localhost.localdomain>
	<5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org>
	<14228.1213850120@neuling.org>
	<A62DFD0C-387A-4833-B266-99DB1B09E101@kernel.crashing.org>
	<26165.1213853871@neuling.org>
	<B0E87874-BC65-4037-A43D-91C4142475E7@kernel.crashing.org>
	<29411.1213855280@neuling.org>
	<4D6D9E9A-EE1C-45E5-B493-0249C256B02B@kernel.crashing.org>
	<1213868019.8011.68.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 4:33 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2008-06-19 at 01:10 -0500, Kumar Gala wrote:
>>> I still think using the union makes it is easier to read than what  
>>> you
>>> have here.  Also, it better reflects the structure of what's being
>>> stored there.
>>
>> I don't think that holds much weight with me.  We don't union the
>> vector128 type to show it also supports float, u16, and u8 types.
>
> But this is different. The same registers are either basic FP regs or
> full VSX regs.
>
> I don't see what's wrong with union, it's a nice way to express  
> things.

We also don't do this for SPE (the freescale version).

>> I stick by the fact that the ONLY place it looks like you access the
>> union via the .vsr member is for memset or memcpy so you clearly know
>> if the size should be sizeof(double) or sizeof(vector).
>>
>> Also, I can see the case in the future that 'fpr's become
>
> What's wrong with the union ? there's nothing ugly about them..

I'll wait for the next version and see how many places .vsr is  
actually accessed.

- k
