Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5D0CBDDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 08:54:51 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v4]
From: James Hsiao <jhsiao@amcc.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20081204193256.12dbc306.kim.phillips@freescale.com>
References: <1228256232.4770.47.camel@jhsiao-usb>
	<20081204193256.12dbc306.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 13:55:07 -0800
Message-Id: <1228773307.4906.14.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kim,


>> +     /* figure how many gd is needed */
>> +     if (aad_len) {
>> +             num_gd = get_sg_count(assoc, aad_len) +
>> +                     get_sg_count(src, datalen);

> this is dead code - aad_len is never non-zero - is there some code
> missing from crypto4xx_alg.c?  Also, IIRC, assoc is a superset of src,
> so I believe something like num_gd = get_sg_count(assoc, aad_len +
> datalen) would work better - this should also permit removal of the
> nbytes reached check in [1] in get_sg_count.

For the get num_gd, assoc and src are two different scatter_lists. One
for the packet and one for the aad, so, it makes more sense to me to
count them seperately. Yes?

The way to driver pass aad and aad_len is from crypto4xx_build_pd. 
This aad support will be used in the future. Do you want me to remover
from the current release?  The reason I have it in, is to avoid too much
code change for the future release.


Thanks

James
