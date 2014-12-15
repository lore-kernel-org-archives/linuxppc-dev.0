Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10E701A025E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 14:32:27 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D4EFB1400DD
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2014 14:32:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 15 Dec 2014 13:32:25 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: Re: [PATCH 7/7] CXL: Unmap MMIO regions when detaching a context
In-reply-to: <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
Date: Mon, 15 Dec 2014 14:32:18 +1100
Message-Id: <1418613792-sup-5165@delenn.ozlabs.ibm.com>
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

Excerpts from Ian Munsie's message of 2014-12-08 19:18:01 +1100:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If we need to force detach a context (e.g. due to EEH or simply force
> unbinding the driver) we should prevent the userspace contexts from
> being able to access the Problem State Area MMIO region further, which
> they may have mapped with mmap().
> 
> This patch unmaps any mapped MMIO regions when detaching a userspace
> context.

Might want to drop this one for now - Philippe found that it sometimes
causes an issue when multiple contexts are using the afu. Seems that
unmap_mapping_range() unmapped a bit more than I expected.

Cheers,
-Ian
