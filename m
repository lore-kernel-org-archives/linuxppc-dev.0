Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r45TZ2wxGzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 03:14:41 +1000 (AEST)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 10 May 2016 18:14:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1FFAC1B08061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 18:15:28 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4AHEYPE14680360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 17:14:34 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4AHEXmC020716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 11:14:34 -0600
Subject: Re: [PATCH v2] cxl: Add kernel API to allow a context to operate with
 relocate disabled
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1462520796-30089-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <573216F9.9010503@linux.vnet.ibm.com>
Date: Tue, 10 May 2016 19:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <1462520796-30089-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 06/05/2016 09:46, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> cxl devices typically access memory using an MMU in much the same way as
> the CPU, and each context includes a state register much like the MSR in
> the CPU. Like the CPU, the state register includes a bit to enable
> relocation, which we currently always enable.
>
> In some cases, it may be desirable to allow a device to access memory
> using real addresses instead of effective addresses, so this adds a new
> API, cxl_set_translation_mode, that can be used to disable relocation
> on a given kernel context. This can allow for the creation of a special
> privileged context that the device can use if it needs relocation
> disabled, and can use regular contexts at times when it needs relocation
> enabled.
>
> This interface is only available to users of the kernel API for obvious
> reasons, and will never be supported in a virtualised environment.
>
> This will be used by the upcoming cxl support in the mlx5 driver.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


Looks good to me.
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred
