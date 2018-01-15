Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL7PZ00NXzF0bW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 09:31:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Borislav Petkov <bp@alien8.de>
Cc: "mchehab\@kernel.org" <mchehab@kernel.org>,
 "linux-edac\@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors\@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] EDAC, mv64x60: Remove some code duplication
In-Reply-To: <68939e8b999644b89080ed049970c9fe@svr-chch-ex1.atlnz.lc>
References: <20180113072821.8100-1-christophe.jaillet@wanadoo.fr>
 <20180113142212.fuuvq2x2bey7qv4s@pd.tnic>
 <49db37d7-3d54-3ae5-9cb9-702ef14f1f43@wanadoo.fr>
 <68939e8b999644b89080ed049970c9fe@svr-chch-ex1.atlnz.lc>
Date: Tue, 16 Jan 2018 09:31:45 +1100
Message-ID: <87bmhubvou.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
> On 14/01/18 06:17, Christophe JAILLET wrote:
>> Le 13/01/2018 =C3=A0 15:22, Borislav Petkov a =C3=A9crit=C2=A0:
>>> + Chris Packham who's been fixing some stuff in here too.
>>>
>>> On Sat, Jan 13, 2018 at 08:28:21AM +0100, Christophe JAILLET wrote:
>>>> Reorder the error handling code in order to release the resources in
>>>> reverse order than allocation.
>>>>
>>>> Introduce a new 'release_group' label in the error handling path and u=
se
>>>> it to void some code duplication.
>>>>
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> ---
>>>>    drivers/edac/mv64x60_edac.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
...
>>>>=20=20=20=20
>>>> --=20
>>> Thanks, looks good. But looking at this driver, mv64x60_mc_err_probe()
>>> and mv64x60_sram_err_probe() have the same problem too. Can you address=
 them
>>> with your patch too pls?
>> Will do. mv64x60_pci_err_probe() also needs some tweaks.
>>=20
>>> Also, if you feel like fixing more stuff in this driver, it doesn't use
>>> the edac_printk() infrastructure but naked printk() calls. It could be
>>> converted to it.
>> I will only propose to remove a useless message and improve another one,
>> but won't convert the whole driver, sorry.
>>=20
>
> I take this you mean you have a system with a mv64x60 SoC? You might=20
> want to make yourself known to the linuxppc-dev list. A while back the=20
> prospects of dropping CONFIG_MV64X60 was raised[1]. I don't see anyone=20
> actually following through on this yet but I'm not really following=20
> linuxppc that closely.

That's just because I haven't had time to do it and no one else took the
hint :)

So yes, Christophe if you have a machine that uses this driver please
speak up, otherwise it will probably be removed.

cheers
