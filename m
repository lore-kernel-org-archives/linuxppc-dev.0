Return-Path: <pku.leo@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 745172C0185
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 16:48:54 +1000 (EST)
Received: by ggnk3 with SMTP id k3so50182ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 23:48:51 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2788@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1342411780-29930-1-git-send-email-qiang.liu@freescale.com>
 <5004244D.4000106@freescale.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2788@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Tue, 17 Jul 2012 14:48:51 +0800
Message-ID: <CADRPPNSHG-Gf=YvaC-WDRjkxrWc8awkoqP+tEVC3FkXVXFdSoA@mail.gmail.com>
Subject: Re: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
From: Li Yang <leoli@freescale.com>
To: Liu Qiang-B32616 <B32616@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Li Yang-R58472 <r58472@freescale.com>, Vinod Koul <vinod.koul@intel.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 12:23 PM, Liu Qiang-B32616 <B32616@freescale.com> wrote:
>> -----Original Message-----
>> From: Tabi Timur-B04825
>> Sent: Monday, July 16, 2012 10:25 PM
>> To: Liu Qiang-B32616
>> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Vinod
>> Koul; herbert@gondor.hengli.com.au; Dan Williams; Li Yang-R58472;
>> davem@davemloft.net
>> Subject: Re: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh
>> to instead of spin_lock_irqsave
>>
>> Qiang Liu wrote:
>> > Use spin_lock_bh to instead of spin_lock_irqsave for improving
>> performance.
>>
>> You forgot to include the evidence that performance has improved, as well
>> as an explanation why it's okay to use spin_lock_bh, and why it's faster.
>>   I told you to respin the patch with that information in the patch
>> description.
> I attached the test result in v3 0/4, performance is improved by 2%.
> For my understanding, there is not any place to access descriptor lists
> in fsl-dma interrupt service handler except its tasklet, spin_lock_bh()
> is born for this. Interrupts will be turned off and context will be save in
> irqsave, there is needless to use irqsave in our case. You can refer to the
> implement of mv_xor.c or ioap-adma.c.
> If you think my explanation is ok, I can add it in the patch.

Disabling bottom half is not faster than disabling the interrupt.  But
by using it we reduce the time when interrupt is disabled.  We can get
better real time performance in term of interrupt handling latency.

Leo
