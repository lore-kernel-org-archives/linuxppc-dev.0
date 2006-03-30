Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE7C567A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 02:43:34 +1100 (EST)
In-Reply-To: <9ede6f664a3419c5dda34c5e1911a7e6@embeddedalley.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
	<20060330142626.1a9d22f5@vitb.ru.mvista.com>
	<0f0e0fbbf56f73879a70f785c497756c@embeddededge.com>
	<EE317557-1474-41EE-B746-22B6C275905F@kernel.crashing.org>
	<9ede6f664a3419c5dda34c5e1911a7e6@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3A2715AD-F459-4AB3-B01B-13301BE2B908@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Thu, 30 Mar 2006 09:43:38 -0600
To: Dan Malek <dan@embeddedalley.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 30, 2006, at 9:14 AM, Dan Malek wrote:

>
> On Mar 30, 2006, at 9:37 AM, Kumar Gala wrote:
>
>> * What a give channel (SCC, FCC, UCC, SMC?) is used for serial,
>> ethernet, ATM, etc.
>
> You need to view this from the other direction.  As I've always
> said, we don't have an "SCC driver", we have a uart driver for
> SCCs.  So, you configure from that perspective.  The uart driver
> is configured to use certain SCCs.

Oh, I agree with you.  This becomes more obvious with QE where  
everything is a UCC channel.

>> * How a channel is wired? [pin muxing]  (I really hate having drivers
>> have board specific ifdefs for this)
>
> I've got a solution for IO pin multiplexing that I have to get pushed
> in using the "feature_call" method like a pmac.  The other thing
> to realize here is there is often hardware beyond just "pin muxing"
> that is unique to a board and requires configuration.  Statically
> describing what pins set/clear is a small, and already understood
> part, of more complex set up that needs to be done with code
> unique to a board.

still waiting :)

>> * which (if any) BRG a channel is using?
>
> These are already a dynamically allocated resource.  Drivers
> don't care which one is assigned, you should be allocating
> one and using the handle provided to the support functions.

Ok, good.

>> * ...? [I feel like I'm missing some but haven't worked on a CPM
>> driver in a while :)]
>
> I can't think of any, and I use the CPM all of the time.  :-)
>
>> The other question is what changes between CPUs?
>
> Almost nothing, except the PRAM offset you mention below
> and I've mentioned in past messages as memory bank differences.
>
>> * Number/Mix of channels
>> * some PRAM offset (8272 FCC comes to mind)
>> * channel differences for same channel type? (what's an example of
>> this?)
>> * ...?
>
> Don't be creating problems to solve because we seem to have
> a solution for _something_.  Yes, this would be a cute piece of code
> to write and interesting driver updates, but in the end all we have
> is change for the sake of change, without adding any new features.

I'm hopefully not suggesting that or at least not something I see as  
this extensive.

> The thing to remember is the few public Linux drivers we have
> take little advantage of the CPM features.  We just configure a few
> fixed standard modes (like serial and Ethernet).  The CPM is far
> more powerful and flexible than this, so it seems silly to create some
> complex method of describing our trivial fixed modes that has no
> hope of actually being useful for "real" CPM usage.  Then, when
> someone does write a more complex driver, we have all of this
> "framework" that just gets in the way instead of being useful.

I know.

I guess what I'd suggest is something that makes letting the kernel  
know about serial & enet usage on the CPM is the extent to take this  
to start with.  If in time we have more drivers for more things  
great, then extend it then.  I dont see any reason we can't leverage  
the flat-dev-tree to have a single way to describe the serial & enet  
configs for a board.

I see how you can see this as duplication of a solved problem.   
However, we need some place to describe some basic config info that  
we have in arch/ppc for arch/powerpc and flat-dev/.dts is that  
mechanism.  While we are moving it out of the kernel proper, I think  
the idea is that over time using the flat-dev tree will allow the  
information we have to be described in one place and shared between  
kernel & firmware.

(and if Vitaly finishes this off we can beat him up to add kgdb  
support back to cpm_uart :)

- kumar
