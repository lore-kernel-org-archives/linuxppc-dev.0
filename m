Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9F606A325
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RxXntzIp;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2SNI8NAn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHSfq11Vxz2y7r;
	Sun, 01 Nov 2026 19:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.51 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793521747;
	cv=pass; b=gAcu36FDFTnFEDW49I5GR3UkYCWKVz5X6+QmckxXUY4jf7Snv6tA57aPPnKkC1dpcSmozak/fAY1mROfAXfvKONoDJNmnfvqZzMwDxwYNoo146eSUx7TucpLW5bKAUDjyMaFJAABCpUh4VH9bga/jSR0OaMgbwN7UJu+1eVjhBi0/qaL9EwNb6cIvOaWjdDsrjThrbgrdNqdx1uPUoT2pSvZAwMW1AqMvoO6qX7OqFvwJze1YSaIvbF0zpKZiSSKfGluo5GlITirlJbjf+AsIg3cYNMlWxEkqS6sv0seuHXibBuJTnIQEJTw8XKnlL3KAUAaLCU76fNsYVyDoLRY0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793521747; c=relaxed/relaxed;
	bh=vlZRwvKFZngxd4ogQEIfdVGvHi+Ew7cR4JQOBhK+k7I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KLg/3Tfwy/7ss7Z8xMB1Uo5XKGM/WyFMDZkod5TJtTdVkdIiysxSc9gyj1nMWbnT+HXrzjdtoaLUfm9C+9UqbZylFs5MsiKj5c+LCfamMSzHOCM+VWO0NLX8BJTM2BijdfLgKyFWISYf9Abe4tX7b+Zsx1Qm/gRQmIA/bIBmAw+pqjpKoKhynzWhrGGadEglTiYX9ES0ga4CcsbyEGp8H5OaDAHw+/xKl6BR+kt68lqkZzL1Rlt1+sWp0JLPWzl4eCOO1q0QSvnznLm+TnNjs+rFkUyE8wU368QEae+szyTreDEmHQyVZjwHAoAWknzKG0ANC7vItdgrcoYu7mAKYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RxXntzIp; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2SNI8NAn; dkim-atps=neutral; spf=pass (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RxXntzIp;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2SNI8NAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHSfk14B3z2y7M
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 19:28:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793521732; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AIRdNLJOJqxIo9tNGK3h0unlzm/BQOqJOiXBSN/3HNCMOGN4ifRya1/uiAIZiBdRn/
    xY3n6hNZ+nKq+PhiNSN1yBbb0wh/zvNBqWixvYQj2I/4MjXXJCRYdYwiVQ705WBV2Fy6
    Mr4CiQgp0yomrRtcAxk5Gf1kKjaqhHGeDTounV/IMq0gQSrCekSIU5rjTtUzEFkVyXQx
    g/EeZ+Lki5yKkw3orY8YpTuA5SlOuDLwKvqsGxLMpk57eb/1slkmGAbihyoziBnFs+AW
    HQsHaFWlw03w5RhrEEVG5ObqBYyEv3VzG1REV/ljqyQPY71z79SVYhxytpIlDFANzBT+
    1/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793521732;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=vlZRwvKFZngxd4ogQEIfdVGvHi+Ew7cR4JQOBhK+k7I=;
    b=UzRYZ5a2KajZd6OaAkrMHGyoGuA2X5HXhWBHMNu/PHh9FQGQkaITa2QuG+tY9pHoSS
    Ato/VGissC3uXI+E+o3dsdBkWTkqg9XgB+713FSdfvt1GwjxyedndhYOoFoDXEseNILn
    9qJvTU94NydHCpX29vVE6Wln20O40lKocbfLSWALm2ogBJ9D35edOfgPWY6dXZk1H4iO
    rgqNwU8FMFb7PjJKlYnoZqZj5oz0ep+UZe0XcjH23uVTrI/j1l5ZNgjum1aXjorI3ITF
    XYUL+9RKP6i8nwij+AaKsYmOJMEmfwWPfrq9bK3bgCqvWPCGwjahwC36LK5gdcy4DVM0
    Dheg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793521732;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=vlZRwvKFZngxd4ogQEIfdVGvHi+Ew7cR4JQOBhK+k7I=;
    b=RxXntzIpB7Qj5YerNFpUKiJZpSgX8gjwRECBk0VMnQTrfGRt7HaLu4EvvmYh1nEp+3
    /QPC5mskBKQHxa9giWV9XwniUUD/+/281Hiz0GeChvjD6HGQSJiqdwwFQkzN042W02D6
    YW1Luu93Tu4+9Xtl0S7BvCQM74cvVxN1bA2IFLw+2n2kzQ2SfeOiYRNNypYu5XmUbkjf
    Lu92LSHVknH4SJvuz/nNiLjmh8LQ5r8Rmn0oMw2TiUawoLrQJNrULnbagSi4jr0kusHl
    5NGtcEiXfrEUoYHb323zOHibjh/wZAPjkpJRnaNlT8HuwMUGpO+QmHymQEVueAzRB0VQ
    CGvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793521732;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=vlZRwvKFZngxd4ogQEIfdVGvHi+Ew7cR4JQOBhK+k7I=;
    b=2SNI8NAnWSJRFlbYf5jySV+sISntx9QURQ4Sge9Og+CQq9Djam9T0GfezkGlL6FT59
    qtjUz2mtLaFTK9teCcCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7xzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92A18So4xa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Nov 2026 09:28:50 +0100 (CET)
Subject: Re: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading
 guest FP and Altivec
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com,
 gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-2-sshegde@linux.ibm.com>
 <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com>
 <2a75097f-6b49-456a-bfef-d5e559ce719a@linux.ibm.com>
 <33tnw44q.ritesh.list@gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <15075ad5-73f8-4714-0503-2565ca3dfb4b@xenosoft.de>
Date: Sun, 1 Nov 2026 09:28:50 +0100
X-Mailer: BrassMonkey/35.0.2
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
MIME-Version: 1.0
In-Reply-To: <33tnw44q.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/26 17:21, Ritesh Harjani (IBM) wrote:
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>
>> Hi Narayana.
>>
>> On 10/1/26 4:56 PM, Narayana Murty N wrote:
>>> Hi Shrikanth,
>>> Thanks for the fixes. I had one question on patch 1.
>> See response below.
>>
>>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>>> index 13ad4cf5fa71..5b9118eefe1d 100644
>>>> --- a/arch/powerpc/kvm/booke.c
>>>> +++ b/arch/powerpc/kvm/booke.c
>>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>>>            if (s <= 0)
>>>>                r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>>            else {
>>>> -            /* interrupts now hard-disabled */
>>>> +            /*
>>>> +             * kvmppc_fix_ee_before_entry() marks the software
>>>> +             * IRQ state enabled while interrupts are still
>>>> +             * hard-disabled. So disable preemption while loading
>>>> +             * guest FP and Altivec.
>>>> +             */
>>>>                kvmppc_fix_ee_before_entry();
>>>> +            preempt_disable();
>>>>                kvmppc_load_guest_fp(vcpu);
>>>>                kvmppc_load_guest_altivec(vcpu);
>>>> +            preempt_enable_no_resched();
>>> Would it be simpler to move kvmppc_fix_ee_before_entry() after the
>>> FP/Altivec loads instead?
>>>
>>> The normal kvmppc_vcpu_run() entry path already loads the guest
>>> FP/Altivec state while interrupts are still disabled and calls
>>> kvmppc_fix_ee_before_entry() immediately before entering the guest.
>>>
>>> So could this path follow the same ordering:
>>>
>>> kvmppc_load_guest_fp(vcpu);
>>> kvmppc_load_guest_altivec(vcpu);
>>> kvmppc_fix_ee_before_entry();
>>>
> Thanks Narayana, that actually make more sense to me.
>
>
>>> That would avoid making the software IRQ state enabled before loading
>>> the guest FP/Altivec state, and also avoid the additional
>>> preempt_disable()/preempt_enable_no_resched() pair.
>>>
>>> Thanks,
>>> Narayana Murty.
>>>>            }
>>>>        }
>> I thought I had put that for discussion after ---, but looks like I forgot.
>>
>> I don't mind the above too.  but I didn't have a way to test it.
> Actually I agree with Narayan's reasoning here.
>
> Sorry for being so late to the game. As you know we have been occupied
> with other things internally.
>
>> So kept it as is based on what Christian said works for him.
>> If you have a way to test the patches, please let me know.
>> We can try that too.
> Let's ask Christian directly :)
> @Christian - Once we have v2, would you kindly help us test that
> please?
>
> We think the other approach which Narayana suggested might be a better
> fix for this and it can avoid preempt_enable/disable() dance. However,
> looks like we may not have the board where we can reproduce this.
>
>
> -ritesh
>

Yes, I can help with testing.

- Christian

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


