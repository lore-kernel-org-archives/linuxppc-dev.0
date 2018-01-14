Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKX0N20s4zF0Xg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 09:56:18 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Borislav Petkov
 <bp@alien8.de>
CC: "mchehab@kernel.org" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [PATCH] EDAC, mv64x60: Remove some code duplication
Date: Sun, 14 Jan 2018 22:48:28 +0000
Message-ID: <68939e8b999644b89080ed049970c9fe@svr-chch-ex1.atlnz.lc>
References: <20180113072821.8100-1-christophe.jaillet@wanadoo.fr>
 <20180113142212.fuuvq2x2bey7qv4s@pd.tnic>
 <49db37d7-3d54-3ae5-9cb9-702ef14f1f43@wanadoo.fr>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,=0A=
=0A=
On 14/01/18 06:17, Christophe JAILLET wrote:=0A=
> Le 13/01/2018 =E0 15:22, Borislav Petkov a =E9crit=A0:=0A=
>> + Chris Packham who's been fixing some stuff in here too.=0A=
>>=0A=
>> On Sat, Jan 13, 2018 at 08:28:21AM +0100, Christophe JAILLET wrote:=0A=
>>> Reorder the error handling code in order to release the resources in=0A=
>>> reverse order than allocation.=0A=
>>>=0A=
>>> Introduce a new 'release_group' label in the error handling path and us=
e=0A=
>>> it to void some code duplication.=0A=
>>>=0A=
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>=0A=
>>> ---=0A=
>>>    drivers/edac/mv64x60_edac.c | 7 ++++---=0A=
>>>    1 file changed, 4 insertions(+), 3 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c=
=0A=
>>> index 3c68bb525d5d..aa5bc1d8f424 100644=0A=
>>> --- a/drivers/edac/mv64x60_edac.c=0A=
>>> +++ b/drivers/edac/mv64x60_edac.c=0A=
>>> @@ -450,8 +450,8 @@ static int mv64x60_cpu_err_probe(struct platform_de=
vice *pdev)=0A=
>>>    					      "cpu", 1, NULL, 0, 0, NULL, 0,=0A=
>>>    					      edac_dev_idx);=0A=
>>>    	if (!edac_dev) {=0A=
>>> -		devres_release_group(&pdev->dev, mv64x60_cpu_err_probe);=0A=
>>> -		return -ENOMEM;=0A=
>>> +		res =3D -ENOMEM;=0A=
>>> +		goto release_group;=0A=
>>>    	}=0A=
>>>    =0A=
>>>    	pdata =3D edac_dev->pvt_info;=0A=
>>> @@ -561,8 +561,9 @@ static int mv64x60_cpu_err_probe(struct platform_de=
vice *pdev)=0A=
>>>    err2:=0A=
>>>    	edac_device_del_device(&pdev->dev);=0A=
>>>    err:=0A=
>>> -	devres_release_group(&pdev->dev, mv64x60_cpu_err_probe);=0A=
>>>    	edac_device_free_ctl_info(edac_dev);=0A=
>>> +release_group:=0A=
>>> +	devres_release_group(&pdev->dev, mv64x60_cpu_err_probe);=0A=
>>>    	return res;=0A=
>>>    }=0A=
>>>    =0A=
>>> -- =0A=
>> Thanks, looks good. But looking at this driver, mv64x60_mc_err_probe()=
=0A=
>> and mv64x60_sram_err_probe() have the same problem too. Can you address =
them=0A=
>> with your patch too pls?=0A=
> Will do. mv64x60_pci_err_probe() also needs some tweaks.=0A=
> =0A=
>> Also, if you feel like fixing more stuff in this driver, it doesn't use=
=0A=
>> the edac_printk() infrastructure but naked printk() calls. It could be=
=0A=
>> converted to it.=0A=
> I will only propose to remove a useless message and improve another one,=
=0A=
> but won't convert the whole driver, sorry.=0A=
> =0A=
=0A=
I take this you mean you have a system with a mv64x60 SoC? You might =0A=
want to make yourself known to the linuxppc-dev list. A while back the =0A=
prospects of dropping CONFIG_MV64X60 was raised[1]. I don't see anyone =0A=
actually following through on this yet but I'm not really following =0A=
linuxppc that closely.=0A=
=0A=
[1] - https://marc.info/?l=3Dlinux-edac&m=3D149518763115206&w=3D2=0A=
