Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id 490B5B7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 06:20:39 +1100 (EST)
Message-ID: <4B86CD7C.6070201@neli.hopto.org>
Date: Thu, 25 Feb 2010 20:20:28 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH 7/7] powerpc/85xx: Fix the RapidIO maintenance access
	functions
References: <20100224153751.GG13661@kaneng01.tundra.com>
	<4B858A1F.7020505@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA6@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA6@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alexandre Bounine <alexb@tundra.com>, linuxppc-dev@lists.ozlabs.org,
	thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> Hi Micha,
> 
> I tested it on my setup - it works.
> Maybe Thomas may give more details on this change.

Did you (for fun) try once to decrease the maintenance window to say, 4 
kB? Then you really need these "high" bits to work properly.

Or did you try with some register at offset > 4MB? The Tundra's have 
registers going up to 0x14000 or so? So don't need 16MB addressing for that.

Thanks, Micha


>> -----Original Message-----
>> From: Micha Nelissen [mailto:micha@neli.hopto.org]
>> Sent: Wednesday, February 24, 2010 3:21 PM
>> To: Alexandre Bounine
>> Subject: Re: [PATCH 7/7] powerpc/85xx: Fix the RapidIO maintenance
> access functions
>> Alexandre Bounine wrote:
>>>  	out_be32(&priv->maint_atmu_regs->rowtar,
>>> -		 (destid << 22) | (hopcount << 12) | ((offset & ~0x3) >>
> 9));
>>> +		 (destid << 22) | (hopcount << 12) | (offset >> 12));
>>> +	out_be32(&priv->maint_atmu_regs->rowtear,  (destid >> 10));
>> Did this actually work for you? The (offset >> 12) is due to the 4MB
>> window size right?
>>
>> Micha
> 
