Return-Path: <linuxppc-dev+bounces-22397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75CDCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:30:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb3Vt29qBz2xll;
	Wed, 10 Jun 2026 21:30:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781091046;
	cv=none; b=UMB8m+E7ORsb19Al1mMuuhUUPGVWO8ArrRrx6zKVGK13/VKO2U+uBd8wQRzIEhLum3zkH9kwJCJ5lBZx+lr0WdInGLqYdelr8KL/cHA+kja6S3uH56ifV+vSBOzP1LD8hYhJEGSDuHVszDgiGeE5dUTkTLMQ3aMEUkLvoFlgCHcioFUuVNsQZTBf5lBfiYqDlMrVJQKeCN4ZvJR+nTe/6bWQ8EYcJ+cMwlsRxDWJX/P7sXqI78EoK93VDOIwhf+IshYJ2SQMiAbfdKO7t68grvm+qng3o9R01ES3gkAz2jVVlE1q2UNQn/6eqyEmR//jkKL5Uxpg+QY7NifRr3+rDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781091046; c=relaxed/relaxed;
	bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr3G15ZKePS27PSdtNBP9+SAWO7gymES/uJZEo/eiH/ZGSeb90Jtj1M0ENVRGLTSLWUAaOIOGAMqB79yGhNk3+ghTvm8Br6oMxchCAya2YhEFzcmzlePVyOnCePP8pg72ow8k4HqgsF/z6RnGIs1NR4FViyc349YMi3W5dDoFiFwlQkTchVmTbWWUF4XLMwqoutVesb798ZOwLLvOuvLmYXZRwlszz48mm+1FYRW1CPZ/QsswdAAHmE7HOBLM99XQRpWfBM4R4EFJEGOhWAqHBItkV62de1No6QcKI/jR4Bd9fJEQYqQ7VrVQCfgVSnLwzSEO/CCf6PiFK8hPmkstw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKbfbZno; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKbfbZno; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKbfbZno;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKbfbZno;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb3Vr4bDGz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 21:30:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781091037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
	b=GKbfbZnoOjSzm9VF6MsCVJczTttVeABLW56JgjxrHU+AIuIyfnIijVTkk9XmSXmaKjl6qe
	dkDMpEoSWgWwXbJI/ziaznftH6uhibDba3+jpC/hcvcj69caVPmQBUskd89uVtTT8r233S
	rcAphsg21rl93hucivdMxm/rrYi/FDc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781091037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
	b=GKbfbZnoOjSzm9VF6MsCVJczTttVeABLW56JgjxrHU+AIuIyfnIijVTkk9XmSXmaKjl6qe
	dkDMpEoSWgWwXbJI/ziaznftH6uhibDba3+jpC/hcvcj69caVPmQBUskd89uVtTT8r233S
	rcAphsg21rl93hucivdMxm/rrYi/FDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-0DTzr-YMOCu1m1hf0QUx7Q-1; Wed, 10 Jun 2026 07:30:32 -0400
X-MC-Unique: 0DTzr-YMOCu1m1hf0QUx7Q-1
X-Mimecast-MFC-AGG-ID: 0DTzr-YMOCu1m1hf0QUx7Q_1781091030
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4601102c30dso3774635f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091030; x=1781695830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
        b=Ak5XTS4o1hVigutnaafQE9xIqVSr4BE9Mw6wkh1/xILDe/qBxJ0R7Oash20uAdrVKq
         g1RFahnswtfd/hw3x81WieTIUpEjtQkMP8zFP3OgskV8kBqoCzUpA91q9tCaahRtBmj8
         XkWJjbSTo535LKJIycz3stIwyx9cQITlzzS1KR375NmuYuSyW4Mk6XJ0aY+NVf4KSxZT
         QC2yMLeRYHLHAvfmkFLXY2OeYj9VA5usAsVbr3iLGXsSDSS2rAzxMvXCoaof9lbFfW6w
         GT3AihzeyhZGl0vhSvFWgl8DF0n2qKZvDZ4euGxlWAk+/leNrbeJYjLgjLW1RG2UOmdT
         Q0tw==
X-Forwarded-Encrypted: i=1; AFNElJ8eeY2YS48T6NqlViEh5NHb629Qq5hS7/2AktEd9X/aVvXd7NeVurZVXdZ/1SZGelUNH6FouoCx2zNptuQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJNmOR9TTozVTyrbq7taIFcYZVvCGaKONoBX2/W0IaJ60ektXh
	J88/UdUqZM1/45C4URwJyYxjgqThV6JeiMDB2rxw7/N+6CEmSiCu2DUs/WfSTlV/z+w3C9nyWf7
	rlMZiwXR3vBxfwqnqBTstZXOvur+lu3PoybiA2ToChD2QHFfDS25yYGF4onyR08jXeyw=
X-Gm-Gg: Acq92OHVn56lHxfMXFmG3ZFnChwsXTb6BOWOM1waXrtpDNr7PLvXC1XS4Dh/BXU7DTR
	VY3B3kYO1ECD+QGLVJGH0f+x8yX+h94ONl288w21Y7a28hI0qeccU1Ib5UqajVd/dkOBLrmy+ZZ
	KOzUr0E2FceVd1DFd0qICMgGhHP6W4EdR/dyM50FTc97bQ3jTblSJHRX7wX5l7fXzOhVVebzt4A
	l4Q3PUGVCoINpVTz92ZXjrI9awrZi4i0a44i2XKnd/AU6Gvhw1H0Yb+OunXN8Zzakl2E66MQyTG
	YxLqXtgwenA5OwyL3olfvuLSUfoHlT6XDXPA3qTElkwNj803JI+B9cuFog7ESxYC86OqT/+OpOp
	1EsRgIHJb4SWF+rWZVZrriR5jg3wwOQ==
X-Received: by 2002:adf:e00c:0:10b0:45e:ea46:3346 with SMTP id ffacd0b85a97d-460304f0a0bmr25751363f8f.6.1781091030335;
        Wed, 10 Jun 2026 04:30:30 -0700 (PDT)
X-Received: by 2002:adf:e00c:0:10b0:45e:ea46:3346 with SMTP id ffacd0b85a97d-460304f0a0bmr25751317f8f.6.1781091029954;
        Wed, 10 Jun 2026 04:30:29 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm77961462f8f.5.2026.06.10.04.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:30:28 -0700 (PDT)
Message-ID: <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
Date: Wed, 10 Jun 2026 13:30:26 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20260602064806.3101025-3-rathc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZGRk1OoJ6DL3DLRQgyYTny2_jleSkbF3eSLmlHeO4TA_1781091030
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> arch_libdir was brought in to improve the heuristic determination of
> the lib/ directory based on arch and testdir names, but it did not
> entirely clean that mess up.
> 
> Remove the arch_libdir->arch->testdir heuristic and just require
> everybody sets arch_libdir correctly. Fail if the lib/arch or
> lib/arch/asm directories can not be found.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   Makefile  |  2 +-
>   configure | 20 ++++++++++++--------
>   2 files changed, 13 insertions(+), 9 deletions(-)

FYI, this patch seems to trigger yet another issue with Clang (I used v21):

clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
-mno-altivec  -I /root/kvm-unit-tests/lib -I /root/kvm-unit-tests/lib/libfdt 
-I lib -Wa,-mregnames -fverbose-asm -S -o lib/powerpc/asm-offsets.s 
lib/powerpc/asm-offsets.c
lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found with 
<angled> include; use
       "quotes" instead
    10 | #include <asm/smp.h>
       |          ^~~~~~~~~~~
       |          "asm/smp.h"
In file included from lib/powerpc/asm-offsets.c:10:
lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not found
     5 | #include <asm/processor.h>
       |          ^~~~~~~~~~~~~~~~~
2 errors generated.

Could you please have a look?

  Thanks,
   Thomas


