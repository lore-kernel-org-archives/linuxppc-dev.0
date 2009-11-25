Return-Path: <albert_herranz@yahoo.es>
Received: from smtp123.mail.ukl.yahoo.com (smtp123.mail.ukl.yahoo.com
	[77.238.184.54]) by ozlabs.org (Postfix) with SMTP id 2D09BB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:58:34 +1100 (EST)
Message-ID: <4B0D7047.3000803@yahoo.es>
Date: Wed, 25 Nov 2009 18:58:31 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 18/19] powerpc: wii: platform support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
	<89DF2875-BF4F-4DE1-AB18-C09DFFABCA00@kernel.crashing.org>
In-Reply-To: <89DF2875-BF4F-4DE1-AB18-C09DFFABCA00@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c
>> b/arch/powerpc/platforms/embedded6xx/wii.c
> 
>> +#define DRV_MODULE_NAME "rvl"
> 
> Should this be "wii"?
> 

Ok. I'm fine with both.

>> +static enum starlet_ipc_flavour starlet_ipc_flavour;
>> +
>> +enum starlet_ipc_flavour starlet_get_ipc_flavour(void)
>> +{
>> +    return starlet_ipc_flavour;
>> +}
> 
> This can go I think, unless you plan on supporting something else than
> mini?
> 

See comment in previous message.
Irrespective of supporting other firmwares, we need to know the one we are running under.

>> +#ifdef CONFIG_STARLET_MINI
>> +
>> +#define HW_RESETS_OF_COMPATIBLE    "nintendo,hollywood-resets"
>> +#define HW_GPIO_ALIAS        "hw_gpio
> 
> This should be unconditional now I think?  You access the hardware
> directly.
> 

Yes, at this stage direct hardware should be possible, but only if 'mini' support is compiled-in (which will be the default option at this stage).
We can either leave the conditionals as is now, or remove them and add them later if we support more than one firmware flavour.

I'm fine with both options.

>> +    np = of_find_node_by_name(NULL, "aliases");
>> +    if (!np) {
>> +        pr_err("unable to find node %s\n", "aliases");
>> +        goto out;
>> +    }
>> +
>> +    path = of_get_property(np, HW_GPIO_ALIAS, NULL);
>> +    of_node_put(np);
>> +    if (!path) {
>> +        pr_err("alias %s unknown\n", HW_GPIO_ALIAS);
>> +        goto out;
>> +    }
> 
> Don't use an alias here, search for e.g. a matching "compatible" instead.
> 

I used an alias because I wanted explicitly the second GPIO word.

Is there another way to select a specific instance of repeated identical hardware?
We have two instances of gpios here, matching the same "compatible".

>> +static struct of_device_id wii_of_bus[] = {
>> +    { .compatible = "nintendo,hollywood", },
> 
> Like with Flipper, why a platform bus?
> 

See previous message.

>> +#ifdef CONFIG_STARLET_MINI
>> +    { .compatible = "twiizers,starlet-mini-ipc", },
>> +#endif
> 
> This one should go completely, I will have more to say about it when I get
> to review the device trees (saving those for last :-) ).
> 

Yes, this is not needed. I'll get rid of it.

Thanks a lot!
Albert
