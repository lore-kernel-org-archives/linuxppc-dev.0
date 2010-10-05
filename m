Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4111CB6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 18:52:38 +1100 (EST)
In-Reply-To: <AANLkTikt9e5s3UUn1+k=NY7UhqosM5qkgdih=UD+Hd+L@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<AANLkTikt9e5s3UUn1+k=NY7UhqosM5qkgdih=UD+Hd+L@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7C4D5662-14C7-4ACD-8096-3B7649220A12@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: use of BAT before taking over the MMU
Date: Tue, 5 Oct 2010 09:54:35 +0200
To: Albert Cahalan <acahalan@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The PowerPC OF binding requires the firmware to save and restore
>> the BATs on entry to / exit from the firmware.
>
> This sucks, because using the BAT is **much** easier for
> the firmware. In my case, it also means I don't need to worry
> about Linux stomping on anything -- I have nothing in RAM.

It's easy to save and restore the BATs on firmware entry/exit,
where do you see a problem?

> Page tables would need to go in RAM. If Linux wants to
> use that memory...?

Same way as when the client uses *any* memory OF has claimed:
it has to stop calling OF from then on.

> It seems that Linux does tend to ask;
> will it panic if I refuse? Are there addresses Linux won't
> ever ask for?

Linux always "kills" OF pretty early on.

> It also looks like I could just start up Linux w/o the MMU on.

Yes, that's common and works.  You will still need BATs (or
something else) to do I/O from the firmware though.


Segher
