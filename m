Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7CE8DDE456
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:58:58 +1000 (EST)
Message-ID: <4807AC15.4010008@freescale.com>
Date: Thu, 17 Apr 2008 14:59:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com>
In-Reply-To: <4807AB7A.90005@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
>> +	spin_lock_irqsave(&cmxgcr_lock, flags);
>> +
>> +	clrsetbits_be32(&mux->cmxgcr, QE_CMXGCR_USBCS, val);
> 
> Would it be useful if I made the clrsetbits functions atomic, using lwarx/stwcx.?

No.  clrsetbits operates on I/O registers, not RAM.

-Scott
