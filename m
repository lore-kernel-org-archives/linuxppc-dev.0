Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 88747DDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:47:50 +1000 (EST)
Message-ID: <4720AC7A.7020208@semihalf.com>
Date: Thu, 25 Oct 2007 16:47:22 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to
	common	show_cpuinfo()
References: <20071023231309.29359.20887.stgit@hekate.izotz.org>,
	<20071024171129.3ad06712.sfr@canb.auug.org.au>
	<200710250433.l9P4XE8N038953@sullivan.realtime.net>
In-Reply-To: <200710250433.l9P4XE8N038953@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> On Wed Oct 24 17:11:29 EST 2007, Stephen Rothwell wrote:
>> On Wed, 24 Oct 2007 01:13:09 +0200 Marian Balakowicz  wrote:
>>> +		root = of_find_node_by_path("/");
>>> +		if (root)
>>> +			model = of_get_property(root, "model", NULL);
>>> +		of_node_put(root);
>> The paranoid part of me says:
>>
>> 		if (model)
>>
>>> +		seq_printf(m, "machine\t\t: %s\n", model);
> 
> My thoughts too (don't fail if no model property in /), and that
> means that
> 
>>> +		const char *model = "";
> 
> can change to  
> +		const char *model = NULL;
> 
> 
> 
> However, a quick grep shows there are several platforms that print
> out machine\t\t: something in show_cpuinfo.  Some are fixed strings
> (eg linkstation, holly, iSeries), some print model with a fallback
> (powermac), some augment the model (chrp, pseries, cell), some print
> something else (52xx/efika).  There are others.  All of those need
> to be dealt with or another tag chosen.

That's true, there is pretty wide range of different approaches. I
would opt for using a different tag and letting the platforms use
their custom machine string if they desire so. How about "model\t\t:
..."? It's not conflicting and self-explanatory too.

Cheers,
m.
