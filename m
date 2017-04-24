Return-Path: <rashmica.g@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBDXJ2LkFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 14:54:24 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id x188so12929771itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:54:24 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f62sm27820608pfb.84.2017.04.23.21.54.20
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Apr 2017 21:54:21 -0700 (PDT)
Subject: Re: [PATCH] powerpc/xmon: Deindent the SLB dumping logic
To: linuxppc-dev@lists.ozlabs.org
References: <1492994114-13797-1-git-send-email-mpe@ellerman.id.au>
From: Rashmica Gupta <rashmica.g@gmail.com>
Message-ID: <e2102cda-9358-1fbf-561f-9f13d2ae0f2b@gmail.com>
Date: Mon, 24 Apr 2017 14:54:18 +1000
MIME-Version: 1.0
In-Reply-To: <1492994114-13797-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 24/04/17 10:35, Michael Ellerman wrote:
> Currently the code that dumps SLB entries uses a double-nested if. This
> means the actual dumping logic is a bit squashed. Deindent it by using
> continue.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>

> ---
>   arch/powerpc/xmon/xmon.c | 39 ++++++++++++++++++++++-----------------
>   1 file changed, 22 insertions(+), 17 deletions(-)
>
> Found lying around in an old tree of mine :}
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 16321ad9e70c..199ba2663f21 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3070,23 +3070,28 @@ void dump_segments(void)
>   	for (i = 0; i < mmu_slb_size; i++) {
>   		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
>   		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
> -		if (esid || vsid) {
> -			printf("%02d %016lx %016lx", i, esid, vsid);
> -			if (esid & SLB_ESID_V) {
> -				llp = vsid & SLB_VSID_LLP;
> -				if (vsid & SLB_VSID_B_1T) {
> -					printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
> -						GET_ESID_1T(esid),
> -						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
> -						llp);
> -				} else {
> -					printf(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx \n",
> -						GET_ESID(esid),
> -						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
> -						llp);
> -				}
> -			} else
> -				printf("\n");
> +
> +		if (!esid && !vsid)
> +			continue;
> +
> +		printf("%02d %016lx %016lx", i, esid, vsid);
> +
> +		if (!(esid & SLB_ESID_V)) {
> +			printf("\n");
> +			continue;
> +		}
> +
> +		llp = vsid & SLB_VSID_LLP;
> +		if (vsid & SLB_VSID_B_1T) {
> +			printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
> +				GET_ESID_1T(esid),
> +				(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
> +				llp);
> +		} else {
> +			printf(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx \n",
> +				GET_ESID(esid),
> +				(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
> +				llp);
>   		}
>   	}
>   }
