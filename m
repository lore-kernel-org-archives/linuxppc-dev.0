Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 421CCDDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 02:25:28 +1000 (EST)
Message-ID: <46E6C145.2050006@freescale.com>
Date: Tue, 11 Sep 2007 11:24:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] fsl_soc.c cleanup
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
	<20070911135717.GD1932@ld0162-tx32.am.freescale.net>
	<3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
	<46E6B98C.1070207@freescale.com>
	<B247D7AF-6AB9-4009-BFB8-0A365D3F0DF2@kernel.crashing.org>
In-Reply-To: <B247D7AF-6AB9-4009-BFB8-0A365D3F0DF2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Sep 11, 2007, at 10:51 AM, Scott Wood wrote:
>> Any particular reason to special-case it, when we already need code to 
>> do it the other way for every other fsl soc?
> 
> If you suggest a sane way of getting the value let me know.  The mpc8xx 
> doesn't appear to have what I would call 'soc' level registers like 
> 83xx/85xx/86xx does.  How do you propose we determine the immrbase?

What exactly do you mean by "soc"-level registers?

I propose we do it by defining the first (and ideally only, but that's 
another argument) entry in ranges as the immr, and getting rid of /soc/reg.

>> And why is 82xx-pq2 special?  Wouldn't you need this on 83xx, 85xx, 
>> and 86xx as well?
> 
> The range will cover the whole immr space on 83xx/85xx/86xx.

And why can't it do that on 82xx?

> 82xx-pq2 is special in that its soc regs are in the middle of the immr 
> address map.

The /soc node is misnamed; it should really be /immr.  Why do we need 
these particular registers to be in /soc/reg rather than a subnode?

-Scott
