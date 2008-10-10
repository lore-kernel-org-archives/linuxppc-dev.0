Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A0120DE648
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:45:47 +1100 (EST)
Date: Fri, 10 Oct 2008 18:45:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO
	expander driver
Message-ID: <20081010144545.GA956@oksana.dev.rtsoft.ru>
References: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
	<683C10AE-E5F2-4196-B2C7-1E1CC317EC24@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <683C10AE-E5F2-4196-B2C7-1E1CC317EC24@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 09:22:02AM -0500, Kumar Gala wrote:
>
> On Sep 23, 2008, at 9:13 AM, Anton Vorontsov wrote:
>
>> On MPC8349E-mITX, MPC8315E-RDB and MPC837x-RDB boards there is a
>> Freescale MC9S08QG8 (MCU) chip with the custom firmware
>> pre-programmed. The chip is used to power-off the board by the
>> software, and to control some GPIO pins.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/i2c/chips/Kconfig            |   11 ++
>> drivers/i2c/chips/Makefile           |    1 +
>> drivers/i2c/chips/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++++++ 
>> +++++++++
>> 3 files changed, 221 insertions(+), 0 deletions(-)
>> create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c
>
> is the plan to connect ppc_md.machine_shutdown() with this?

You mean poweroff? It's already connected.

+       /* XXX: this is potentially racy, but there is no lock for ppc_md */
+       if (!ppc_md.power_off) {
+               glob_mcu = mcu;
+               ppc_md.power_off = mcu_power_off;
+               dev_info(&client->dev, "will provide power-off service\n");
+       }

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
