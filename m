Return-Path: <varkabhadram@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3487F1A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 21:01:30 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y10so1163646pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Aug 2014 04:01:28 -0700 (PDT)
Message-ID: <53E0B926.9010103@gmail.com>
Date: Tue, 05 Aug 2014 16:29:50 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2014 01:02 PM, Nicolin Chen wrote:
> From: Nicolin Chen <Guangyu.Chen@freescale.com>
>
> SAI supports these operation modes:
> 1) asynchronous mode
>     Both Tx and Rx are set to be asynchronous.
> 2) synchronous mode (Rx sync with Tx)
>     Tx is set to be asynchronous, Rx is set to be synchronous.
> 3) synchronous mode (Tx sync with Rx)
>     Rx is set to be asynchronous, Tx is set to be synchronous.
> 4) synchronous mode (Tx/Rx sync with another SAI's Tx)
> 5) synchronous mode (Tx/Rx sync with another SAI's Rx)
>
> * 4) and 5) are beyond this patch because they are related with another SAI.
>
> As the initial version of this SAI driver, it supported 2) as default while
> the others were totally missing.
>
> So this patch just adds supports for 1) and 3).
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   .../devicetree/bindings/sound/fsl-sai.txt          | 16 ++++++++++++
>   sound/soc/fsl/fsl_sai.c                            | 30 +++++++++++++++++++---
>   sound/soc/fsl/fsl_sai.h                            |  4 +++
>   3 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 0f4e238..77864f4 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -24,6 +24,22 @@ Required properties:
>   - big-endian-data: If this property is absent, the little endian mode will
>     be in use as default, or the big endian mode will be in use for all the
>     fifo data.
> +- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> +  that SAI will work in the synchronous mode (sync Tx with Rx) which means
> +  both the transimitter and receiver will send and receive data by following
> +  receiver's bit clocks and frame sync clocks.
> +- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> +  that SAI will work in the asynchronous mode, which means both transimitter
> +  and receiver will send and receive data by following their own bit clocks
> +  and frame sync clocks separately.
>
Would be readable if it like this...

fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
			that SAI will work in the synchronous mode (sync Tx with Rx) which means
			both the transimitter and receiver will send and receive data by following
			receiver's bit clocks and frame sync clocks.
- fsl,sai-asynchronous: This is a boolean property. If present, indicating
			that SAI will work in the asynchronous mode, which means both transimitter
			and receiver will send and receive data by following their own bit clocks
			and frame sync clocks separately.
.....

-- 
Regards,
Varka Bhadram.
