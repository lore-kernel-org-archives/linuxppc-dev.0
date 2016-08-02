Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Nbx1s7mzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:33:01 +1000 (AEST)
Message-ID: <1470112376.13482.1.camel@russell.cc>
Subject: Re: [PATCH 1/9] powerpc/powernv: Pass CPU-endian PE number to
 opal_pci_eeh_freeze_clear()
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Date: Tue, 02 Aug 2016 14:32:56 +1000
In-Reply-To: <1470111037-18531-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1470111037-18531-2-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Tue, 2016-08-02 at 14:10 +1000, Gavin Shan wrote:
> The PE number (@frozen_pe_no), filled by opal_pci_next_error() is in
> big-endian format. It should be converted to CPU-dian before it is
> passed to opal_pci_eeh_freeze_clear() when clearing the frozen state
> if the PE is invalid one. As Michael Ellerman pointed out, the issue
> is also detected by sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                     arch/powerpc/platforms/powernv/eeh-powernv.o
>       :
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   warning: incorrect type in argument 2 (different base types)
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   expected unsigned long long [unsigned] [usertype] pe_number
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   got restricted __be64 [addressable] [usertype] frozen_pe_no
> 
> This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
> it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
> printed PE number"), which was merged to 4.3 kernel.
> 
> Fixes: 71b540adffd9 ("powerpc/powernv: Don't escalate non-existing frozen PE")
> Cc: stable@vger.kernel.org # v4.3+
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
