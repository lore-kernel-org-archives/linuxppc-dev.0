Message-ID: <3D63EC67.4000302@dslextreme.com>
Date: Wed, 21 Aug 2002 12:39:19 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: akuster@dslextreme.com
Cc: jim <jduey@ccc-dcs.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about ppc4xx_dma.h
References: <20020820203619.A456239211@server.weathercom.com> <3D62CE63.1030606@dslextreme.com>
Content-Type: multipart/mixed;
 boundary="------------090106060600030703050006"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090106060600030703050006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

akuster wrote:
>
> jim wrote:
>
>> I've been trying to get DMA working on the 405GP and I've run across
>> something in ppc4xx_dma.h.
>>
>> In the function 'enable_dma' the following piece of code appears:
>>
>> (begin excerpt)
>>     /* for other xfer modes, the addresses are already set */
>>     control = mfdcr(DCRN_DMACR0);
>>     control &= ~(DMA_TM_MASK | DMA_TD);    /* clear all mode bits */
>>     if (p_dma_ch->mode == DMA_MODE_MM) {
>>         /* software initiated memory to memory */
>>         control |= control | DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
>>     }
>>     control |= (p_dma_ch->mode | DMA_CH_ENABLE);
>>     mtdcr(DCRN_DMACR0, control);
>> (end excerpt)
>>
>> It looks to me like this code will always read/write the control
>> register for
>> DMA channel 0 regardless of the channel specified by the parameter
>> 'dmanr'
>> that is passed to the function.  Is this observation correct?
>
>
> good catch.
>
>> What would the
>> fix be, if so?
>>
> Most likey switch statment like the disable has.
>
> give me a day
>
> Armin
>
>
>
>
>

Here is the patch , please let me know it it helps.

Armin

--------------090106060600030703050006
Content-Type: application/x-gunzip;
 name="dma_0821.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dma_0821.patch.gz"

H4sICFjrYz0CA2RtYV8wODIxLnBhdGNoAL1WbW/iRhD+bP+K0aGeSMyLX8i9EBGFAMqpFwg6
oK3UVtZir2Ebe22t1wnRJffbO7sGElId3LXqWdhee2eeeZ6Z3cEVmC5ZDvgjcMHkR0ozKmBB
ORVE0hAyIoMlRKkAuaR4j+P0jvEFZCL9iwaybVZgXA5hRBLahivGixW4jZZ2Gqd3VIx7ENJb
GqdZQrkEKShFNx13C58QqUgwLikPMa5yvhzN1gZBmiSEh3BLRc5SjvAngAZLtlhS0dgFYzyI
i5DmLwiHNJYkR74GPB29JeELOqHScBqO470HqJ+BGrZsQEsigmUzy4LmDRWcxmrYWq38MCGN
QHm0FEbpcYIjs6KZPI/KShpPmd1GhKt0geb17zjQ3Hab9rum6yC1hPFzmueUN5JblkuklCZG
yR0NI7bCLFJO5jEFmQJRjCBJBT4hBXAgwBuKgrzIslRIyFKV/BDSQsL8Hn5mCfQLev/dHM2Q
RRHUR6IA0tyXQZjvnTYR7QCC8Svy7RYLcB1w3LbXarfegWvbrmlZ1gH4r/uen0Pda9XegIVX
x4HzcxPgWJ0Av6wXoNNwwX7bdL2m7UIduqoapQUJ1fLtDVTSc1ngvmAc95P0g5RHbGFaCGXt
Qnmga/ocSlv81xqWKNtCWhsR6to0QQt1vDdKqdNyam+10jKcylG14DlbcIRDUMAXXByZ8NkE
Y2cCdUmRxqemtfteJpkfcBlDB+xTdMLkK1Q/WPoSjrP1GGdflyOtJP9dx/kTHdCFRVDVz3DW
gWH3N3887qkC9oddv/ehOxoNriZHyEgLOfFquCEt5+R9reVqKYaRY97DXPpYFFEi1cA+Umwe
8Wwe6zaT4g4VsIrwkqTYOGp6yyoXtb2wMWK+SSwoCe8BAVXu6sZaNdJPojAQ1X7v00jx6n1S
+E/zrzvwpar4Tof+sDv5CA+gn/pHpyp+EFMiVGF1aJgzmZf4SvomR/UzPdnpaNfhdX/gD4dK
t2V8mx1mAmPlaSTvlBjGmWS6uycUV9O9WlvrkY69Jf/Qge1QYw6mff96Nh3PphsdvYE/GHUv
rgaq/sa25g+db7F/xPO5y0slpU/vw9oFE2uhR37HVJ8v61mmISA5BbutKOwvjLUjbhN75/2/
q5i1+VsxEvkibG2TxDL+HFfSzemGtHOAtPP/kv4HW2cvW/cAW/cHs3X3svUOsPV+MFvva2xD
GpEixo8pq8IifID+4GJ26WOrQz9lmQnsqDfVV0/NuQ1zEm76fxt+Cv/gr2rrJo2QFfyKYpHu
c/XnAg/vsPr+BazasqCyEFx7Tqbd6WziX15f93Hu0fwbXpcVeU8KAAA=
--------------090106060600030703050006--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
