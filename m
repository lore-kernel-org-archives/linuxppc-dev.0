Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40E941A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 15:18:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 26 Jun 2015 15:18:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 832512CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 15:18:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5Q5HrIW4522414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 15:18:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5Q5HS36011400
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 15:17:28 +1000
Message-ID: <558CE04E.6070306@linux.vnet.ibm.com>
Date: Fri, 26 Jun 2015 10:47:02 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v4 3/3] leds/powernv: Add driver for PowerNV platform
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <20150428101008.26912.38735.stgit@localhost.localdomain>
 <1435194598.3790.32.camel@kernel.crashing.org>
In-Reply-To: <1435194598.3790.32.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 06:39 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-04-28 at 15:40 +0530, Vasant Hegde wrote:
> 
>> +Device Tree binding for LEDs on IBM Power Systems
>> +-------------------------------------------------
>> +
>> +The 'led' node under '/ibm,opal' lists service indicators available in the
>> +system and their capabilities.
>> +
>> +led {
>> +	compatible = "ibm,opal-v3-led";
>> +	phandle = <0x1000006b>;
>> +	linux,phandle = <0x1000006b>;
>> +	led-mode = "lightpath";
>> +
>> +	U78C9.001.RST0027-P1-C1 {
>> +		led-types = "identify", "fault";
>> +		led-loc = "descendent";
>> +		phandle = <0x1000006f>;
>> +		linux,phandle = <0x1000006f>;
>> +	};
>> +	...
>> +	...
>> +};

Ben,

> 
> My only issue is that /led should probably have been /leds but afaik
> this is already committed in the FW tree. Vasant, have we done a release
> what that code yet or can we still change this ?

I think we can change OPAL side as we haven't released kernel code... So no
consumer yet.
Will send a patch to skiboot mailing list. lets see

> 
> Also what does led-mode = "lightpath" means ? Can you describe it ?
> Are there alternative values ? I don't see the point myself ...

Yes.. Our system can work in two modes...
   - light path --> Both identify and faults are supported
     typically all low end servers are in this mode
  - guiding light -> Only identify LEDs are supports . no fault indicator
support for individual FRU
     typically high end servers are in this mode.

These modes are static in nature.. meaning we cannot change that during run time...
AFAIK all the PowerNV boxes shipped today are in Light Path mode.. I have added
this, so that in future if they decide to ship system with guiding light mode,
then we don't need to make any changes.


> 
> Don't leave the "linux,phandle" in the description of the binding (nor
> the phandle actually). They are implicit for all nodes, no need to
> clutter the documentation with them.

Sure. Will fix in next version.


> 
>> +Each node under 'led' node describes location code of FRU/Enclosure.
>> +
>> +The properties under each node:
>> +
>> +  led-types : Supported LED types (attention/identify/fault).
>> +
>> +  led-loc   : enclosure/descendent(FRU) location code.
> 
> I don't understand what that means. Please provide a more detailed
> explanation.
> 

This describes the LED location (FRU or enclosure level).. This was added to
identify the component (as FRU leds are overloaded and enclosure level we have
separate LEDs for each component)...


> Is the name of the node the loc code of the FRU ? In that case, how do
> you deal with multiple LEDs on the same FRU without a unit address ?

We use location code + LED type for node. So that we can identify multiple LEDs.

Looking back again, probably we can take out above property as we are not using
that today.

-Vasant
