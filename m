Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A196F1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 18:14:01 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7707D1402AC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 18:14:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 18:14:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2E61E2CE8040
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 18:13:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L8DnM74456726
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 18:13:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L8DN3G015770
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 18:13:23 +1000
Message-ID: <55ADFF10.7030304@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 13:43:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V3] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
References: <1436775366-21945-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1436775366-21945-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2015 01:46 PM, Anshuman Khandual wrote:
> This patch enables facility unavailable exceptions for generic facility,
> FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
> newly added IRQ statistical counters as and when these exceptions happen.
> This also adds couple of helper functions which will be called from within
> the interrupt handler context to update their statistics. Similarly this
> patch also enables alignment and program check exceptions as well.
> 
> 	With this patch being applied, /proc/interrupts looks something
> like this after running various workloads which create these exceptions.
> 
> --------------------------------------------------------------
>            CPU0       CPU1
>  16:       5734      24129      XICS   2 Level     IPI
>  17:          0          0      XICS 4101 Level     virtio0
>  18:          0          0      XICS 4100 Level     ohci_hcd:usb1
>  19:      13920          0      XICS 4099 Level     virtio1
>  20:          0          0      XICS 4096 Level     RAS_EPOW
>  21:       6160       3241      XICS 4102 Level     ibmvscsi
>  22:          1          0      XICS 4103 Level     hvc_console
> LOC:       6825       3556   Local timer interrupts for timer event device
> LOC:         22         41   Local timer interrupts for others
> SPU:          1          0   Spurious interrupts
> PMI:          0          0   Performance monitoring interrupts
> MCE:          0          0   Machine check exceptions
> DBL:          0          0   Doorbell interrupts
> ALN:          0          0   Alignment exceptions
> PRG:          0          0   Program check exceptions
> FAC:          7         14   Facility unavailable exceptions
> FPU:       2928       3162   FPU unavailable exceptions
> ALT:      12950      15536   AltiVec unavailable exceptions
> VSX:      12930     220183   VSX unavailable exceptions
> --------------------------------------------------------------
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V3:
> - Changed the display string from "ALTIVEC" to "AltiVec"
> - Now captured "Facility unavailable exceptions" in the example

Michael/Mikey,

I had already posted the performance comparison details with the
patch in the previous version mail thread. Does this new version
look good enough ?
