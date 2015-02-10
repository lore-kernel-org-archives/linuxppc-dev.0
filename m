Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53B5B1A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 21:36:03 +1100 (AEDT)
Received: by labpn19 with SMTP id pn19so13327255lab.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:35:59 -0800 (PST)
Message-ID: <54D9DF2B.6000709@linux.com>
Date: Tue, 10 Feb 2015 13:36:27 +0300
From: Alexander Popov <alex.popov@linux.com>
Reply-To: alex.popov@linux.com
MIME-Version: 1.0
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: Disabled LocalPlus Controller (LPC) clock on MPC512x
References: <5475BE5A.4090503@linux.com> <547D98DF.9000708@sirius-es.it>
 <54901ED3.30207@linux.com> <5493F229.80605@sirius-es.it>
In-Reply-To: <5493F229.80605@sirius-es.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Matteo,
sorry for such a long delay in replying, now I have my board back again.

19.12.2014 12:38, Matteo Facchinetti пишет:
> On 16/12/2014 13:00, Alexander Popov wrote:
>> In fact clk_ignore_unused bootparam helps to avoid disabling NFC clock.
>> The board crash is reproduced again if I perform the following steps:
>> 1. disable NFC clock in uboot by clearing NFC_EN bit in SCCR1 register,
>> 2. boot Linux with clk_ignore_unused,
>> 3. touch any LPB address.
>
> Could you see the Reset Status Register (RSR) after board crash?
> When boad reset, you may stop uboot in console and then print the value
> of this register.
>
> This could be help to see what happen internally to the microcontroller.

I've reproduced TWR-MPC5125 crash without Linux only in uboot.
This is the annotated procedure:

=> md.l 0x80000e10  /* Reset Status Register */
80000e10: 60000000  /* All flags are cleared (just powered on) */

=> md.l 0x80000f04  /* System Clock Control Register 1 */
80000f04: e404b600  /* NFC clock is enabled */

=> md.l 0xfff00000  /* Reading from MRAM living at LPB CS0 */
fff00000: cafea134  /* Works fine */

=> mw.l 0x80000f04 0xc404b600 1 /* Disable NFC clock */

=> md.l 0x80000f04
80000f04: c404b600  /* NFC clock is disabled now */

=> md.l 0xfff00000  /* Reading from MRAM again */
fff00000:

/* The board has just reset */

U-Boot 2009.03-00004-gd37ab38 (Apr 14 2010 - 10:48:22) MPC512X
CPU:   MPC5125 rev. 1.0, Core e300c4 at 393.216 MHz, CSB at 196.608 MHz
...

=> md.l 0x80000e10  /* Read RSR */
80000e10: 60000040  /* Only external HRESET1 event has occurred */

But rising of EXT1HRS flag is not special for this crash.
EXT1HRS is similarly set if I execute 'reset' command in uboot
or call 'reboot' from Linux.

Thanks.

Best regards,
Alexander
