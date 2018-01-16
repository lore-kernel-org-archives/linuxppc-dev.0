Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLKnY6HMSzF0bW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 17:19:43 +1100 (AEDT)
Subject: Re: [PATCH] EDAC, mv64x60: Remove some code duplication
To: Michael Ellerman <mpe@ellerman.id.au>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Borislav Petkov <bp@alien8.de>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20180113072821.8100-1-christophe.jaillet@wanadoo.fr>
 <20180113142212.fuuvq2x2bey7qv4s@pd.tnic>
 <49db37d7-3d54-3ae5-9cb9-702ef14f1f43@wanadoo.fr>
 <68939e8b999644b89080ed049970c9fe@svr-chch-ex1.atlnz.lc>
 <87bmhubvou.fsf@concordia.ellerman.id.au>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <1229c4dd-0c83-7f33-29d4-dfd7d80b2075@wanadoo.fr>
Date: Tue, 16 Jan 2018 07:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <87bmhubvou.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 15/01/2018 à 23:31, Michael Ellerman a écrit :
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>> On 14/01/18 06:17, Christophe JAILLET wrote:
>>> Le 13/01/2018 à 15:22, Borislav Petkov a écrit :
>>>> + Chris Packham who's been fixing some stuff in here too.
>>>>
>>>> On Sat, Jan 13, 2018 at 08:28:21AM +0100, Christophe JAILLET wrote:
>>>>> Reorder the error handling code in order to release the resources in
>>>>> reverse order than allocation.
>>>>>
>>>>> Introduce a new 'release_group' label in the error handling path and use
>>>>> it to void some code duplication.
>>>>>
>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>> ---
>>>>>     drivers/edac/mv64x60_edac.c | 7 ++++---
>>>>>     1 file changed, 4 insertions(+), 3 deletions(-)
> ...
>>>>>     
>>>>> -- 
>>>> Thanks, looks good. But looking at this driver, mv64x60_mc_err_probe()
>>>> and mv64x60_sram_err_probe() have the same problem too. Can you address them
>>>> with your patch too pls?
>>> Will do. mv64x60_pci_err_probe() also needs some tweaks.
>>>
>>>> Also, if you feel like fixing more stuff in this driver, it doesn't use
>>>> the edac_printk() infrastructure but naked printk() calls. It could be
>>>> converted to it.
>>> I will only propose to remove a useless message and improve another one,
>>> but won't convert the whole driver, sorry.
>>>
>> I take this you mean you have a system with a mv64x60 SoC? You might
>> want to make yourself known to the linuxppc-dev list. A while back the
>> prospects of dropping CONFIG_MV64X60 was raised[1]. I don't see anyone
>> actually following through on this yet but I'm not really following
>> linuxppc that closely.
> That's just because I haven't had time to do it and no one else took the
> hint :)
>
> So yes, Christophe if you have a machine that uses this driver please
> speak up, otherwise it will probably be removed.
>
> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Hi,

No I don't have.

I use static checker to find some potential issues in Linux (most of the 
time, with my own coccinelle scripts).
Before proposing some patches, I check if the development on the 
corresponding files is still active.
This driver looked active (i.e. there were several recent commits, even 
if only cleanups).

If it is nearly dead, my small fixes/cleanups are useless, and I will 
leave it as-is.

Thanks for pointing this out. I'll dig somewhere else :)


For the records, and if someone is interested, in order to search for 
"active" files in what I've touched, I use:
(this is a slightly updated version of a script found on Internet)

     # date of the last modification of updated files
     git status -s -uno | while read mode file; do echo "$(git log -1 
--date=format:'%Y%m%d_%H:%M:%S' --format=%cd $file)   $file"; done | 
sort -s -n -k 1,1 > last_modified.txt

When I find a potential candidate, I then have a look in its recent 
history with 'git log' or with 
'https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/...'

Best regards,
CJ
