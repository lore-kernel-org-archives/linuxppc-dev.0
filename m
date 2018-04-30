Return-Path: <clg@kaod.org>
Received: from 8.mo177.mail-out.ovh.net (8.mo177.mail-out.ovh.net
 [46.105.61.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZWvS3PNPzF2Q5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 03:37:24 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.108.80])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id AD1F7AF203
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 18:21:45 +0200 (CEST)
Subject: Re: [PATCH 0/4] powerpc/xive: add support for H_INT_RESET
To: linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c8af828-27f0-1557-050d-e6ecdb487704@kaod.org>
Date: Mon, 30 Apr 2018 18:21:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180403071548.19829-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2018 09:15 AM, Cédric Le Goater wrote:
> H_INT_RESET performs a reset of the Hypervisor internal interrupt
> structures, removing all settings done with H_INT_SET_SOURCE_CONFIG
> and H_INT_SET_QUEUE_CONFIG. This is most important for kdump and kexec
> to be able to restart in a clean state.
> 
> First patch closes a window in the kexec sequence in which the
> H_INT_RESET hcall can be run concurrently with other hcalls when CPUs
> are brought down. The other patches wire up the reset hcall making
> sure it supports H_LONG_BUSY_* returned by the Hypervisor.

Does anyone has some time to take a look ? 

Thanks,

C. 


> Cédric Le Goater (4):
>   powerpc/64/kexec: fix race in kexec when XIVE is shutdowned
>   powerpc/xive: fix hcall H_INT_RESET to support long busy delays
>   powerpc/xive: shutdown XIVE when kexec or kdump is performed
>   powerpc/xive: prepare all hcalls to support long busy delays
> 
>  arch/powerpc/kernel/machine_kexec_64.c |  8 +--
>  arch/powerpc/platforms/pseries/kexec.c |  7 ++-
>  arch/powerpc/sysdev/xive/spapr.c       | 89 +++++++++++++++++++++++++++++-----
>  3 files changed, 85 insertions(+), 19 deletions(-)
> 
