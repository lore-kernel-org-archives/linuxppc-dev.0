Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41720DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 17:56:34 +1000 (EST)
In-Reply-To: <20070622033158.GA21419@localhost.localdomain>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
	<20070622033158.GA21419@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba34492532ac9dfd43bd9f2ae427deef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] Create add_rtc() function to enable the RTC CMOS driver
Date: Fri, 22 Jun 2007 09:56:24 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hrm.  It seems rather specific.  Can we do this more generally, by
> creating an of_platform device which binds to rtc nodes, then
> registers an appropriate platform device for each so that the generic
> rtc drivers pick them up.  Obviously we'd need some sort of table
> mapping the device node compatible properties to the appropriate
> platform device names.

>> +	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
>> +	 * address provided by the device node matches.
>> +	 */
>> +	if (res.start != RTC_PORT(0)) {
>> +		of_node_put(np);
>> +		return -ENODEV;
>> +	}
>
> This looks totally bogus.  If we have a device tree we should be using
> the address information from there, not using hardcoded magic.  Sounds
> like asm/mc146818rtc.h needs some serious fixing.

Both of your comments would be nice extensions (and the right
way forwards), but Wade's patch is good as-is already.


Segher
