Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E25F1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 20:40:56 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so66653391igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 03:40:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
References: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
Date: Mon, 10 Aug 2015 13:40:53 +0300
Message-ID: <CAJ2oMhJVqph9vb=Q-vbzRRygT+s3wvtm9nVNJ9TLcB_6iQCVcA@mail.gmail.com>
Subject: Re: using general IRQs
From: Ran Shalit <ranshalit@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 10:48 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
> MPC8349 has general IRQ numbered 0-7,
> It is required to bind these IRQs with some routine , i.e. they are
> not used with any specific driver.
>
> - Should they be configured as gpios in device tree so that we can use
> the gpio as irq in linux ? Is there any example ?
> - After configuration, can the gpios be used in linux using the
> standard /sys/class/gpio ?
>
> Regards,
> Ran

I am trying to use only IRQ4, so I have tried to configure it as
following in device tree:

device tree:

  intc@0{
 compatible = "intc";
 #address-cells = <1>;
 #size-cells = <0>;
 reg = <0 0x1000>;
 interrupts = <4 0x8>;
  };

But I don't see IRQ4 listed in the interrupt list:
# cat /proc/interrupts
           CPU0
 16:         93      IPIC   9 Level     serial
 18:          0      IPIC  14 Level     i2c-mpc
 19:          0      IPIC  15 Level     i2c-mpc
 21:          0      IPIC  18 Level     phy_interrupt
 32:          0      IPIC  32 Level     eth0_g0_tx
 33:         14      IPIC  33 Level     eth0_g0_rx
 34:          0      IPIC  34 Level     eth0_g0_er
 35:          0      IPIC  35 Level     eth1_g0_tx
 36:          0      IPIC  36 Level     eth1_g0_rx
 37:          0      IPIC  37 Level     eth1_g0_er
LOC:      60756   Local timer interrupts for timer event device
LOC:          1   Local timer interrupts for others
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions


Regards,
Ran
