Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 377431A007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 22:46:24 +1000 (EST)
Message-ID: <5379FD19.2020100@suse.de>
Date: Mon, 19 May 2014 14:46:17 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/8] powerpc/eeh: Info to trace passed devices
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.05.14 06:11, Gavin Shan wrote:
> The address of passed PCI devices (domain:bus:slot:func) might be
> quite different from the perspective of host and guest. We have to
> trace the address mapping so that we can emulate EEH RTAS requests
> from guest. The patch introduces additional fields to eeh_pe and
> eeh_dev for the purpose.
>
> Also, the patch adds function eeh_vfio_pe_get() and eeh_vfio_dev_get()
> to search EEH PE or device according to the given guest address. Both
> of them will be used by subsequent patches.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

I don't see the point of VFIO knowing about guest addresses. They are 
not unique across a system and the whole idea that a VFIO device has to 
be owned by a guest is also pretty dubious.

I suppose what you really care about here is just a token for a specific 
device? But why do you need one where we don't have tokens yet?


Alex
