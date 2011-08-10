Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 32C74B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 04:16:39 +1000 (EST)
Message-ID: <4E42CB01.7030700@grandegger.com>
Date: Wed, 10 Aug 2011 20:16:33 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v11 4/5] powerpc: Add flexcan device support for p1010rdb.
References: <1312993670-23999-1-git-send-email-holt@sgi.com>	<1312993670-23999-5-git-send-email-holt@sgi.com>
	<8E5FA886-038D-4DF4-8A54-DD60188A21A2@kernel.crashing.org>
In-Reply-To: <8E5FA886-038D-4DF4-8A54-DD60188A21A2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2011 07:01 PM, Kumar Gala wrote:
> 
> On Aug 10, 2011, at 11:27 AM, Robin Holt wrote:
> 
>> I added a simple clock source for the p1010rdb so the flexcan driver
>> could determine a clock frequency.  The p1010 flexcan device only has
>> an oscillator of system bus frequency divided by 2.
>>
>> Signed-off-by: Robin Holt <holt@sgi.com>
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
>> Cc: U Bhaskar-B22300 <B22300@freescale.com>
>> Cc: socketcan-core@lists.berlios.de,
>> Cc: netdev@vger.kernel.org,
>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/platforms/85xx/Kconfig    |    2 +
>> arch/powerpc/platforms/85xx/Makefile   |    2 +
>> arch/powerpc/platforms/85xx/clock.c    |   52 ++++++++++++++++++++++++++++++++
>> arch/powerpc/platforms/85xx/p1010rdb.c |    8 +++++
>> 4 files changed, 64 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/platforms/85xx/clock.c
> 
> I dont understand how mpc85xx_clk_functions() ends up being associated with the frequency the flexcan is running at.

The function mpc85xx_clk_get_rate() returns "fsl_get_sys_freq() / 2" for
Flexcan devices.

> This either seems to global or I'm missing something.

This patch extends the existing Flexcan platform driver for ARM for the
PowerPC using the device tree. Due to the nice integration of the device
tree (of-platform) into the platform driver and devices, the difference
are quite small (see patches 1..3). Apart from the endianess issue, only
the clock needs to be handled in a common way. As ARM already uses the
clk interface, we found it straight-forward to implement it for the
P1010, or more general for the 85xx, as well, instead of using an
additional helper function.

> I still think the clk / freq info should be in the device tree and handled in the driver and NOT arch/powerpc platform code.

If I understand you correctly, you want the boot-loader to provide the
relevant information by fixing up the device tree, which then can be
handled arch-independently by the driver, right?

Wolfgang.
