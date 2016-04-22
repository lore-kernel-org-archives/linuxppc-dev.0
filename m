Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrmC63pxfzDqcc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:37:54 +1000 (AEST)
Message-ID: <1461307072.2646.4.camel@russell.cc>
Subject: Re: [PATCH 2/3] powerpc/eeh: Restore config from edev in
 eeh_pe_reset_and_recover()
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, mpe@ellerman.id.au
Date: Fri, 22 Apr 2016 16:37:52 +1000
In-Reply-To: <1461239595-5627-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461239595-5627-2-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Thu, 2016-04-21 at 21:53 +1000, Gavin Shan wrote:
> The function eeh_pe_reset_and_recover() is used to recover EEH
> error when the passthrou device are transferred to guest and
> backwords. The content in the device's config space will be lost

Spelling, as before :)

> on PE reset issued in the middle of the recovery. The function
> saves/restores it before/after the reset. However, config access
> to some adapters like Broadcom BCM5719 at this point will causes
> fended PHB. The config space is always blocked and we save 0xFF's

"fended" should be "fenced"

> that are restored at late point. The memory BARs are totally
> corrupted, causing another EEH error upon access to one of the
> memory BARs.
> 
> This restores the config space from the content saved to the
> EEH device when it's populated, to resolve above issue.
> 
> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Cc: stable@vger.kernel.org #v3.18+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
