Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FE9DDE214
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:35:32 +1100 (EST)
Message-Id: <D46633DA-CDC6-4E38-8424-B62A18FDB361@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090311155242.GA11120@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/85xx: Update smp support to handle doorbells and
	non-mpic init
Date: Wed, 11 Mar 2009 12:35:25 -0500
References: <1236771963-28181-1-git-send-email-galak@kernel.crashing.org>
	<20090311155242.GA11120@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2009, at 10:52 AM, Scott Wood wrote:

> On Wed, Mar 11, 2009 at 06:46:03AM -0500, Kumar Gala wrote:
>> +void __init mpc85xx_smp_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	smp_85xx_ops.message_pass = NULL;
>> +
>> +	np = of_find_node_by_type(NULL, "open-pic");
>
> We should probably look by compatible rather than device_type.  I see
> only one device tree that has the latter but not the former (ksi8560),
> and it's not SMP (but should still be fixed, of course).

Ever other lookup for the mpic node is done by type.  I see no reason  
to change this right now.

- k
