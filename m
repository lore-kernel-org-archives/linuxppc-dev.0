Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A45C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 08:17:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7789F2077B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 08:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7789F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443YWf0nmKzDqJt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 19:17:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ilande.co.uk
 (client-ip=82.165.15.123; helo=s16892447.onlinehome-server.info;
 envelope-from=mark.cave-ayland@ilande.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ilande.co.uk
Received: from s16892447.onlinehome-server.info (chuckie.co.uk [82.165.15.123])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443YTK6wnqzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 19:15:48 +1100 (AEDT)
Received: from host86-186-67-148.range86-186.btcentralplus.com
 ([86.186.67.148] helo=[192.168.1.65])
 by s16892447.onlinehome-server.info with esmtpsa
 (TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1gw0ZJ-0003ii-FT; Tue, 19 Feb 2019 08:15:58 +0000
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
 <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
 <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
 <c2d6938902656f2829be8077c656cee9235c21b1.camel@kernel.crashing.org>
 <46205b6a-7671-5d90-9507-b5b20045b99d@ilande.co.uk>
 <87mumsbcnl.fsf@concordia.ellerman.id.au>
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
Message-ID: <86f4b1df-78c7-ae1b-1144-554860903077@ilande.co.uk>
Date: Tue, 19 Feb 2019 08:15:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87mumsbcnl.fsf@concordia.ellerman.id.au>
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

On 19/02/2019 04:55, Michael Ellerman wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>> On 11/02/2019 00:30, Benjamin Herrenschmidt wrote:
>>
>>> On Fri, 2019-02-08 at 14:51 +0000, Mark Cave-Ayland wrote:
>>>>
>>>> Indeed, but there are still some questions to be asked here:
>>>>
>>>> 1) Why were these bits removed from the original bitmask in the first place without
>>>> it being documented in the commit message?
>>>>
>>>> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
>>>> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
>>>> bug elsewhere in the 32-bit powerpc code.
>>>>
>>>>
>>>> If you think that these points don't matter, then I'm happy to resubmit the patch
>>>> as-is based upon your comments above.
>>>
>>> We should write a test case to verify that FE0/FE1 are properly
>>> preserved/context-switched etc... I bet if we accidentally wiped them,
>>> we wouldn't notice 99.9% of the time.
>>
>> Right I guess it's more likely to cause in issue in the KVM PR case because the guest
>> can alter the flags in a way that doesn't go through the normal process switch mechanism.
>>
>> The original patchset at
>> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg98326.html does include
>> some tests in the first few patches, but AFAICT they are concerned with the contents
>> of the FP registers rather than the related MSRs.
> 
> fpu_preempt.c should be able to be adapted to also check the MSR bits.
> 
>> Who is the right person to ask about fixing issues related to context switching with
>> KVM PR?
> 
> KVM PR doesn't really have a maintainer TBH. Feel like volunteering? :)

Well I only have a 32-bit Mac Mini here which I'm using to help flush out bugs in
QEMU's emulation, so I can keep an occasional eye on the 32-bit side of things but as
it's a hobby project time is quite limited.

As/when time allows I'd be interested to figure out what MacOS 9 does that causes KVM
PR to bail, and if it's possible to run KVM PR on an SMP kernel but certainly I'd
need some help from the very knowledgable people on these lists.

>> I did add the original author's email address to my first few emails but have
>> had no response back :/
> 
> Cyril who wrote the original FPU patch has moved on to other things.

Ah okay then.


ATB,

Mark.
