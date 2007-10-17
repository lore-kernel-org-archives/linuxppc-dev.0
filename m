Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id A4C77DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:42:42 +1000 (EST)
Message-ID: <4715F51D.2060000@semihalf.com>
Date: Wed, 17 Oct 2007 13:42:21 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
References: <47075FA7.3030108@semihalf.com> <4708C0DA.2040606@semihalf.com>
	<20071008150449.GB4289@loki.buserror.net>
In-Reply-To: <20071008150449.GB4289@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> 
>> +void tqm5200_show_cpuinfo(struct seq_file *m)
>> +{
>> +	struct device_node* np = of_find_all_nodes(NULL);
>> +	const char *model = NULL;
>> +
>> +	if (np)
>> +		model = of_get_property(np, "model", NULL);
>> +
>> +	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
>> +	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
>> +
>> +	of_node_put(np);
>> +}
> 
> Get rid of this.

Agree, that may be overhead in some cases. But there would be also
cases where printing out a machine name would be informative. CM5200
is one such example, there are several variants of the hw and platform
name is too generic.

Other situation would be adding compatible='mpc5200-generic' platform
where platform name would not provide any details.

m.
