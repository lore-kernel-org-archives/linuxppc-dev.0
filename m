Return-Path: <linuxppc-dev+bounces-27125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA5C88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFn64SxCz2yd7;
	Fri, 11 Sep 2026 23:31:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103552;
	cv=none; b=LW5xlRO7QbRjw8t9BVkAx7yTdG93Efg9KLBOgTMF6dnzkHYkrdhcAupwq790dnuNS3+sOp2DPxA8qgHfyCkS0mrV/Ibr8n/NQuH2tBEyyHyWIWSbQ2+iJeF2fOHrxj/D1jTGdg3dsExZ+cQN4cyZl+gL6yRz1BFIMsk8zDELGimHEobF960LSAoOzL8v99Lj3wP6VA6rCs4ypb1p+QTgJXBfPg7zNs7PpmTFj/RVLMYqOsxPP7hj5OKVIh4VB/8NnVFngQCWVWApGEUmdjWSZVz1sAOQqsbY2JJJiPlxZz8/7b8He2GQZX6s00aX153A+d9CFN1ksyzk3K54lg/mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103552; c=relaxed/relaxed;
	bh=OlRZtYV+1fpP3ddBk9E8lebOfNeWpfbF1q0QVOt77gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9y2Kg+X6I6pHcIaEWbaN53WENKYIo1Y0s8bhOIxVQMQJ7IxZqe3HPihnuivSBVZBHJrpBizwhI4kASc8hlzC62Qqs6cGGOpLmoHz9/sOp+q579t0beanY/vUJGXXfvODtP1AQz67WlEG7xTXR7HSPv4ttuu/JlYN/hPM/BxE3AuRgWJh07FFsbVRK26tcI+DRF03VGi8AA5ckBiYzgkL4s4XlgdArjLyIf8Z3njnhIoEiEilea5zW6RTM4ErWOdP1BLvzTA3b88YVmx+WrTUCri0L63LbYL2SwTnOjMhnLUjU98dyvRFHPbUrXiCHvKdS/FQ2d55g1nAGaqFy0Cqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LM91Nb5s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LM91Nb5s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2jV6MFWz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:12:30 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccafb752so481777a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103548; x=1789708348; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OlRZtYV+1fpP3ddBk9E8lebOfNeWpfbF1q0QVOt77gw=;
        b=LM91Nb5sTj/SfDHX6wBiWU0K/vrADbjzLcc4S/DNlrhglQoK1Z/ClVE98uQHZuht2H
         q6+W89oN+p/6EfttuwUQ0IRc7/4kac0rBsw4bjYRTwEayM2+Df0HgHbpflDBAqgACnxr
         gB/vIwGlQXh7tZVNIhPy0rmS5e8cz+pQrslRhNhIlccCDwEW9NFo+HMSH8aDzzR9Kxaw
         t5z5CjSp507BMDBZM8kCeFBvWrUs7fFhhrrIk2QjeNIUuxuElP6ygIOZXJsZo6Ly02Cu
         bX0voZqMpIldsI1CrrjquFswzETkuIHe6YGi9Wr0xH5pfzPUDjMU/10teNm6KO7q3Z5G
         qtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103548; x=1789708348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlRZtYV+1fpP3ddBk9E8lebOfNeWpfbF1q0QVOt77gw=;
        b=ACCYkfC8khSFYjERkk10u+ehpQKcqaDABRQshmj1x18CJuRYk3ntBZaJ+A2/BWPUdS
         qnNhuIFt5UusZc+I7t3bGYxKQNJt8HkzCq0oBs/KIbzV9P71lIct3RD4HK3cn7wJZ1Xj
         YnFsmTjYDNRa+dnFz4g2q9KqGMN8+Zm0UjqbNiDgltaI9N8hZSoQDWmOZjox7qycPoYt
         DmxqXtx0oyZrNMeo+8CFK5M8qYFP97Z/Hz6cigxJu+BT1tu898uWVYWetrT6UrwYJGnc
         4YBShErG0+JVc3XzpoNT9vcJc97lN7kllPphnm0r/WtIY33xrC3h+F0rwJrBo6sx66Op
         aqZA==
X-Forwarded-Encrypted: i=1; AKwUvBzmT7VvJT/ZCnxlGJncwlNEMbS1JxqanSH825WdB3Ot5mIff7ML7afOc2rxs6ezWl6rLKERM1af72J6Ov4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++khiuVu/1nTyxfWyf/eQZZs6DmOfwKWZ+KEMDNqlsjl0qv9+QQL
	xGdDij0CTiwDpmKcM53sPr0hVZhxDLiJcKfJLdwAP3KWXfa7Rr3g0CpI
X-Gm-Gg: AYBFou3cDpl4vRQRMBlYAxXp0JqvKJ3N423YFlugx6gpxFBj67HJmWLS0h6q/9MZqY2
	xs+xv5WebQSAOcLJYcI0R3yimSynyTYiIaChj7hdnt+kMfYKdbNlNrR5VzYurLEEyWBBBCPnLMZ
	RAobVCAYdhtr6O/M3zPzJjb43jt0r0+UBcJUykWt7V33B27LS/Fx2m+zwgzrKts1V/UZ4pktrvN
	wYcPIshcVvqtydaktXo8YnlVAoj5F0CLQXzY8DHAquqf1p3+HUxeR85x5a5w/+6jf1IWql66rM6
	YU/4kafB0V0GLjXSyUdn1cBlv88qCLJwCF+E1hgY9vP3tvffn6s1sr8hwV6YfXQMtcx8jbTLvUg
	4xIAJDd0LyLF6RQai/XtEXO9ePnCQWLqcaG8dwzQsAuCRF/oFKycCcvPmf67cAWYAcM6ksr8a2z
	CRZmHvqxLy4sKHlXpP1o+eQhGM+7Brv/NCSB1creZ/kLTKSRhpBniXjVJDl06ZLIRP3YhtjO+eU
	AOMMNbixGSOONxF6eeCqMVtD92nYaNu5nALPIUImSlAHA==
X-Received: by 2002:a17:90b:57e8:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39d9c22762emr4738880a91.20.1789103548082;
        Thu, 10 Sep 2026 22:12:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bac1c716csm1324643eec.2.2026.09.10.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:12:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:42:13 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, 
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, 
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, 
	kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com, 
	agordeev@linux.ibm.com, segher@kernel.crashing.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
 <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGBCmA0+28G=V_Qs37cR2GKYDUTGQWW_uRe0qvEp5io3qQ@mail.gmail.com>
 <CAE4VaGCp7A7NuBC9Hwgzs5xg3bGBuRiDC8PRCu+yXnUZEXmt-g@mail.gmail.com>
 <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com>

On Thu, Sep 10, 2026 at 09:58:59PM +0200, Jirka Hladky wrote:
> Oh, I forgot to add the actual results from the LPAR:
> 
> Model name:                  POWER10 (architected), altivec supported
> Model:                     2.0 (pvr 0080 0200)
> Type                                         : Dedicated
> Mode                                         : Capped
> Entitled Capacity                            : 1.00
> Memory Mode                                  : Dedicated
> 
> Results (median bogo-ops/sec, N=15 per cell):
>   Mode          7.1        7.2-rc4      Delta
>   Enforcing     68,275     70,154       +2.7%
>   Permissive    68,082     67,166       -1.3%
>   Disabled      99,654     100,510      +0.9%
> 
[...]
Hey Jirka,

Thanks for confirming. Also with the diff I shared, did you see any
difference in the performance.

Regards,
Mukesh

