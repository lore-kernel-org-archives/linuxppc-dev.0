Return-Path: <wmb@firmworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27732B7BE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 08:28:45 +1000 (EST)
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B379DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 08:28:44 +1000 (EST)
Message-ID: <4A970881.5090603@firmworks.com>
Date: Thu, 27 Aug 2009 12:28:17 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Clock binding
References: <1250569288.19007.15.camel@pasglop>	
	<1251346157.20467.22.camel@pasglop>
	<4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop>
In-Reply-To: <1251411532.20467.74.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>
>> > Open Firmware often avoids indexed structures.  Cases in point include 
>> > the use of named properties instead of fixed structures and named 
>> > methods instead of function pointer arrays.  Open Firmware's use of 
>> > arrays for reg properties seems like the right choice for that 
>> > particular case, but shouldn't be construed to suggest that arrays are 
>> > good for everything.
>>     
>
> Well, the "reg" property is fine for the common cases of devices with
> one IO (or MMIO) range, no confusion possible, or PCI since it encodes
> the BAR number. For other cases, especially random embedded stuff that
> maps several regions of memory, it's a bit harder since we go back to
> the need of having "somebody" define which region is which.
>
>
>   

Indeed.  You choose based on the common case and eventually there will 
be some case that stretches the boundaries.

I suppose that, if the problem became severe enough, one could invent a 
new "reg-names" property, a list of strings naming the reg entries.
