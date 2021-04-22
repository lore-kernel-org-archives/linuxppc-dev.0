Return-Path: <SRS0=xMs2=JT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAEC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 17:02:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009A5613C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 17:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009A5613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FR3ch3mB1z30CX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 03:02:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=P6ACLkys;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e;
 helo=mail-wr1-x42e.google.com; envelope-from=lijunp213@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P6ACLkys; dkim-atps=neutral
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FR3cB5JBGz2yZL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Apr 2021 03:01:45 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id s7so45441547wru.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0xQrGUJMQ0tmAAho/ICoAo494yHdtqwY0aAjVAdlJlc=;
 b=P6ACLkysuXCv+qzEk5qa6Xlz+hudz6YWUo1CF27gQqloEvmct+8aTDc/3EtwNYL9WS
 9cxc7VnLybAbF9X03wXYh2feW7N7o7+kP9pvb0NAzLKoqQnrpci4EABjQZqi1/LGieAS
 uphzJnz/hQ4usJ/mBt82+uztQAm9Msblg5m23plz5KRP4HrTek45R97Y5IPdHzFV0kAB
 X+9+4ZHF3jZPokcQqIsQicMoywXA2ExOo77d9Fxiv72IRDFbxrtEE5sBPwBXc+WbaMNA
 CMSakNqcl0kkW3uDlBZTkql7/iBbtY5o3/MnbeJWgT3zZMNP3HDkV1m+v+pOafxTVe19
 VVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0xQrGUJMQ0tmAAho/ICoAo494yHdtqwY0aAjVAdlJlc=;
 b=KxS8H+PkC+/E7FHsOcKzRJ1yC2GXBbyyB9yPzABLBfHrqon9GrWQv3V2NvvXIKoFA3
 Fqen5HXu3zOm6Gh13MZiXu2CleThTc8GyHUsxWOIx6ZiRY6jROgih2ImDJTMza+O7fNz
 hqlPXau0d3KiqfXFA3Ii4DXUWRfcrz/Og+o7UfVQmo2p0vW86myAHlcigX/yWWoHYwLe
 UjUtebwEV1/1nxJExvKWaGHN/jo7+Ciy0GQF19S7dVexNf2vqomKB/Lpr5PT238oatTs
 xlYH9PZzlB+t1kwzFA1m+EPFkhHR+iEv1NRZBEc3WgxIjCeNt8j0pHTMMAWWjtbfwVdn
 Q+3w==
X-Gm-Message-State: AOAM533YqxbyIpkqQy+h3t8aMONr1FtnUF3H68CeTQvoZUcQhrlzIaFk
 hhzhA2w93k5YslHi2/QAuVSmL0/axDpp888moWE=
X-Google-Smtp-Source: ABdhPJy0Wt22BhjpDVLeiGQX1cYKsn8NMoS0zVlB2EW2t2tjxPYjtc/0iPFEuHPDktfgvz3s9/SOV9CWkdTf44ctunY=
X-Received: by 2002:adf:a3c4:: with SMTP id m4mr5278595wrb.217.1619110900333; 
 Thu, 22 Apr 2021 10:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210420213517.24171-1-drt@linux.ibm.com>
 <CAOhMmr5XayoXS=sJ+9zm68VF+Jn+9qiVvWUrDfq0WGQ6ftKdbw@mail.gmail.com>
 <49b3b535-3b81-6ffd-44b7-6226507859fa@linux.vnet.ibm.com>
In-Reply-To: <49b3b535-3b81-6ffd-44b7-6226507859fa@linux.vnet.ibm.com>
From: Lijun Pan <lijunp213@gmail.com>
Date: Thu, 22 Apr 2021 12:01:30 -0500
Message-ID: <CAOhMmr6S2gZX9RSTVRhx-qS7QdeB4QAGCAVf3AyxpkP5ndOhAQ@mail.gmail.com>
Subject: Re: [PATCH V2 net] ibmvnic: Continue with reset if set link down
 failed
To: Rick Lindsley <ricklind@linux.vnet.ibm.com>
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
Cc: Thomas Falcon <tlfalcon@linux.ibm.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Dany Madden <drt@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 22, 2021 at 2:07 AM Rick Lindsley
<ricklind@linux.vnet.ibm.com> wrote:
>
> On 4/21/21 10:30 PM, Lijun Pan wrote:
> >> Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
> >> Signed-off-by: Dany Madden <drt@linux.ibm.com>
> >> Reviewed-by: Rick Lindsley <ricklind@linux.ibm.com>
> >> Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
> >
> > One thing I would like to point out as already pointed out by Nathan Lynch is
> > that those review-by tags given by the same groups of people from the same
> > company loses credibility over time if you never critique or ask
> > questions on the list.
> >
>
> Well, so far you aren't addressing either my critiques or questions.
>
> I have been asking questions but all I have from you are the above
> attempts to discredit the reputation of myself and other people, and
> non-technical statements like
>
>      will make the code very difficult to manage
>      I think there should be a trade off between optimization and stability.
>      So I don't think you could even compare the two results
>
> On the other hand, from the original submission I see some very specific
> details:
>
>      If ibmvnic abandons the reset because of this failed set link
>      down and this is the last reset in the workqueue, then this
>      adapter will be left in an inoperable state.
>
> and from a followup discussion:
>
>      We had a FATAL error and when handling it, we failed to
>      send a link-down message to the VIOS. So what we need
>      to try next is to reset the connection with the VIOS. For
>      this we must ...
>
> These are great technical points that could be argued or discussed.
> Problem is, I agree with them.
>
> I will ask again:  can you please supply some technical reasons for
> your objections.  Otherwise, your objections are meritless and at worst
> simply an ad hominem attack.

Well, from the beginning of v1, I started to provide technical inputs.
Then I was not
allowed to post anything in the community about this patch and VNIC
via ljp@linux.ibm.com except giving an ack-by/reviewed-by.
