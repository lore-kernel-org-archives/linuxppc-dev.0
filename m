Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0Zt3nzfzF1ps
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:03:50 +1100 (AEDT)
In-Reply-To: <20180209120732.17863-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: devicetree@vger.kernel.org,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-gpio@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 1/4] powerpc: wii: Explicitly configure GPIO owner for poweroff pin
Message-Id: <40D0Zr5ldZz9s2b@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-02-09 at 12:07:28 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Hollywood chipset's GPIO controller has two sets of registers: One
> for access by the PowerPC CPU, and one for access by the ARM coprocessor
> (but both are accessible from the PPC because the memory firewall
> (AHBPROT) is usually disabled when booting Linux, today).
> 
> The wii_power_off function currently assumes that the poweroff GPIO pin
> is configured for use via the ARM side, but the upcoming GPIO driver
> configures all pins for use via the PPC side, breaking poweroff.
> 
> Configure the owner register explicitly in wii_power_off to make
> wii_power_off work with and without the new GPIO driver.
> 
> I think the Wii can be switched to the generic gpio-poweroff driver,
> after the GPIO driver is merged.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Patches 1, 3 and 4 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9cbaaec1cf0c9f4861c4c1dd65f3ed

cheers
