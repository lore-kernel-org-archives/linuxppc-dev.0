Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A9A7B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 02:11:49 +1000 (EST)
Message-ID: <4FCE2FB8.9080307@freescale.com>
Date: Tue, 5 Jun 2012 11:11:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup event
 source
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain> <4FCD3E8B.30805@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2012 11:08 PM, Li Yang-R58472 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, June 05, 2012 7:03 AM
>> To: Zhao Chenhui-B35336
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
>> galak@kernel.crashing.org; Li Yang-R58472
>> Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup
>> event source
>>
>> On 06/04/2012 06:36 AM, Zhao Chenhui wrote:
>>> On Fri, Jun 01, 2012 at 05:08:52PM -0500, Scott Wood wrote:
>>>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
>>>>> +int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool enable)
>>>>
>>>> Why does it have to be a platform_device?  Would a bare device_node
>> work
>>>> here?  If it's for stuff like device_may_wakeup() that could be in a
>>>> platform_device wrapper function.
>>>
>>> It does not have to be a platform_device. I think it can be a struct
>> device.
>>
>> Why does it even need that?  The low level mechanism for influencing
>> PMCDR should only need a device node, not a Linux device struct.
> 
> It does no harm to pass the device structure and makes more sense for object oriented interface design. 

It does do harm if you don't have a device structure to pass, if for
some reason you found the device by directly looking for it rather than
going through the device model.

>>>> Who is setting can_wakeup for these devices?
>>>
>>> The device driver is responsible to set can_wakeup.
>>
>> How would the device driver know how to set it?  Wouldn't this depend on
>> the particular SoC and low power mode?
> 
> It is based on the "fsl,magic-packet" and "fsl,wake-on-filer" device tree properties.

fsl,magic-packet was a mistake.  It is equivalent to checking the
compatible for etsec.  It does not convey any information about whether
the eTSEC is still active in a given low power mode.

How is fsl,wake-os-filer relevant to this decision?  When will it be set
but not fsl,magic-packet?

What about devices other than ethernet?  What about differences between
ordinary sleep and deep sleep?

-Scott
