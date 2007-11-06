Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CD9C4DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 01:23:04 +1100 (EST)
Message-ID: <47307879.5020405@ru.mvista.com>
Date: Tue, 06 Nov 2007 17:21:45 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] Add device-tree aware NDFC driver
References: <20071029201738.GA2022@ru.mvista.com>
	<alpine.LFD.0.9999.0710300235580.3186@localhost.localdomain>
	<47273BF4.80001@ru.mvista.com>
	<alpine.LFD.0.9999.0711042118460.3089@localhost.localdomain>
In-Reply-To: <alpine.LFD.0.9999.0711042118460.3089@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Gleixner wrote:
> Valentine,
>> You know, you're really too tense Thomas. I'm not sure of the reason why
>> you're being a complete nerve, but I'm feeling sorry for you.
> 
> You have a perception problem. I'm not tense, I'm grumpy.

:)

> 
> Rest assured, that my nerves are completely fine despite of the fact
> that you try to rack them.

That's good to hear :)

> 
>> I'm not saying my approach is the best, but I was hoping for a discussion.
>> I've reworked the patches according to the comments to the previous version
>> and used my arguments to explain why I don't see much reason to mess with the
>> code we currently have and added a separate _of version.
> 
> This is the exact point. You were asked to fix up the existing driver
> instead of replacing it and to do it with a series of incremental
> patches. You copied the old code anyway and modified it, so we want to
> have this documented in the history. This is not my obsession, it's
> common kernel coding practise. The fact that you do not see much
> reason to do it does not change this at all.

Replacing the original driver is not my obsession either.
I just don't see the "right" way to modify the original driver to 
support both platform devices and the new OF implementation. I see some 
initialization order problems with the original version, and I think 
that the easiest way to handle ndfc and chips attached to it would be to 
  do it in a single probe() function instead of having separate chip 
devices and a separate ndfc platform device on top of that.

So, my opinion is that modifying the original code involves ndfc users' 
modification. Considering the fact that ppc removal is scheduled for the 
next summer, I thought that we could leave the original version intact 
and build the new OF one.

I know the common kernel practice, but if we always followed it we'd 
never bring up arch/powerpc.
BTW, I've posted some of the ndfc questions to the MTD mailing list
(http://lists.infradead.org/pipermail/linux-mtd/2007-November/019769.html). 
If I had the answers I might get a more clear idea about the right way 
to do it. I'd appreciate if you could take a look.

> 
>> I'm sure you'd find some time to do it yourself "the right way once and
>> forever" with a "nice series of incremental patches" to fix what we currently
>> have (call it a "dump" or anything you like) and even maybe add new device
>> tree support.
> 
> It might be time for you to try to understand how OSS development
> works.

I do understand how it works.

> 
>> I'm sorry if for some reason I've made you feel bad.
> 
> What do you expect, after you abused my Signed-off-by in a way which
> might have tricked David into pulling your code as is? This was
> pointed out to you and you did not even bother to apologize.

I apologize.
If I wanted to abuse or trick somebody and get my code in as fast as 
possible no matter what, I wouldn't cc the maintainer, the other people 
interested and send it to both mtd and ppc mailing lists.
I don't see any possible way for a guy who hasn't worked with the MTD 
community much to trick someone and get his patches in.

> 
>> This is the last time I disturb you with my e-mail, so please, forget it.
> 
> Interesting. I thought you wanted to get the patch in, so you probably
> should ask yourself whether it is a good idea _not_ to talk to the
> responsible maintainer.

As I said above, I don't see the "right" way to do it. And actually I 
didn't expect you to share your thoughts and reasons on how to support 
both implementations and why this way is preferred. All I heard were 
cursing and direct orders to stop tying to explain my reasons and do it 
the "right" way. It looked like the responsible maintainer just wouldn't 
listen. Why talk then?

> 
> If you gave up on that, it just makes it more obvious that you do not
> want to work with the community and just wanted to dump your patch and
> move along.

I never give up ;) and I didn't say I was going to stop working with the 
community.

> 
>      tglx

Cheers,
Valentine.
