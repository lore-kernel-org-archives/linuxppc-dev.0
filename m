Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3348710087B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 02:02:32 +1000 (EST)
Message-ID: <4FEDD07D.3090103@freescale.com>
Date: Fri, 29 Jun 2012 10:57:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
In-Reply-To: <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2012 10:39 AM, Tabi Timur-B04825 wrote:
> On Tue, Jun 26, 2012 at 5:25 AM, Zhao Chenhui
> <chenhui.zhao@freescale.com> wrote:
>> +static void mpc85xx_give_timebase(void)
>> +{
>> +       unsigned long flags;
>> +
>> +       local_irq_save(flags);
>> +
>> +       while (!tb_req)
>> +               barrier();
> 
> I think tb_req and tb_valid need to be 'volatile'.

No, barrier() and mb() take care of that.

>> +static const struct of_device_id mpc85xx_smp_guts_ids[] = {
>> +       { .compatible = "fsl,mpc8572-guts", },
>> +       { .compatible = "fsl,p1020-guts", },
>> +       { .compatible = "fsl,p1021-guts", },
>> +       { .compatible = "fsl,p1022-guts", },
>> +       { .compatible = "fsl,p1023-guts", },
>> +       { .compatible = "fsl,p2020-guts", },
>> +       {},
>> +};
> 
> I wonder if it's possible to dynamically generate the compatible
> string by using the SOC name?

Where are you going to get the SoC name from?

-Scott
