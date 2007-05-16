Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C9966DDD05
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 02:19:42 +1000 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3D94C8810
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 21:19:36 +0500 (SAMST)
Message-ID: <464B2EE6.8000407@ru.mvista.com>
Date: Wed, 16 May 2007 20:18:46 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: New version of the device tree aware EMAC driver
References: <20070516032630.GC19127@localhost.localdomain>
In-Reply-To: <20070516032630.GC19127@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> I've made a few more tiny tweaks to BenH's rewritten device-tree based
> 4xx EMAC driver.  The main change is that it now no longer requires
> 'device_type', just 'compatible' to be set in the ZMII and MAL device
> nodes when probing.  This works better with current thinking on
> flattened device trees which discourages creating new device_type
> values unless there is a clear use for a new device class binding.
>
> The patch can be obtained from:
>
> http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch
>
>   
Looks like EMAC_FTR_STACR_OC_INVERT is missed in the EMAC_FTRS_POSSIBLE
(ibm_newemac/core.h)

Should be something like this:
    EMAC_FTRS_POSSIBLE    =
#ifdef CONFIG_IBM_NEW_EMAC_EMAC4
        EMAC_FTR_EMAC4 | EMAC_FTR_HAS_AXON_STACR | 
EMAC_FTR_STACR_OC_INVERT |
#endif
Thanks
