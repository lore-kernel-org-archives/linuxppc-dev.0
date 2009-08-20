Return-Path: <fkan@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 28CE9B7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 09:42:46 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 91C23DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 09:42:45 +1000 (EST)
Message-ID: <4A8DDF72.2080808@amcc.com>
Date: Thu, 20 Aug 2009 16:42:42 -0700
From: Feng Kan <fkan@amcc.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [U-Boot] NAND  ECC Error with wrong SMC ording bug
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<4A8C87E6.6070702@amcc.com>
	<20090820003851.1a532444@lappy.seanm.ca>
	<200908200701.21076.sr@denx.de>
In-Reply-To: <200908200701.21076.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de,
	linux-mtd@lists.infradead.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stefan:

We had a board with high number of correctable ECC errors. Which crashed 
the jffs when it
was miss correcting the wrong byte location.

Do you want me to submit a patch for this, or do you prefer to do it. I 
am submitting a patch
for linux right now.

Feng Kan
AMCC Software

On 08/19/2009 10:01 PM, Stefan Roese wrote:
> On Thursday 20 August 2009 06:38:51 Sean MacLennan wrote:
>    
>>> I see other boards using SMC as well, can someone comment on the
>>> change I am proposing.
>>> Should I change the correction algorithm or the calculate function?
>>> If the later is preferred
>>> it would mean the change must be pushed in both U-Boot and Linux.
>>>        
>> Odds are the calculate function is wrong. The correction algo is used
>> by many nand drivers, I *assume* it is correct. The calculate function
>> was set to agree with u-boot (1.3.0).
>>      
> Yes, it seems that you changed the order in the calculation function while
> reworking the NDFC driver for arch/powerpc. So we should probably change this
> order back to the original version. And change it in U-Boot as well.
>
> BTW: I didn't see any problems with ECC so far with the current code. Feng,
> how did you spot this problem?
>
> Cheers,
> Stefan
>
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk&  Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
>    
