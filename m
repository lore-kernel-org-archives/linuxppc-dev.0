Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13FA52BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 10:09:16 +1100 (EST)
In-Reply-To: <OF39E98ED9.64FBC87A-ONC1256F50.006BC66A-C1256F50.006EA31B@axxessit.no>
References: <OF39E98ED9.64FBC87A-ONC1256F50.006BC66A-C1256F50.006EA31B@axxessit.no>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3639E976-39B7-11D9-8F98-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 18 Nov 2004 18:11:43 -0500
To: morten.banzon@axxessit.no
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 18, 2004, at 3:08 PM, morten.banzon@axxessit.no wrote:

> If you know the reason to why it is "a very bad idea" to relocate these
> resources within dpram1 I am very curious to learn. On the other hand 
> if
> you do not know, then please refrain from giving such a stupid answer.

As you have discovered, there are many dependencies on the
configuration of the cpm smc from the boot rom to bootloaders to
the Linux kernel itself.  It's a bad idea to be changing one of these
without changing all of the others to match ....  and then you end
up with a custom piece of software that you have to constantly
maintain.  If you make it configurable, then you end up with even
more confusion when people mismatch the configurations on
a board.

There isn't any reason to change the current SMC buffering configuration
on the CPM2 (and future) devices.  If you like change for the sake
of change, then go ahead and do it.  We answered the questions
you asked and specifically said the changes you were making at
the time weren't a good idea.  Just because you didn't agree
doesn't make it a stupid response, especially since it's pretty easy
to figure out on your own from looking at the code.

Thanks.

	-- Dan
