Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EAD5CB7151
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 09:17:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AA53DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 09:17:01 +1000 (EST)
Message-Id: <ED53CEC4-BB2B-4878-BA2E-44C43DB54D7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244670419.29684.1600.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Date: Wed, 10 Jun 2009 18:16:56 -0500
References: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
	<EF23D631-7B02-40C4-9635-61213F7DD117@kernel.crashing.org>
	<1244670419.29684.1600.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 4:46 PM, Nate Case wrote:

> Hi Kumar,
>
> Thanks for the feedback.  Response below:
>
>>> +
>>> +	root = of_find_node_by_path("/");
>>> +	if (root == NULL)
>>> +		return;
>>> +
>>> +	model = of_get_property(root, "model", NULL);
>>> +	if (strncasecmp(model, "xes,", strlen("xes,")) != 0)
>>> +		return;
>>
>> What is this check for?
>
> Historical accident.  A while back we somehow ended up with a case of
> probe() succeeding when it shouldn't have, and this was the  
> workaround.
> I'll remove it since it's useless now.
>
>>> +
>>> +	printk(KERN_INFO "X-ES MPC85xx-based single-board computer: %s\n",
>>> +	       model + strlen("xes,"));
>>
>> Why not print the name from machine_id.name
>
> Because machine_id->name will give us "X-ES MPC8572" from the machine
> description rather than the actual board name (e.g., xpedite5370).
>
> In our situation, we have several boards that share largely the same
> hardware design.  I decided to just put 1 machine definition per
> processor rather than having a machine definition for every board  
> (which
> would get pretty crazy for our case).  For example, we have at least 6
> MPC8572-based boards with more on the way, but all of their changes  
> can
> be described in the device tree (e.g., changes in number of ethernet
> ports or PCI express controllers), so there's no need for a machine
> definition for all of them.
>
>>> +machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
>>> +machine_device_initcall(xes_mpc8548, xes_mpc85xx_publish_devices);
>>
>> Do you not need this for xes_mpc8540?
>
> Yes, thanks.  I'll fix this and the other things you mentioned and
> re-submit.  Will this be able to make it into your next tree destined
> for 2.6.31?

If it get submitted pretty soon I'd be willing to take it for .31.   
Also can you split the patch into 3 pieces (defconfig, .dts, and  
actual platform code)

- k
