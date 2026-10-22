Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7628606A31D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=thgJdA7P;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HsyNE2Bh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9X5c0fx8z2xKx;
	Fri, 23 Oct 2026 03:43:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.80 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792687396;
	cv=pass; b=hBU2nKrkRu722/00HANIb1dRBpCHzhhZgIm31JVfpouaNt3pajfjkYdFDPf5yievxo0jAR60hpHtosl5XA+7T+Dvcb4VyG0LBdfi6wgQho3t3+5AIMpCODxo4IYdAqT+A8am7FUNl0pgCilYFQ5nxW0vm1mhqACPHGAT2tBJsDEx4JtOkGOln+l1J/6+TpOCPKGsV6rq/opI5sNATLurf0scs9W3xRB6GSrc2MrDRVjQy7vt+1gFctq9X5ZtVam6IoMX8P07KB0smPaVBAxI/yoYX0r9P2oyg4YHDH8aclxTkr4DvbTnUIug6wYCyQ/iq4uWXEyQ9uyVeDbne6iaFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792687396; c=relaxed/relaxed;
	bh=0YdO2+DcsvlJkeDUFu6+x7RRjGowhqUMvLmexnjMxzY=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FsjxfhWGUuLyiLU84qNjrYjTYKY2fqI9oHGU9359Lf1McqnB8z67wVeqGIF/W64W4iytRRUmqwcZ44l3WSEv9Nec27as+KnKDdcRAddB7VeuRO/tJ0Kzlb2ymQdLAa+SOTYOcoYtcoGDJAd+9UOrJgFkQC2ZOHwEype42G9FPoL+AlvxbJ7II6FW/zq618SIl2q7xSElvf8DjexjZRboCeeVdNk7nNl3YeZxOSBWAauWnGgmEC5XMpJhbInAhUmNUAS2XaNLSOuMyd/Vyo1nasP7OxWRFlu1b0mCLAgGEXxlr9+T2Iv/pLSljtS6G9Rcs8wET9kXhNE5+NzZ/TciIQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=thgJdA7P; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HsyNE2Bh; dkim-atps=neutral; spf=pass (client-ip=85.215.255.80; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=thgJdA7P;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HsyNE2Bh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.80; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9X5V749Wz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:43:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687381; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rNn9W+t4pF0fXUdQfinXmwB+CtvRbe66suql2cqsBEo7QyNQb0U3CFyoW1RgnKN4/f
    dqYy2Sy1BwniHI91xfvtLzGcFZ9KmtX3V9GQruTCxZpWeYkhwEzeduqnuy5YXciSIHTt
    HxD2osYOIPM6FZCh8YQc4PxyRKsIhLC9isL8OMX6wQV6Xyl4rABzzNQuXtFCtMh4PcmW
    /R2usl5CRWC9eNDAaPHZ7som6rDXvYP2x61J7TjlOAZPmRXqjZZ1v2zQHFv4iqR7GjqQ
    DJdydOIZoBKG0kDJ3/8hFoRHYY4YdS9B0BGjJPCCaQ/Q8IwLJ+0y5pDN2FSVsAV+5sHR
    sNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792687381;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0YdO2+DcsvlJkeDUFu6+x7RRjGowhqUMvLmexnjMxzY=;
    b=lF5rJGRe1eH2aQTDWib4it0jbI64QymZdlseo7Fh2yLxuCqp2ZgmQ4QSqbrMbRVEsw
    CeGl8aXtiyjYrzycC+WbXYjm/8XvCBtEoDTHDWj8Y2sg3mjgODDq7c3dX1JH/cNaThBR
    3NBlegzAVWUGSQ/g/Nfvv1xOGDW9OHIIn0S5iOJXVBc4au4yXH3/86TiHr42KZeFNuQm
    PT8RI5QsQN5ez0o4r567rb5hdKl8+cT+nAqbvAPlopmgShdqkT2qvns+CTUi6bBlE8pB
    STUNWX/BzMyog8bA1rLiZ4f8jMRfWWQeq+ENIBF5AJr9cX/8pvOFwC0SYQwJlEf3M/hA
    y9+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792687381;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0YdO2+DcsvlJkeDUFu6+x7RRjGowhqUMvLmexnjMxzY=;
    b=thgJdA7PZwvC9o6BMP6beSfNyYlHTdv98PyipcSb4/VZQTDaxon+7b5g2ZdVFYP2FM
    MGbIXhQ8LUtVc4CLo6tLDqqei/tUZ5GcGlW45VP1IBwu3FPj4Y5g5MtaHnbXMEyVRRwu
    bKiwVVlVEuYKwL2TJS9UKGuKAQKVPl2c/b0vH1vQX6AKZ6jt9Q7x/ht+CcK3GjRxcwvg
    5kP+sjrwHCodfgjH+djRllSNviYPHunSBbydz/oU1Rb4l5A3Iue+l1t8KE3NUBiw36Ha
    LLyf02+4GJsSWCLNm85TkGbTfW5frjVGGwsDghfDA/CvDG/tcTKwZvaELKhUYXagDjxI
    HAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792687381;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0YdO2+DcsvlJkeDUFu6+x7RRjGowhqUMvLmexnjMxzY=;
    b=HsyNE2BhoLKPDlVKI29Zv+Sm/0U80JF7QIu6g80w8cy0/maGXC+TkGtllNonZwHJrx
    /KnZTC7UhRDjK6iKQ0Dw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+l7Bng"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d929MGh0XeP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 18:43:00 +0200 (CEST)
Subject: Re: [PATCH 0/2] KVM: PPC: BookE: Fix boot hang on preemptible kernels
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
 harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
 venkat88@linux.ibm.com, nnmlinux@linux.ibm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky <info@xenosoft.de>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <754bfea0-5f8f-ba20-cf48-9c6131f98b49@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <9a77eaff-4c60-52a8-7e87-0d2f34099b92@xenosoft.de>
Date: Thu, 22 Oct 2026 18:42:59 +0200
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
In-Reply-To: <754bfea0-5f8f-ba20-cf48-9c6131f98b49@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/09/26 17:51, Christian Zigotzky wrote:
> On 28/09/26 13:04, Shrikanth Hegde wrote:
>> Christian Zigotzky had reported that preemptible kernels don't boot on
>> his FSL Cyrus+ board. The board freezes on running either full/lazy
>> preemption and has been an issue for a while now.
>>
>> https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t 
>>
>>
>> After 7.0, there is only preempt=full/lazy which removed the
>> preempt=none/voluntary workaround used to mask the issue. There was
>> challenge is getting the console logs which made the fixes difficult 
>> since
>> one couldn't know where the issue is.
>>
>> Thanks to Michal for helping in getting the logs. That pointed at few
>> places where the issue could be. This series is an attempt at fixing
>> those.
>>
>> Christian, KVM team,
>> Please *test* the patches.
>>
>> Shrikanth Hegde (2):
>>    KVM: PPC: BookE: Disable preemption before loading guest FP and
>>      Altivec
>>    KVM: PPC: Replay pending interrupts before entering the guest
>>
>>   arch/powerpc/kvm/booke.c   |  9 ++++++++-
>>   arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
> Hi,
>
> I was able to compile the RC5 of kernel 7.3 with your patches today. 
> :-) [1]
>
> After that I successfully tested it with KVM PR and KVM HV on my 
> PowerPC machines.
>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>
> Many thanks for your help,
>
> Christian
>
>
> [1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc5-2
>
>
Hi,

is it possible to add these patches to the kernel 7.4?

Thanks,
Christian

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


