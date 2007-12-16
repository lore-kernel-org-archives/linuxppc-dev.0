Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9C84DDDED
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 09:45:07 +1100 (EST)
In-Reply-To: <20071216223342.GD26307@localhost.localdomain>
References: <1197705316-17618-1-git-send-email-sr@denx.de>
	<20071216061959.GD21311@localhost.localdomain>
	<20071216085858.55ffddbe@vader.jdub.homelinux.org>
	<f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
	<20071216223342.GD26307@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9618c94dbc228065db8bd99fbf6b7ba6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files
Date: Sun, 16 Dec 2007 23:44:50 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Hopefully some version that stores path strings in the properties
>> in /aliases, and not phandles.  Or does that current version of DTC
>> do that correctly already, and just has an inconvenient source
>> syntax?
>
> I don't think anyone's actually gone and generated phandles in
> /aliases, although it was suggested early on.  The syntax is
> 	foo = < &bar >;
> to generate a phandle and
> 	foo = &bar;
> to generate a path.

Ah, I see.

> I was a bit worried about confusion between these forms, but at least
> Kumar and myself came up with this syntax independently, which
> suggests it's not too surprising to most people, and no-one had any
> other suggestions.

I think I suggested it before, but anyway:

how about you write

	aliases {
		foo = "/the/path/to/foo";
	};

and then you can use  &foo  in the rest of the DTS to refer to the
phandle (or path string, as it turns out :-) ) of the node?  I.e.,
use the aliases node to _generate_ aliases.

Seems simpler than the current thing to me.


Segher
