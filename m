Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46B76A5A.3030300@ru.mvista.com>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71744f7b099977da5ead771aac8d2ded@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 23:03:41 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> "bit-swizzling" or something which can be defined to describe some odd
>> connections.  If absent we'd default to direct mapping.  Segher, is
>> that idea going to cause you to scream?
>
>     Actually, checking for the presence of all possible perverted 
> mapping
> props doesn't seem a good idea -- it's simpler to check for the 
> presence of
> one prop (like "direct-mapped" I was thinking about, or maybe 
> "simple-map").

There shouldn't be many "perverted" properties -- really weird
mappings can just do a special "compatible" value, the standard
kernel driver can't handle them either, anyway.

A few extra property lookups are dirt cheap.  This isn't
speed-critical code anyway.

>> Well, now you do.  I believe USB usually uses that format, too.
>
>     USB what, hosts or devices?

The unit-address of a device is specified in its parent's
address space.  USB hosts don't typically have a USB bus as
parent ;-)  (but they can still have a comma in the unit
address.  Confused?  Don't be :-) ).

>     Hm, right... the option here would be to always have at least one
> partition and no "reg" property in the MTD node itself... or have 
> "reg" with
> no partition and "ranges" if partitions are there... :-)

No way.  "reg" is needed *no matter what* -- I'll not list the
other problems with that proposal.


Segher
