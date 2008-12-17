Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 31C4FDDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 04:10:14 +1100 (EST)
Date: Wed, 17 Dec 2008 20:10:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc: Implement GPIO driver for simple
	memory-mapped banks
Message-ID: <20081217171013.GA10240@oksana.dev.rtsoft.ru>
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192742.GB13035@oksana.dev.rtsoft.ru>
	<51466E9D-4D61-4864-8007-B54A61230F8F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <51466E9D-4D61-4864-8007-B54A61230F8F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 10:56:08AM -0600, Kumar Gala wrote:
>
> On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:
>
>> The driver supports very simple GPIO controllers, that is, when a
>> controller provides just a 'data' register. Such controllers may be
>> found in various BCSRs (Board's FPGAs used to control board's
>> switches, LEDs, chip-selects, Ethernet/USB PHY power, etc).
>>
>> So far we support only 1-byte GPIO banks. Support for other widths may
>> be implemented when/if needed.
>>
>> p.s.
>> To avoid "made up" compatible entries (like compatible = "simple- 
>> gpio"),
>> boards must call the simple_gpiochip_init() to pass the compatible
>> string.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> Documentation/powerpc/dts-bindings/fsl/board.txt |   30 ++++
>
> can we pull this out of this patch.

Will do.

[...]
>> +#ifdef CONFIG_SIMPLE_GPIO
>> +extern int simple_gpiochip_init(const char *compatible);
>> +#else
>> +static inline int simple_gpiochip_init(const char *compatible)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif /* CONFIG_SIMPLE_GPIO */
>> +
>> +#endif /* __SYSDEV_SIMPLE_GPIO_H */
>
> Can I call simple_gpiochip_init() multiple times w/different  
> compatibles?

Yes, sure.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
