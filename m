Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65018C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE77121903
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE77121903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Y4p51vpzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ilande.co.uk
 (client-ip=82.165.15.123; helo=s16892447.onlinehome-server.info;
 envelope-from=mark.cave-ayland@ilande.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ilande.co.uk
Received: from s16892447.onlinehome-server.info (chuckie.co.uk [82.165.15.123])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443Y2q0G7BzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 18:56:16 +1100 (AEDT)
Received: from host86-186-67-148.range86-186.btcentralplus.com
 ([86.186.67.148] helo=[192.168.1.65])
 by s16892447.onlinehome-server.info with esmtpsa
 (TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1gw0GI-0003da-Kd; Tue, 19 Feb 2019 07:56:19 +0000
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
 <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
 <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
 <87pnrobe9m.fsf@concordia.ellerman.id.au>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <6839dfd8-f316-d98a-2ae9-279de956ce28@ilande.co.uk>
Date: Tue, 19 Feb 2019 07:55:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87pnrobe9m.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.186.67.148
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS
 guest
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Jan 2012 02:45:44 +0000)
X-SA-Exim-Scanned: Yes (on s16892447.onlinehome-server.info)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 19/02/2019 04:20, Michael Ellerman wrote:

Hi Michael,

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>> On 08/02/2019 14:45, Christophe Leroy wrote:
>>
>>> Le 08/02/2019 à 15:33, Mark Cave-Ayland a écrit :
>>>> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"
>>>
>>> Expected format for the above is:
>>>
>>> Commit 123456789abc ("text")
>>
>> Hi Christophe,
>>
>> Apologies - I'm fairly new at submitting kernel patches, but I can re-send it in the
>> correct format later if required.
>>
>>>> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
>>>> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
>>>> guest to lockup and panic the kernel.
> 
> Which kernel is panicking? The guest or the host?

It's the host kernel. As long as you occasionally tap a few keys to keep the screen
blanking disabled then you can see the panic on the physical console.

I've uploaded a photo I took during the bisection containing the panic when booting
MacOS X 10.2 under qemu-system-ppc to
https://www.ilande.co.uk/tmp/qemu/macmini-kvm.jpg in case you find it useful.

Given that it's really easy to recreate, let me know if you want me to do a git
pull/rebuild and/or if you need any debugging information as it's easy for me to
reproduce.

>>>> Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
>>>> 32-bit KVM-PR once again without issue.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> Should include a Fixes: and a Cc to stable ?
>>>
>>> Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without giving it up")
>>> Cc: stable@vger.kernel.org
>>
>> Indeed, but there are still some questions to be asked here:
>>
>> 1) Why were these bits removed from the original bitmask in the first place without
>> it being documented in the commit message?
> 
> It was almost certainly an accident.

Heh, okay :)

>> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
>> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
>> bug elsewhere in the 32-bit powerpc code.
> 
> That's slightly worrying. It's hard to say without more detail on why
> the guest is crashing.
> 
> I think your patch looks OK based just on the fact that it restores the
> previous behaviour, so I'll pick it up and pass it through my usual
> testing. If nothing breaks I'll merge it.

That would be great! Does it need a CC to stable too? It would be great if this would
get picked up in the next set of Debian ports kernels, for example.


ATB,

Mark.
