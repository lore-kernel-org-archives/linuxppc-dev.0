Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97AB3B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 09:02:45 +1000 (EST)
Message-ID: <4FCD3E8B.30805@freescale.com>
Date: Mon, 4 Jun 2012 18:02:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup event
 source
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain>
In-Reply-To: <20120604113609.GC20676@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2012 06:36 AM, Zhao Chenhui wrote:
> On Fri, Jun 01, 2012 at 05:08:52PM -0500, Scott Wood wrote:
>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
>>> Add APIs for setting wakeup source and lossless Ethernet in low power modes.
>>> These APIs can be used by wake-on-packet feature.
>>>
>>> Signed-off-by: Dave Liu <daveliu@freescale.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> Signed-off-by: Jin Qing <b24347@freescale.com>
>>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
>>> ---
>>>  arch/powerpc/sysdev/fsl_pmc.c |   71 ++++++++++++++++++++++++++++++++++++++++-
>>>  arch/powerpc/sysdev/fsl_soc.h |    9 +++++
>>>  2 files changed, 79 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
>>> index 1dc6e9e..c1170f7 100644
>>> --- a/arch/powerpc/sysdev/fsl_pmc.c
>>> +++ b/arch/powerpc/sysdev/fsl_pmc.c
>>> @@ -34,6 +34,7 @@ struct pmc_regs {
>>>  	__be32 powmgtcsr;
>>>  #define POWMGTCSR_SLP		0x00020000
>>>  #define POWMGTCSR_DPSLP		0x00100000
>>> +#define POWMGTCSR_LOSSLESS	0x00400000
>>>  	__be32 res3[2];
>>>  	__be32 pmcdr;
>>>  };
>>> @@ -43,6 +44,74 @@ static unsigned int pmc_flag;
>>>  
>>>  #define PMC_SLEEP	0x1
>>>  #define PMC_DEEP_SLEEP	0x2
>>> +#define PMC_LOSSLESS	0x4
>>> +
>>> +/**
>>> + * mpc85xx_pmc_set_wake - enable devices as wakeup event source
>>> + * @pdev: platform device affected
>>> + * @enable: True to enable event generation; false to disable
>>> + *
>>> + * This enables the device as a wakeup event source, or disables it.
>>> + *
>>> + * RETURN VALUE:
>>> + * 0 is returned on success
>>> + * -EINVAL is returned if device is not supposed to wake up the system
>>> + * Error code depending on the platform is returned if both the platform and
>>> + * the native mechanism fail to enable the generation of wake-up events
>>> + */
>>> +int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool enable)
>>
>> Why does it have to be a platform_device?  Would a bare device_node work
>> here?  If it's for stuff like device_may_wakeup() that could be in a
>> platform_device wrapper function.
> 
> It does not have to be a platform_device. I think it can be a struct device.

Why does it even need that?  The low level mechanism for influencing
PMCDR should only need a device node, not a Linux device struct.

>> Where does this get called from?  I don't see an example user in this
>> patchset.
> 
> It will be used by a gianfar related patch. I plan to submit that patch
> after these patches accepted.

It would be nice to see how this is used when reviewing this.

>>> +{
>>> +	int ret = 0;
>>> +	struct device_node *clk_np;
>>> +	u32 *prop;
>>> +	u32 pmcdr_mask;
>>> +
>>> +	if (!pmc_regs) {
>>> +		pr_err("%s: PMC is unavailable\n", __func__);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (enable && !device_may_wakeup(&pdev->dev))
>>> +		return -EINVAL;
>>
>> Who is setting can_wakeup for these devices?
> 
> The device driver is responsible to set can_wakeup.

How would the device driver know how to set it?  Wouldn't this depend on
the particular SoC and low power mode?

-Scott
