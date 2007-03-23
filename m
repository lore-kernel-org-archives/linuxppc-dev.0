Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C2CADE16B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 03:42:20 +1100 (EST)
In-Reply-To: <20070323150058.GA6060@ld0162-tx32.am.freescale.net>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070323150058.GA6060@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29089968dc071f4b6917428a439f735e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Fri, 23 Mar 2007 17:42:14 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Segher, what is the the 'other alias' mechanism you are referring
>>> to that should be dropped?  Is it this proposed linux,network-index
>>> property?  or something else?
>>
>> Just the
>>
>> 	pic0: pic@700 {
>> 		...
>> 	}
>>
>> labeling thing -- it becomes redundant when the flat tree
>> stuff would support OF-style aliases, so it can be phased
>> out then.
>
> How?  You still need integer-encoded phandles, as that's how various
> properties are defined.

Of course.  But DTC could derive them automatically.

> Why should every node that needs a phandle
> reference have to go in /aliases?

They don't.  They don't need a label now, either.  It's just
handy for many/most things to go in /aliases.

> They seem to be solving two different
> problems to me.

Yeah, one a superset of the other.  Except for labels
on / into properties as David mentioned, which is a
flat-tree specific solution for a flat-tree specific
problem.

> As for using aliases for network indices, it could be done, but it'd be
> more complicated to implement due to string manipulation.

It's more complex because it's more flexible, yes.  I think
it'll pay off -- and how complex is using a sprintf() really.


Segher
