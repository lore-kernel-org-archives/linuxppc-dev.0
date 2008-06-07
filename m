Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66EE4DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 10:26:13 +1000 (EST)
In-Reply-To: <20080605185948.3847436d@zod.rchland.ibm.com>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com> <484809D1.2070300@scram.de>
	<48480B3C.9080101@freescale.com>
	<20080605185948.3847436d@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6b441042e5a5ce2b880362bcbc4a25d8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Sat, 7 Jun 2008 02:24:15 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Stefan Roese <sr@denx.de>, Scott@ozlabs.org, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>, Wood <scottwood@freescale.com>,
	Jean Delvare <khali@linux-fr.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Well, I just don't see the point of having two different properties 
>> that say the
>> same thing.  I'm not an IEE 1275 purist, so I don't think we should 
>> be hampered
>> by old node definitions.  I especially don't like having a property 
>> specifically
>> for indexing I2C nodes that can't be used to enumerate other nodes.
>
> It's not about purity.  It's about overloading something that has
> existing semantics just because you have one usecase that you _think_
> needs it.
>
> If everyone did that, this whole device tree concept is going to just
> be one big cluster f*ck.

One important way of preventing this overloading and death-by-complexity
is to make most properties specific to a particular binding.  It is good
if other bindings that need similar functionality can use similar
properties, or sometimes even identical ones; but there are only a few
properties that are defined for *every* node.

Trying to make stuff too generic just doesn't work.


Segher
