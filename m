Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id EE1D6B6EF4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 23:16:32 +1100 (EST)
Message-ID: <4B5996DC.1020309@grandegger.com>
Date: Fri, 22 Jan 2010 13:15:24 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-5-git-send-email-agust@denx.de>
	<fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107@mail.gmail.com>
In-Reply-To: <fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Anatolij Gustschin <agust@denx.de>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
>> From: Piotr Ziecik <kosmo@semihalf.com>
>>
>>    - Update Kconfig for i2c-mpc driver.
>>    - Enable I2C interrupts on MPC5121.
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index f627001..84eeb25 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
>>                }
>>        }
>>
>> +       if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c")) {
> 
> Rather than doing stuff like this with explicit compatible checks in
> the probe hook, consider using the .data pointer in the of match
> table.

Yes, and it does also not use the clock setting code of the MPC5200,
which should work for the MPC512x as well. I already have a patch in my
pipeline, which I will roll out after some more testing.

Wolfgang.
