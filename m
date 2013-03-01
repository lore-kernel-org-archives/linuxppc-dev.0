Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79FCB2C029C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 14:08:56 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 08:36:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A7CDB1258052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 08:39:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2138hTp33882302
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 08:38:44 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2138lnp026740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 14:08:48 +1100
Message-ID: <1362107325.2712.2.camel@localhost>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
From: Mike <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Mar 2013 11:08:45 +0800
In-Reply-To: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all

Any comments? or any questions about my patchset?

Thanks
Mike
在 2013-01-15二的 15:38 +0800，Mike Qiu写道：
> Currently, multiple MSI feature hasn't been enabled in pSeries,
> These patches try to enbale this feature.
> 
> These patches have been tested by using ipr driver, and the driver patch
> has been made by Wen Xiong <wenxiong@linux.vnet.ibm.com>:
> 
> [PATCH 0/7] Add support for new IBM SAS controllers
> 
> Test platform: One partition of pSeries with one cpu core(4 SMTs) and 
>                RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) in POWER7
> OS version: SUSE Linux Enterprise Server 11 SP2  (ppc64) with 3.8-rc3 kernel 
> 
> IRQ 21 and 22 are assigned to the ipr device which support 2 mutiple MSI.
> 
> The test results is shown by 'cat /proc/interrups':
>           CPU0       CPU1       CPU2       CPU3       
> 16:     240458     261601     226310     200425      XICS Level     IPI
> 17:          0          0          0          0      XICS Level     RAS_EPOW
> 18:         10          0          3          2      XICS Level     hvc_console
> 19:     122182      28481      28527      28864      XICS Level     ibmvscsi
> 20:        506    7388226        108        118      XICS Level     eth0
> 21:          6          5          5          5      XICS Level     host1-0
> 22:        817        814        816        813      XICS Level     host1-1
> LOC:     398077     316725     231882     203049   Local timer interrupts
> SPU:       1659        919        961        903   Spurious interrupts
> CNT:          0          0          0          0   Performance
> monitoring interrupts
> MCE:          0          0          0          0   Machine check exceptions
> 
> Mike Qiu (3):
>   irq: Set multiple MSI descriptor data for multiple IRQs
>   irq: Add hw continuous IRQs map to virtual continuous IRQs support
>   powerpc/pci: Enable pSeries multiple MSI feature
> 
>  arch/powerpc/kernel/msi.c            |    4 --
>  arch/powerpc/platforms/pseries/msi.c |   62 ++++++++++++++++++++++++++++++++-
>  include/linux/irq.h                  |    4 ++
>  include/linux/irqdomain.h            |    3 ++
>  kernel/irq/chip.c                    |   40 ++++++++++++++++-----
>  kernel/irq/irqdomain.c               |   61 +++++++++++++++++++++++++++++++++
>  6 files changed, 158 insertions(+), 16 deletions(-)
> 
