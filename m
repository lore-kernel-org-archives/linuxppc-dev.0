Return-Path: <R58495@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 52D382C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 01:38:05 +1000 (EST)
Message-ID: <51EEA34A.9050400@freescale.com>
Date: Tue, 23 Jul 2013 08:37:46 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] power/mpc85xx: Add delay after enabling I2C master
References: <1368480428-23926-1-git-send-email-yorksun@freescale.com>
 <20130723003330.GA14649@home.buserror.net>
In-Reply-To: <20130723003330.GA14649@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: albrecht.dress@arcor.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 05:33 PM, Scott Wood wrote:
> On Mon, May 13, 2013 at 02:27:08PM -0700, York Sun wrote:
>> Erratum A-006037 indicates I2C controller executes the write to I2CCR only
>> after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
>> during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
>> 0), then the controller could end in bad state, and hang the future access
>> to I2C register.
>>
>> The mpc_i2c_fixup() function tries to recover the bus from a stalled state
>> where the 9th clock pulse wasn't generated. However, this workaround
>> disables and enables I2C controller without meeting waiting requirement of
>> this erratum.
>>
>> This erratum applies to some 85xx SoCs. It is safe to apply to all of them
>> for mpc_i2c_fixup().
>>
>> Signed-off-by: York Sun <yorksun@freescale.com>
>>
>> ---
>> I'd like to get rid of the #ifdef if mpc5121 is OK with the longer delay.
> 
> Are mpc5121 and mpc85xx the only things that use this?

No. 83xx and 86xx also uses this file. But I am only unsure if mpc52xx
is OK with this extended delay. I guess they are but I don't have a
proof, or someone to confirm.

> 
> Are you sure the delay always works out to be longer?  What is the
> relationship between fsl_get_sys_freq() and i2c->real_clk?

Yes. The max divider from sys clock to i2c clcok is 32K. i2c->real_clk
is the clock I2C controller pumps out, not its internal operation clock.

> 
> In any case, you should send this patch to the i2c maintainer and list.
> 

I don't have the name on top of my head. Is that linux-i2c@vger.kernel.org?

York
