Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2828C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 00:29:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FF420865
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 00:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi5W1ac1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FF420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X5Dy5K0JzDqD1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pi5W1ac1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pi5W1ac1"; 
 dkim-atps=neutral
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X5BQ5VxbzF3L5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 11:27:26 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id g32-v6so12910099edg.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cy1j3ckC884OCne5pLb4ZzTjT6+DczYovxolZT1oJsA=;
 b=Pi5W1ac1iNPWqWlfxlUjvq6LervbaDB4i+TURcCrEhIXPALDo8iIPPkK1MGqJpp3J5
 9J7+cRzdD7P8AwoNlq7kPBUH98Q/YMZ40tzJIF6mA98IBgZ5vCnTaRn47R5b5nIWPFXO
 GF2HopPofX02nOZn8Rbq6sG7RSXYwUNmMAuAInTsmIOep5klbE9qa3CKpVAeHcjg/xcg
 eYPfOWQoAj5lBuf4A5lrxhf43KPZGueAQXDnCBk1Fdqb43OZIYYVyiQ1d5YiF8+FwT49
 Kv62q69zNIbBy3ZCGu0fQAnsP9BFQ7an/4mGbyvffA8L6r5n6ZSXMIARAur7f6VBmJZI
 9YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cy1j3ckC884OCne5pLb4ZzTjT6+DczYovxolZT1oJsA=;
 b=B0IUqYZMvWzxMDwe4DDkgY//Bc1zXYtoSW65i5hMRK8FdD+hKNvXnukLfCGoQlqnpW
 H1grIZczNWhbds0ZpwbMpn45aA7+3MewE0OBGhdzX2z/6KdI4qlUt6pkFJMQS9bRA8pV
 h3JIMCGWYcqxXsNPPITpMCukpaeDuV/T9TDS1sBQPdOOlzyiJ7kSD6eV7IjVqwzFUmrZ
 IqnQ7mWAufgiznCbuFcG6PRM6DZWoI/8zPUPNindAySNO7s4OABDfBKi/BzaQ75bVXcd
 T4ffleFrNgM6Izane7HY8kk/GkShDRNwxX4apNI+8VwLwOXhd0k6YrqYcFcy9bLu+Lgo
 OlgA==
X-Gm-Message-State: ABuFfojuc4DnjZ/KWgV3y9BJ3ag8jEVZ3ZWdCQ9WTbQ2OyiT/iZy4wol
 QElQPS/7wPaSG+WH6NsWb0H9Rbw38ntD91VPbB8=
X-Google-Smtp-Source: ACcGV60NIZlTqyqFbJ8RmtQDcdxpS5JmjvpyYjlQj3KCoYVmyPBJJ+arqAKVZy+yliVLxboffQ09LTRzdo8pvouMl3o=
X-Received: by 2002:aa7:c581:: with SMTP id
 g1-v6mr11350774edq.79.1539390443421; 
 Fri, 12 Oct 2018 17:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
 <3f5ace27-7692-6d95-6e34-611d3eee3ead@linux.vnet.ibm.com>
In-Reply-To: <3f5ace27-7692-6d95-6e34-611d3eee3ead@linux.vnet.ibm.com>
From: Raz <raziebe@gmail.com>
Date: Sat, 13 Oct 2018 03:27:11 +0300
Message-ID: <CAPB=Z-rGqvZcGTkbvXCH7w_=iD4f6NjXjMpU33jLkY_fXHsUTQ@mail.gmail.com>
Subject: Re: Looking for architecture papers
To: gromero@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

So,if we're talk about address...
EA0 is actually bit 63 for any kernel address. This means[1] the
effective address is
the real address ( the physical address), because MSR_HV=1.
1. What does it mean PA=EA ? How does the translation work now ?
2. in interrupts, the program counter is set to EA 0c00, ==>  EA=0.
So, in interrupt there's a different addressing model ?

[1]. Section 5.7.3, PowerISA 2.07B.


On Mon, Oct 8, 2018 at 10:59 PM Gustavo Romero
<gromero@linux.vnet.ibm.com> wrote:
>
> Hi Raz,
>
> On 10/04/2018 04:41 AM, Raz wrote:
> > Frankly, the more I read the more perplexed I get. For example,
> > according to BOOK III-S, chapter 3,
> > the MSR bits are differ from the ones described in
> > arch/powerpc/include/asm/reg.h.
> > Bit zero, is LE, but in the book it is 64-bit mode.
> >
> > Would someone be kind to explain what I do not understand?
>
> Yes, I know that can be confusing at the first sight when one is used to, for
> instance, x86.
>
> x86 documents use LSB 0 notation, which means (as others already pointed out)
> that the least significant bit of a value is marked as being bit 0.
>
> On the other hand Power documents use MSB 0 notation, which means that the most
> significant bit of a value is marked as being bit 0 and as a consequence the
> least significant bit in that notation in a 64-bit platform is bit 63, not bit
> 0. MSB 0 notation is also known as IBM bit notation/bit numbering.
>
> Historically LSB 0 notation tend to be used on docs about little-endian
> architectures (for instance, x86), whilst MSB 0 notation tend to be used on docs
> about big-endian architectures (for instance, Power - Power is actually a little
> different because it's now bi-endian actually).
>
> However LSB 0 and MSB 0 are only different notations, so LSB 0 can be employed
> on a big-endian architecture documentation, and vice versa.
>
> It happens that kernel code is written in C and for shifts, etc, it's convenient
> the LSB 0 notation, not the MSB 0 notation, so it's convenient to use LSB 0
> notation when creating a mask, like in arch/powerpc/include/asm/reg.h), i.e.
> it's convenient to employ bit positions as '63 - <bit position in PowerISA>'.
>
> So, as another example, in the following gcc macro '_TEXASR_EXTRACT_BITS' takes
> a bit position 'BITNUM' as found in the PowerISA documentation but then for the
> shift right it uses '63 - BITNUM':
>
> https://github.com/gcc-mirror/gcc/blob/master/gcc/config/rs6000/htmintrin.h#L44-L45
>
> I think it's also important to mention that on PowerISA the elements also follow
> the MSB 0 notation. So byte, word, and dword elements in a register found in the
> instruction descriptions when referred to 0 are the element "at the left tip",
> i.e. "the most significant elements", so to speak. For instance, take
> instruction "vperm": doc says 'index' takes bits 3:7 of a byte from [byte]
> element 'i'. So for a byte element i=0 it means the most significant byte
> ("on the left tip") of vector register operand 'VRC'. Moreover, specified bits
> in that byte element, i.e. bits 3:7,  also follow the MSB 0, so for the
> little-endian addicted thought they are bits 4:0 (LSB 0 notation).
>
> Now, if bits 4:0 = 0b00011 (decimal 3), we grab byte element 3 from 'src'
> (256-bit). However byte element 3 is also in MSB 0 notation, so it means third
> byte of 'src' but starting counting bytes from 0 from the left to the right
> (which in IMO looks indeed more natural since we count, for instance, Natural
> Numbers on the 'x' axis similarly).
>
> Hence, it's like to say that 'vperm' instruction in a certain sense has a
> "big-endian semantics" for the byte indices. The 'vpermr' instruction introduced
> by PowerISA v3.0 is meant to cope with that, so 'vpermr' byte indices have a
> "little-endian semantics", so for bits 3:7 MSB 0 (or bits 4:0 in LSB 0 notation) =
> 0b00011 (decimal 3), on the 'vpermr' instruction it really means we must count
> bytes starting from right to left as in the LSB 0 notation and grab the third byte
> element from right to left.
>
> So, for instance:
>
> vr0            uint128 = 0x00000000000000000000000000000000
> vr1            uint128 = 0x00102030405060708090a0b0c0d0e0f0
> vr2            uint128 = 0x01112233445566779999aabbccddeeff
> vr3            uint128 = 0x03000000000000000000000000000000
>
> we have 'src' as:
>
> MSB 0:             v--- byte 0, 1, 2, 3, ...
> LSB 0:                                                                                  ...  3, 2, 1, byte 0 ---v
> src = vr1 || vr2 = 00 10 20 30 40 50 60 70 80 90 A0 B0 C0 D0 E0 F0 01 11 22 33 44 55 66 77 99 99 AA BB CC DD EE FF
>
> vperm   vr0, vr1, vr2, vr3 result is:
> vr0            uint128 = 0x30000000000000000000000000000000
> byte 3 in MSB 0  = 0x30 ---^ and 0x00 (byte 0 in MSB 0) copied to the remaining bytes
>
> whilst with vpermr (PowerISA v3.0 / POWER9):
> vpermr   vr0, vr1, vr2, vr3 result is:
> vr0            uint128 = 0xccffffffffffffffffffffffffffffff
> byte 3 in LSB 0  = 0xCC----^ and 0xFF (byte 0 in LSB 0) copied to the remaining bytes
>
>
> Anyway, vperm/vpermr was just an example about notation not being restricted to
> bits on Power ISA. So read the docs carefully :) GDB is always useful for checking
> if one's understanding about a given Power instruction is correct.
>
> HTH.
>
>
> Regards,
> Gustavo
>
