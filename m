Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
 [209.85.215.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76B262C0093
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 07:05:31 +1100 (EST)
Received: by mail-ea0-f170.google.com with SMTP id a13so2748216eaa.15
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 13:05:27 -0700 (PDT)
Message-ID: <508060FD.3040202@gmail.com>
Date: Thu, 18 Oct 2012 23:05:17 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com> <1350587006.2476.12.camel@pasglop>
In-Reply-To: <1350587006.2476.12.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-10-18 at 20:45 +0300, Robert Berger wrote:
>> -       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH addr */
>> -       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low addr */
>> +       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
>> +       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
>> +
>>  
>>         msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
>> -       if (!msi->msi_dev)
>> +       if (msi->msi_dev)
>>                 return -ENODEV; 
> 
> The above changes look bad. The first one is stupid, the second one is clearly broken.
> 
> The diff us from good to bad right ? Looks like somebody added a very busted patch.

this (from 3.6) does not work:

-       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
addr */
-       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
addr */

The good old file (which works) is this:

+       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
+       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
+

> 
> If I look at the code in current upstream, I see:
> 
> 	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
> 	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
> 
> 	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> 	if (!msi->msi_dev)
> 		return -ENODEV;
> 
> 
> Which looks correct. So this might be something specific to ELDK ?

I will be on the road from tomorrow for a week or so, but maybe I can
isolate the exact lines which break it. I can also try a newer compiler
to see if this changes anything.

Is there someone out there with a kilauea board who can boot a 3.6.
mainline kernel with a default config with a rootfs over nfs?

> 
> Cheers,
> Ben.
> 
> 

Regards,

Robert
