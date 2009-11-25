Return-Path: <albert_herranz@yahoo.es>
Received: from smtp128.mail.ukl.yahoo.com (smtp128.mail.ukl.yahoo.com
	[77.238.184.59]) by ozlabs.org (Postfix) with SMTP id 57931B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:47:18 +1100 (EST)
Message-ID: <4B0D6DA3.9060906@yahoo.es>
Date: Wed, 25 Nov 2009 18:47:15 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 17/19] powerpc: wii: bootmii starlet 'mini' firmware
	support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
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
	<BEFB28A5-8BA2-43F8-B917-0C838246B962@kernel.crashing.org>
In-Reply-To: <BEFB28A5-8BA2-43F8-B917-0C838246B962@kernel.crashing.org>
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
>> Add support for the BootMii 'mini' firmware replacement for the
>> Starlet processor.
>>
>> 'mini' is an open source IOS replacement written from scratch by
>> Team Twiizers.
> 
> It's not a replacement, it doesn't have any of the same functionality.
> 

I didn't know 'replacement' had that semantics. My intention was to say that 'mini' firmware is an alternative to the stock IOS firmware, not trying to imply that it behaves like it or it is compatible with it.
Point taken.

I'll use 'mini' alternate firmware if that's ok.

>> It grants full access to the hardware found on the
>> Nintendo Wii video game console via a custom IPC mechanism.
> 
> This is out of date, you get full register-level hardware access now.
> 

Yes, as I already said in one of my messages.
That description doesn't try to imply that you cannot access the hardware via other means. It describes what the IPC mechanism is about.

If the comment is misleading I can change the comment or enhance it.

> Do you want to mainline any of the drivers that work via mini proxy?
> If not, you can remove quite some bit of code here I think.
> 

Yes, that I already said too :)

>> +enum starlet_ipc_flavour {
>> +    STARLET_IPC_IOS,
>> +    STARLET_IPC_MINI,
>> +};
> 
> I thought you don't support IOS at all anymore?
> 

I don't plan to mainline IOS support.
But to make runtime decisions I need to know if we are running along the 'mini' firmware or the default IOS firmware.
That's the intention of that enum.

>> +config STARLET_MINI
>> +    bool "BootMii Starlet 'mini' firmware support"
>> +    depends on WII && EXPERIMENTAL
> 
> Given that this is the only supported starlet firmware interface,
> does it make sense to expose the option to the user?
> 

You're right. We can just select it until we have another alternate firmware and its support available.

> <big snip, see my "remove stuff" comment above>
> 
>> +static void mipc_init_ahbprot(struct mipc_device *ipc_dev)
>> +{
>> +    void __iomem *hw_ahbprot;
>> +    u32 initial_ahbprot, ahbprot = 0;
>> +
>> +    hw_ahbprot = mipc_get_hw_reg(HW_AHBPROT_OF_COMPATIBLE);
>> +    if (!hw_ahbprot)
>> +        goto done;
>> +
>> +    initial_ahbprot = mipc_readl(hw_ahbprot);
>> +    if (initial_ahbprot != 0xffffffff) {
>> +        pr_debug("AHBPROT=%08X (before)\n", initial_ahbprot);
>> +        /* enable full access from the PowerPC side */
>> +        mipc_writel(0xffffffff, hw_ahbprot);
>> +    }
>> +
>> +    ahbprot = mipc_readl(hw_ahbprot);
>> +    if (initial_ahbprot != ahbprot)
>> +        pr_debug("AHBPROT=%08X (after)\n", ahbprot);
>> +done:
>> +    if (ahbprot != 0xffffffff)
>> +        pr_err("failed to set AHBPROT\n");
>> +}
> 
> Modern mini will always have AHBPROT set up to give you full access,
> so this isn't needed either.
> 

So we have two options here:
- assume that whatever firmware is running properly sets AHBPROT and hope it works
- or try to use the existing firmware interfaces to check and make sure that AHBPROT is indeed properly set

I chose the second option here.

>> +#ifdef CONFIG_HLWD_PIC
>> +    /*
>> +     * Setup the Hollywood interrupt controller as soon as
>> +     * we detect that we are running under the mini firmware.
>> +     */
>> +    hlwd_pic_probe();
>> +#endif
> 
> Why?  The comment doesn't say.
> 

Same as before, we don't try to setup the Hollywood interrupt controller until we have verified that we can directly access the hardware.

> 
> Do you need this driver to boot?  If not, it might be best to leave it
> out for now.
> 

Strictly speaking, we don't need the driver to boot if we asume that AHBPROT is properly set.
But we'll need it later to shutdown 'mini' drivers, unless 'mini' is changed to boot PowerPC code with all hardware already relinquished.

That is not true for the last available version of 'mini' firmware. That version still boots PowerPC code with at least the SDHCI controller driven by 'mini'.
We need to issue a IPC_SDHC_EXIT to the firmware to force it to stop using the SDHCI controller.

Thanks,
Albert
