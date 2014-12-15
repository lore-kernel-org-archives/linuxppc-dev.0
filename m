Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 753771A00FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 10:32:06 +1100 (AEDT)
Message-ID: <1418686323.3241.1.camel@ellerman.id.au>
Subject: Re: [PATCH 7/7] CXL: Unmap MMIO regions when detaching a context
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Tue, 16 Dec 2014 10:32:03 +1100
In-Reply-To: <1418613792-sup-5165@delenn.ozlabs.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
 <1418613792-sup-5165@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, mikey <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-15 at 14:32 +1100, Ian Munsie wrote:
> Excerpts from Ian Munsie's message of 2014-12-08 19:18:01 +1100:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > If we need to force detach a context (e.g. due to EEH or simply force
> > unbinding the driver) we should prevent the userspace contexts from
> > being able to access the Problem State Area MMIO region further, which
> > they may have mapped with mmap().
> > 
> > This patch unmaps any mapped MMIO regions when detaching a userspace
> > context.
> 
> Might want to drop this one for now - Philippe found that it sometimes
> causes an issue when multiple contexts are using the afu. Seems that
> unmap_mapping_range() unmapped a bit more than I expected.

Sorry, it's already in next.

https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=next&id=b123429e6a9e8d03aacf888d23262835f0081448

Send me a revert or a fixup.

cheers
