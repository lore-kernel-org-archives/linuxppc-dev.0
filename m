Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id B682567A58
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 02:14:20 +1100 (EST)
In-Reply-To: <EE317557-1474-41EE-B746-22B6C275905F@kernel.crashing.org>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
	<20060330142626.1a9d22f5@vitb.ru.mvista.com>
	<0f0e0fbbf56f73879a70f785c497756c@embeddededge.com>
	<EE317557-1474-41EE-B746-22B6C275905F@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9ede6f664a3419c5dda34c5e1911a7e6@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Thu, 30 Mar 2006 10:14:18 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 30, 2006, at 9:37 AM, Kumar Gala wrote:

> * What a give channel (SCC, FCC, UCC, SMC?) is used for serial,
> ethernet, ATM, etc.

You need to view this from the other direction.  As I've always
said, we don't have an "SCC driver", we have a uart driver for
SCCs.  So, you configure from that perspective.  The uart driver
is configured to use certain SCCs.

> * How a channel is wired? [pin muxing]  (I really hate having drivers
> have board specific ifdefs for this)

I've got a solution for IO pin multiplexing that I have to get pushed
in using the "feature_call" method like a pmac.  The other thing
to realize here is there is often hardware beyond just "pin muxing"
that is unique to a board and requires configuration.  Statically
describing what pins set/clear is a small, and already understood
part, of more complex set up that needs to be done with code
unique to a board.

> * which (if any) BRG a channel is using?

These are already a dynamically allocated resource.  Drivers
don't care which one is assigned, you should be allocating
one and using the handle provided to the support functions.

> * ...? [I feel like I'm missing some but haven't worked on a CPM
> driver in a while :)]

I can't think of any, and I use the CPM all of the time.  :-)

> The other question is what changes between CPUs?

Almost nothing, except the PRAM offset you mention below
and I've mentioned in past messages as memory bank differences.

> * Number/Mix of channels
> * some PRAM offset (8272 FCC comes to mind)
> * channel differences for same channel type? (what's an example of
> this?)
> * ...?

Don't be creating problems to solve because we seem to have
a solution for _something_.  Yes, this would be a cute piece of code
to write and interesting driver updates, but in the end all we have
is change for the sake of change, without adding any new features.

The thing to remember is the few public Linux drivers we have
take little advantage of the CPM features.  We just configure a few
fixed standard modes (like serial and Ethernet).  The CPM is far
more powerful and flexible than this, so it seems silly to create some
complex method of describing our trivial fixed modes that has no
hope of actually being useful for "real" CPM usage.  Then, when
someone does write a more complex driver, we have all of this
"framework" that just gets in the way instead of being useful.

Thanks.


	-- Dan
