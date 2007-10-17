Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF554DDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:33:53 +1000 (EST)
Message-ID: <47162B63.60601@freescale.com>
Date: Wed, 17 Oct 2007 10:33:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
References: <47075FA7.3030108@semihalf.com> <4708C0DA.2040606@semihalf.com>
	<20071008150449.GB4289@loki.buserror.net>
	<4715F51D.2060000@semihalf.com>
In-Reply-To: <4715F51D.2060000@semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marian Balakowicz wrote:
> Scott Wood wrote:
>>> +void tqm5200_show_cpuinfo(struct seq_file *m)
>>> +{
>>> +	struct device_node* np = of_find_all_nodes(NULL);
>>> +	const char *model = NULL;
>>> +
>>> +	if (np)
>>> +		model = of_get_property(np, "model", NULL);
>>> +
>>> +	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
>>> +	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
>>> +
>>> +	of_node_put(np);
>>> +}
>> Get rid of this.
> 
> Agree, that may be overhead in some cases. But there would be also
> cases where printing out a machine name would be informative. CM5200
> is one such example, there are several variants of the hw and platform
> name is too generic.

Maybe, though if we're going to do that it'd be better to just print 
/model in the generic cpuinfo (or somewhere else generic).  And there's 
always /proc/device-tree/model...

-Scott
