Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE8061A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 20:14:49 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 09:14:44 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 72F9D1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 09:15:06 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u299Eebf61997230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 09:14:40 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u299Ecrb030288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 02:14:40 -0700
Subject: Re: [v6,12/20] cxl: Add guest-specific code
To: Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20160309055533.92479140BB4@ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56DFE97D.6040606@linux.vnet.ibm.com>
Date: Wed, 9 Mar 2016 10:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <20160309055533.92479140BB4@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Le 09/03/2016 06:55, Michael Ellerman a écrit :
> This breaks the SMP=n build:

Arg! I'm adding it to my checklist.

Thanks for the fix.

   Fred

> I've fixed it up with:
>
> diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
> index f01d4c012620..d6d11f4056d7 100644
> --- a/drivers/misc/cxl/hcalls.c
> +++ b/drivers/misc/cxl/hcalls.c
> @@ -11,7 +11,6 @@
>   #include <linux/compiler.h>
>   #include <linux/types.h>
>   #include <linux/delay.h>
> -#include <asm/hvcall.h>
>   #include <asm/byteorder.h>
>   #include "hcalls.h"
>   #include "trace.h"
> diff --git a/drivers/misc/cxl/hcalls.h b/drivers/misc/cxl/hcalls.h
> index 6bfab323578d..3e25522a5df6 100644
> --- a/drivers/misc/cxl/hcalls.h
> +++ b/drivers/misc/cxl/hcalls.h
> @@ -12,6 +12,7 @@
>
>   #include <linux/types.h>
>   #include <asm/byteorder.h>
> +#include <asm/hvcall.h>
>   #include "cxl.h"
>
>   #define SG_BUFFER_SIZE 4096
>
>
> cheers
>
