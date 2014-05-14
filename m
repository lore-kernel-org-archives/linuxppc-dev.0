Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5078140077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 19:52:54 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 14 May 2014 15:22:50 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4F4373940048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:22:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E9qt2q10289532
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:22:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E9qjS2001803
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:22:45 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pci-scan: Fix setting the limit
In-Reply-To: <1399978118-10298-1-git-send-email-aik@ozlabs.ru>
References: <1399978118-10298-1-git-send-email-aik@ozlabs.ru>
Date: Wed, 14 May 2014 15:22:44 +0530
Message-ID: <87tx8soff7.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Thomas Huth <thuth@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> PCI spec says that lower 20 bits are assumed 0xFFFFF. The existing code
> seems to get it right in pci-bridge-set-mem-limit.
>
> However pci-bridge-set-mem-base does not account 0xFFFFF and poison
> the limit. Since the limit is not stored anywhere in SLOF and only
> besides in the config space, it remains broken.
>
> This fixes pci-bridge-set-mem-base.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> I have doubts this is the right fix as I tried to "fix"
> pci-bridge-set-mmio-base (while I am here) and it broke the guest.
>
> The problem I am fixing by this is that QEMU started as below is
> unable to initialize virtio-net device because there are overlapping
> virtio's BAR and bridge's "ranges" property. Note that virtio-net is
> attached to the PHB, not that additional bridge.
>
> /home/aik/qemu-system-ppc64 \
> -enable-kvm \
> -m 1024 \
> -machine pseries \
> -nographic \
> -vga none \
> -device pci-bridge,id=id0,bus=pci.0,addr=5.0,chassis_nr=7 \
> -netdev tap,id=id1,ifname=tap1,script=ifup.sh,downscript=ifdown.sh \
> -device virtio-net-pci,id=id2,netdev=id1 \
> -initrd 1.cpio \
> -kernel vml315rc3 \

The problem that I saw here is the brigde device does not have a
downstream pci device. Before probing, we are setting the ranges
property to the max limit, and the probe is done. Once the probe is over
we would update the ranges property. 

In this particular case, when we come to update the " ranges" property,
we do not have any range and we skip updating it. Because of this the
old max range property remains there, which is not correct.

Something like the below solves this particular problem. But what would
happen when someone tries to hotplug a pci device to this bridge, will
the pci-hotplug code take care of updating the ranges property?


diff --git a/slof/fs/pci-properties.fs b/slof/fs/pci-properties.fs
index f88a571..f5e934d 100644
--- a/slof/fs/pci-properties.fs
+++ b/slof/fs/pci-properties.fs
@@ -410,6 +410,7 @@
         dup IF                          \ IF any space present (propsize>0)
                 s" ranges" property     \ | write it into the device tree
         ELSE                            \ ELSE
+               s" " s" ranges" property
                 2drop                   \ | forget the properties
         THEN                            \ FI
         drop                            \ forget the address

So I do not see the problem when there is a device allocated downstream
to the pci-bridge.

Regards
Nikunj
