Return-Path: <wmb@firmworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82C92B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 03:37:47 +1000 (EST)
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0259CDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 03:37:45 +1000 (EST)
Message-ID: <4A82FC63.7020705@firmworks.com>
Date: Wed, 12 Aug 2009 07:31:15 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARM clock API to PowerPC
References: <1250063825.15143.43.camel@pasglop>
	<1250065762.15143.47.camel@pasglop>
In-Reply-To: <1250065762.15143.47.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On Wed, 2009-08-12 at 17:57 +1000, Benjamin Herrenschmidt wrote:
>
>   
>> >  - Device-tree: The idea on top of my mind would be to define a
>> > clock-map property that has the following format:
>> > 
>> > A list of:
>> > 	- zero terminated string clock ID, padded with zeros
>> >           to a cell boundary
>>     


Padding a string violates a core principle of property representation, 
namely the "no alignment assumptions" one.  The reason for that 
principle was the fact that alignment needs are not stable across 
processor families, or even within a processor family .

>> >  	- a phandle to the clock provider
>> > 	- a numerical (string ?) ID for that clock within that provider
>> > 
>> > The core would thus be able to do a search in that list based on the
>> > clock-id passed in, or if clk_get(dev, NULL), then, use the first one.
>>     
>
> Thinking a bit more about that one, mixing strings and numbers in a
> property sucks. What about instead:
>
>  clock-map is a list of phandle, id
>
>  clock-names is an optional list of 0 terminated strings
>   

This approach finesses the problem nicely.

> If there's only one clock, and the ID can be ommited, then the
> clock-names property can be ommited completely too. Else, the
> entries in clock-names match the entries in clock-map.
>
> It's a bit strange to separate the list into two properties but
> I think it will generally suck less than having them mixed, especially
> with ASCII representations such as lsprop output.
>
> Cheers,
> Ben
>   
