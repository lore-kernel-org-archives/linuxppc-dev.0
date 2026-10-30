Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20D606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y0OGAehq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGRNy4JP2z2yK7;
	Sat, 31 Oct 2026 03:28:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793377714;
	cv=none; b=eDcUwU8X0A3/8s0RYfnHLOXZlRd7aPJ5n3t0Y90wAV1jd9cZufLXRGoVL0iez4seIp5wEyRZ134sUanoXdOZ6f45W3wf/pkU1VYfUoyGKMtjSnsYH56bfcl0hCEvTWhuel+YBrc25fIaZQLTooC1wAIsOVfwPS5ono3/aAzTynh9RRmROJdVeWuGmYWT/M1ZG6LicxIXuwziKZA+dPMpS6nm/4f6wBZRvBAzZ2ZPweUQTino9WnEluAS5Jz4PaXVzVKLC4OS8MQ43gqXO9e83xHkZp6ZTVoUk1SiNt5h4o0qFJksbIcVMiHUgI/r7IORqZTGwZLBT0V98rY0HenoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793377714; c=relaxed/relaxed;
	bh=zK67Y4b2DOq0P3AA25tQ78azoXocIOXbPIU+g9MOBt8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=oVzLp9eLWZjj83m+U0mZuyXxF/chhpgJIwY8A/aVI5GfnjL+D2Kz/Vj/2tTdYOb7Rhk/AI+XvxZiZJa04U8raJs0iVG8w0R/WQ0Jrc5dWo8JpLYKwVVYTDvaYlkJmFKZBmLdlUAxwPNEZ+5PTTrTGeL6a89+L5z8Cmzr6iNQOXdffOjQMNUPHOB2A+QJ4NTmXYKZD5q4XopVMk5umqhaijnZ8vpAsWvxlw+hd+8QLXD+9cwcspPqwXOI2gR9bYYXz6/Rp3++i7Zbra8n9Y1tCNYdXROGEG5sX208xcs2YnjCZIrmAILA4MVu9//ywCCD4soKGSuVsTaajT+J8XCwXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y0OGAehq; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y0OGAehq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGRNw5SrHz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 03:28:32 +1100 (AEDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-48eee44b908so553427fac.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377704; x=1793982504; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zK67Y4b2DOq0P3AA25tQ78azoXocIOXbPIU+g9MOBt8=;
        b=Y0OGAehqX+JJCfqhY30TmUW7wIACHIofxYmQGFpu0GmrUgIateskPY8jjKZkJt9wDR
         33ULxcwk4ZS8IEp3PoT4FSEUEKGFcAFz3rrpG0uca3T3kUK1l+TG/pdWf/1+DpfNNm61
         MkGk+tfwjOrWERAXI+7GwGh5FI9LFvBaSe/l1VvLNyizznAmkwLqKl8oXsGmsse/KRav
         +aAkqv5ib/cAlyznzW5nw6xVqE2wZ9B/nwqrXPkUOCfgFIuDXwqxDcM+sHTO4n077flm
         43rz41Xek7sVPUwlvFnt9st08plzswO3vdZVEIC0aSzj15D25utrNtInP+LpmlgKFnD0
         fvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377704; x=1793982504;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zK67Y4b2DOq0P3AA25tQ78azoXocIOXbPIU+g9MOBt8=;
        b=N98nhTfVlJG1IR2MVSs1RjnOCmcFITrElw2mGJJrHZCS2+rW8z453whPQe2LV9PwW9
         hnQAGFgfXUhAZRZtGvZU3wr924g/1ExFfLqfwD3nWZWVyF+FfsFTChgsROgVzgVbg+f/
         bx2+bvlbc5BjRI/O4ko62ASjFKkC20qUB3/R87ZFZHC+H78boar0vUI2r5W5BLmaXRHw
         MKJHb2aEmcqja8kGyJnQR1SCICOXmiH/uOb+BwgKcuVyxRP/xju7XGkgsxF5Me0HnUj2
         d8SB2CRE+DxGn02rZXTM6VR8vdr3pKB2LROEj451d+1UibBdmPpKW/eBLlB65ed0B17P
         /fag==
X-Forwarded-Encrypted: i=1; AKwUvBzrjINX+fm9Oj2XDdNg/ulQ5kdxoGPMCU5UG89fRkaRBwAz7Oafg5OqyB+3wiQ7sb/1HqtDbJBsSE1eF74=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVT7m4pKLEg3uwR+jFhdruUJjVo1N6JYqt5U8YTj0Hp32+afJB
	dcAFFgiwX+lA8Aa0InHUWbLWQGBXTR6qiaNoCKg+xJCtZXfcfxsrCZyI
X-Gm-Gg: AYBFou2Meh9zGubzNEJYXVmlymc/xjsmMsoeTs74SMV44W2P/dg5tsUPmQ0P6kmJrZI
	Ri3HkSqNveZCCNKIc5cipXpuJu+5RW8vlRr45NBAkzzLkX2I8wX8AUJ1zJ+GPg/5p2oHQSeMDJk
	hfijiJKeAEQEbGhHfNtp3xb1otDLqOZcueLRhyLKuPZzjpsH1HYAnBkmyNhY3Y/42ahnYZPMg9h
	BjLK2zGGlevJQX1LUZ3M70W8YGO5dsivxiBmlQovOAVK7UMwG7GLlJwiAvqCLvROg+fPhDiaCX/
	gj/5RqgOUIR6tol2vKrZo4036y/hf0D/HAOr/wa8PbuJV+DJDCCKXmcp9dzNIwYKBwiyr1OYFra
	ho2BB92TDn451+jloNwcK1Fox405g/qmiQ9iNI663jZWZJExp5rjoBUjNPXvR2OBZFWpY2FiJwY
	qftC9GLACcyBgw/dnZ0GJPONOfMNPX8ScPJUSLmtiP9+2s/MzBjYMRRV1dPYypl8ZO6tk5gboiQ
	N7rqA7N3voydHw4uDwraTLV2RZ3Wp58S/S4lul8B/yQBhYgEvv7h7zPXLvQtx4MxXw/jv9exnoQ
	p9Y1G/vXDwCrlMHiH9MXyPLl2qT5A60URBt/2a4880yb5z12Zw==
X-Received: by 2002:a05:6808:f13:b0:4f4:813c:6a21 with SMTP id 5614622812f47-5640dcb87admr1936746b6e.20.1793377704392;
        Fri, 30 Oct 2026 09:28:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe0d46dsm1916622b6e.11.2026.10.30.09.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:28:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com
Subject: Re: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading guest FP and Altivec
In-Reply-To: <2a75097f-6b49-456a-bfef-d5e559ce719a@linux.ibm.com>
Date: Fri, 30 Oct 2026 21:51:41 +0530
Message-ID: <33tnw44q.ritesh.list@gmail.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com> <20260928110411.844582-2-sshegde@linux.ibm.com> <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com> <2a75097f-6b49-456a-bfef-d5e559ce719a@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> Hi Narayana.
>
> On 10/1/26 4:56 PM, Narayana Murty N wrote:
>> Hi Shrikanth,
>> Thanks for the fixes. I had one question on patch 1.
>
> See response below.
>
>> 
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>> index 13ad4cf5fa71..5b9118eefe1d 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>>           if (s <= 0)
>>>               r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>           else {
>>> -            /* interrupts now hard-disabled */
>>> +            /*
>>> +             * kvmppc_fix_ee_before_entry() marks the software
>>> +             * IRQ state enabled while interrupts are still
>>> +             * hard-disabled. So disable preemption while loading
>>> +             * guest FP and Altivec.
>>> +             */
>>>               kvmppc_fix_ee_before_entry();
>>> +            preempt_disable();
>>>               kvmppc_load_guest_fp(vcpu);
>>>               kvmppc_load_guest_altivec(vcpu);
>>> +            preempt_enable_no_resched();
>> Would it be simpler to move kvmppc_fix_ee_before_entry() after the
>> FP/Altivec loads instead?
>> 
>> The normal kvmppc_vcpu_run() entry path already loads the guest
>> FP/Altivec state while interrupts are still disabled and calls
>> kvmppc_fix_ee_before_entry() immediately before entering the guest.
>> 
>> So could this path follow the same ordering:
>> 
>> kvmppc_load_guest_fp(vcpu);
>> kvmppc_load_guest_altivec(vcpu);
>> kvmppc_fix_ee_before_entry();
>> 

Thanks Narayana, that actually make more sense to me.


>> That would avoid making the software IRQ state enabled before loading
>> the guest FP/Altivec state, and also avoid the additional
>> preempt_disable()/preempt_enable_no_resched() pair.
>> 
>> Thanks,
>> Narayana Murty.
>>>           }
>>>       }
>> 
>
> I thought I had put that for discussion after ---, but looks like I forgot.
>
> I don't mind the above too.  but I didn't have a way to test it.

Actually I agree with Narayan's reasoning here. 

Sorry for being so late to the game. As you know we have been occupied
with other things internally.

> So kept it as is based on what Christian said works for him.
> If you have a way to test the patches, please let me know.
> We can try that too.

Let's ask Christian directly :)
@Christian - Once we have v2, would you kindly help us test that
please?

We think the other approach which Narayana suggested might be a better
fix for this and it can avoid preempt_enable/disable() dance. However,
looks like we may not have the board where we can reproduce this.


-ritesh


