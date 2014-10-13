Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF16A1A00E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 02:52:56 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xdhva-001hVe-6g
 for linuxppc-dev@lists.ozlabs.org; Mon, 13 Oct 2014 15:52:54 +0000
Message-ID: <543BF40D.80902@roeck-us.net>
Date: Mon, 13 Oct 2014 08:47:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/20] powerpc: Convert power off logic to pm_power_off
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2014 07:01 AM, Alexander Graf wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
>
> Today on PowerPC we set pm_power_off to invoke our generic full machine power
> off logic which then calls ppc_md.power_off to invoke machine specific power
> off.
>
> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
> this card house falls apart. That driver only registers itself if pm_power_off
> is NULL to ensure it doesn't override board specific logic. However, since we
> always set pm_power_off to the generic power off logic (which will just not
> power off the machine if no ppc_md.power_off call is implemented), we can't
> implement power off via the generic GPIO power off driver.
>
> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
> pm_power_off as was intended. Then individual drivers such as the GPIO power off
> driver can implement power off logic via that function pointer.
>
> With this patch set applied and a few patches on top of QEMU that implement a
> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
> machine after halt.
>
> Michael / Ben, you can find this patch set as a git branch at the URL below.
> When applying it, please use that one to ensure that Guenter can easily merge
> his work with my work.
>
>    git://github.com/agraf/linux-2.6.git pm_power_off-v2
>

Best for me would be if someone (you or Ben or Michael) could create an
immutable branch which contains the patch set as to be submitted to Linus,
with all signatures, so I can merge it into my poweroff branch. If possible
that branch should have a signed tag which I can merge, to ensure that
I don't merge anything bad.

If I just merge your branch, I would not get the maintainer signature(s),
nor would it have the final SHA. Both would obviously be less than desirable.

Thanks,
Guenter
