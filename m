Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id EC5FADDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:59:26 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so129422wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:59:25 -0800 (PST)
Message-ID: <9e4733910712201559k459ab574m74f7a84a637c8f0c@mail.gmail.com>
Date: Thu, 20 Dec 2007 18:59:25 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Version 17, series to add device tree naming to i2c
In-Reply-To: <20071220044136.20091.70984.stgit@terra.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Are there any other objections to this patch? If not, can it be
targeted for 2.6.25?

On 12/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Since copying i2c-mpc.c to maintain support for the ppc architecture seems to be an issue; instead rework i2c-mpc.c to use CONFIG_PPC_MERGE #ifdefs to support both the ppc and powerpc architecture. When ppc is deleted in six months these #ifdefs will need to be removed.
>
> Another rework of the i2c for powerpc device tree patch. This version implements standard alias naming only on the powerpc platform and only for the device tree names. The old naming mechanism of i2c_client.name,driver_name is left in place and not changed for non-powerpc platforms. This patch is fully capable of dynamically loading the i2c modules. You can modprobe in the i2c-mpc driver and the i2c modules described in the device tree will be automatically loaded. Modules also work if compiled in.
>
> The follow on patch to module-init-tools is also needed since the i2c subsystem has never implemented dynamic loading.
>
> The following series implements standard linux module aliasing for i2c modules on arch=powerpc. It then converts the mpc i2c driver from being a platform driver to an open firmware one. I2C device names are picked up from the device tree. Module aliasing is used to translate from device tree names into to linux kernel names. Several i2c drivers are updated to use the new aliasing.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Jon Smirl
jonsmirl@gmail.com
