Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03AB11A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 16:44:28 +1000 (AEST)
Message-ID: <1436769860.3948.193.camel@kernel.crashing.org>
Subject: Re: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 13 Jul 2015 16:44:20 +1000
In-Reply-To: <559EF557.4040403@xenosoft.de>
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de> <559EF557.4040403@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-10 at 00:27 +0200, Christian Zigotzky wrote:
> Hi All,
> 
> Many thanks for your help. You're right. It was something wrong with my 
> last bisect. I did another bisect. I evaluated the one "sometimes boots" 
> with good.

 .../...

Now that makes more sense since the problem is around IRQ handling...
more specifically the SB600 code, so I suspect it's your SB600 patch
that has an issue. Look at how that series from Jiang modified the
irq handlers and see if the sb600 patch needs a similar change maybe ?

Ben.

> 
> Output:
> 0d0b4c866bcce647f40d73efe5e90aeeb079050a is the first bad commit
> commit 0d0b4c866bcce647f40d73efe5e90aeeb079050a
> Author: Jiang Liu <jiang.liu@linux.intel.com>
> Date:   Mon Jun 1 16:05:12 2015 +0800
> 
>      genirq: Introduce struct irq_common_data to host shared irq data
> 
>      With the introduction of hierarchy irqdomain, struct irq_data becomes
>      per-chip instead of per-irq and there may be multiple irq_datas
>      associated with the same irq. Some per-irq data stored in struct
>      irq_data now may get duplicated into multiple irq_datas, and causes
>      inconsistent view.
> 
>      So introduce struct irq_common_data to host per-irq common data and to
>      achieve consistent view among irq_chips.
> 
>      Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>      Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>      Cc: Tony Luck <tony.luck@intel.com>
>      Cc: Bjorn Helgaas <bhelgaas@google.com>
>      Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>      Cc: Randy Dunlap <rdunlap@infradead.org>
>      Cc: Yinghai Lu <yinghai@kernel.org>
>      Cc: Borislav Petkov <bp@alien8.de>
>      Cc: Jason Cooper <jason@lakedaemon.net>
>      Cc: Kevin Cernekee <cernekee@gmail.com>
>      Cc: Arnd Bergmann <arnd@arndb.de>
>      Cc: Marc Zyngier <marc.zyngier@arm.com>
>      Link: 
> http://lkml.kernel.org/r/1433145945-789-4-git-send-email-jiang.liu@linux.intel.com
>      Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> :040000 040000 4cb60e0b1d4beb046834e75c66b5d0a0613935b9 
> df0b465b70ec087560482267cca2d9ff54d92c49 M    include
> :040000 040000 3808922cd797449f8f9b33300064a2ff1727f3a6 
> 25a75bf65be0ba9e397151de0ed1beb1695fddb2 M    kernel
> 
> ----
> 
> Rgds,
> 
> Christian
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
