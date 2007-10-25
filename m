Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AABB7DDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 14:33:35 +1000 (EST)
Date: Wed, 24 Oct 2007 23:33:14 -0500 (CDT)
Message-Id: <200710250433.l9P4XE8N038953@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to common
	show_cpuinfo()
In-Reply-To: <20071024171129.3ad06712.sfr@canb.auug.org.au>
References: <20071023231309.29359.20887.stgit@hekate.izotz.org>,
	<20071024171129.3ad06712.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Oct 24 17:11:29 EST 2007, Stephen Rothwell wrote:
> On Wed, 24 Oct 2007 01:13:09 +0200 Marian Balakowicz  wrote:
>>
>> +		root = of_find_node_by_path("/");
>> +		if (root)
>> +			model = of_get_property(root, "model", NULL);
>> +		of_node_put(root);
> 
> The paranoid part of me says:
> 
> 		if (model)
> 
>> +		seq_printf(m, "machine\t\t: %s\n", model);
> 

My thoughts too (don't fail if no model property in /), and that
means that

>> +		const char *model = "";

can change to  
+		const char *model = NULL;



However, a quick grep shows there are several platforms that print
out machine\t\t: something in show_cpuinfo.  Some are fixed strings
(eg linkstation, holly, iSeries), some print model with a fallback
(powermac), some augment the model (chrp, pseries, cell), some print
something else (52xx/efika).  There are others.  All of those need
to be dealt with or another tag chosen.

milton
