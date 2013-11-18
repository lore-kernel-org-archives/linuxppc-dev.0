Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 115C72C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 21:54:13 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 18 Nov 2013 10:54:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 463E32190059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:54:05 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAIArqWQ44564502
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:53:52 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAIAs4KX012112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 05:54:04 -0500
Message-ID: <5289F1CA.4090809@fr.ibm.com>
Date: Mon, 18 Nov 2013 11:54:02 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 16/51] DMA-API: ppc: vio.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk> <528648F7.20900@fr.ibm.com>
 <20131116153244.GD25039@n2100.arm.linux.org.uk>
In-Reply-To: <20131116153244.GD25039@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2013 04:32 PM, Russell King - ARM Linux wrote:
> On Fri, Nov 15, 2013 at 05:16:55PM +0100, Cedric Le Goater wrote:
>> The new helper routine dma_set_mask_and_coherent() breaks the 
>> initialization of the pseries vio devices which do not have an 
>> initial dev->dma_mask. I think we need to use dma_coerce_mask_and_coherent()
>> instead.
> 
> Who wants to handle this patch?
>
> Also, is it possible to fix it so that dev->dma_mask is correctly setup
> by the code which creates the device, as it should be in the first place?

The vio_dev should probably be improved to setup devices as the other 
drivers do but we might be short on time to do that for 3.13 and pseries 
is really broken ... For now, I will just resend the patch with some 
context in the changelog. 

Thanks,

C.
