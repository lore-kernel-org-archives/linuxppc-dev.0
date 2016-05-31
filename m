Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJbd56QkLzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 11:34:33 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id f8so23233625pag.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:34:33 -0700 (PDT)
Subject: Re: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 paulus@samba.org, nfont@linux.vnet.ibm.com
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
 <1464593541.3078.192.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Rashmica <rashmicy@gmail.com>
Message-ID: <574CEA20.5070809@gmail.com>
Date: Tue, 31 May 2016 11:34:24 +1000
MIME-Version: 1.0
In-Reply-To: <1464593541.3078.192.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 30/05/16 17:32, Benjamin Herrenschmidt wrote:
> On Mon, 2016-05-30 at 16:18 +1000, Rashmica Gupta wrote:
>> MPIC was only used by Power3 which is now unsupported, so drop support
>> for MPIC. XICS is now the only supported interrupt controller for
>> pSeries so make the XICS functions generic.
> The second half I'm not sure ... XIVE is around the corner...
>
> Cheers,
> Ben.
>
I thought XIVE was replacing XICS? And so then we can just simply 
replace all the specific XICS code such as xics_init() and 
xics_smp_probe() with the relevant XIVE functions?

By "make the XICS functions generic" I meant that if there is only one 
interrupt controller for pseries then we don't need to have both static 
void __init pseries_xics_init_IRQ(void) and static void __init 
pSeries_init_IRQ(void), etc.
