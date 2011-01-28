Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BF175B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Jan 2011 06:59:06 +1100 (EST)
Date: Fri, 28 Jan 2011 11:59:39 -0800 (PST)
Message-Id: <20110128.115939.104064843.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH v2] gianfar: Fall back to software tcp/udp checksum on
	oldercontrollers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110128105610.4a518456@udp111988uds.am.freescale.net>
References: <640295.36173.qm@web37608.mail.mud.yahoo.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2E@saturn3.aculab.com>
	<20110128105610.4a518456@udp111988uds.am.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, David.Laight@ACULAB.COM,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>
Date: Fri, 28 Jan 2011 10:56:10 -0600

> On Fri, 28 Jan 2011 09:10:46 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
>>  
>> > +		if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12)
>> > +			     && ((unsigned long)fcb % 0x20) > 0x18)) {
>> 
>> You need to check the generated code, but I think you need:
>> 
>>     if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))
>> 	     && unlikely(((unsigned long)fcb % 0x20) > 0x18))
>> 
>> ie unlikely() around both the primitive comparisons.
> 
> Is the first condition actually unlikely?  If you've got affected
> hardware, you'll hit it every time.
> 
> If packets with the problematic alignment are rare, seems like it'd be
> better to check that first.

In cases like this gfar_has_errata() case, better to leave it's
likelyhood unmarked.

And yes, since it's cheaper, checking the alignment should be done
first.
