Return-Path: <linuxppc-dev+bounces-22398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F3FCD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:33:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb3ZK0jDCz2xll;
	Wed, 10 Jun 2026 21:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781091225;
	cv=none; b=dDQk3rStzjCh1Mwt7K3Ku602Uc0drzM7CYTaczd8pZue1V985Wicmt9QNTNltdVSG0qKHgMoxnck/G6GojY6tmhVtE67XcTbs735qn3P7yWmkbO273bpfclBfwVHtAkK50Sc8pcxM8qrmVJWXNeKMsYhY/BgE2E0JpmCkLlApqHulk0pKy/3FR5/pnNr/iDH03t5uz8p7rQWSSjBzbGasrWu1pH69bND3hd9eAM5ZgZW/hxMt3hnSNlypwJOH6azxY5K4RHNDr8MNW/o6gvpuSpnWdScTuZB8KKAhBvZPARik8MYX7/PNI+g/iRYFcKaXkimnftYM9zn0auve9O1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781091225; c=relaxed/relaxed;
	bh=/oZwouWpCJHhhF7JH6RfZNFkFN/gPqxP4sYNx2o34+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGmYf9KB0j3ES/i8vvPlspwTDot2XBRflPsDglIoPrV5G+H6teCQEZQ1Mu++ZU558yrFyC1P/7YPTrxI0+px3nwb0AqHnTBbG2Wd8nM/tS54t8FgLrBXnRGsZcgDjSTaAhsTO/qRQrxtNiZt1ebH9ICKXAHqzOML/eZJ9YY0McGldwjax5WnFGSxb/GL/gqUj9lSZ0LpiEV9Ip2pbaWX4e2eiK91KFuZvAmPrG8TdUiAz0XLWg7oM+kb4a8cUvWbsF1WlXX7OFq14hFtom5j+CY4fVecLMOl82WcOm9azCUY/Jz+O2RN35vDEOj7T+oAtKYdEv88/JkDmAv7HDtsPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KHDsM04Q; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jLeOh3Bu; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KHDsM04Q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jLeOh3Bu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb3ZH3FS8z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 21:33:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781091219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oZwouWpCJHhhF7JH6RfZNFkFN/gPqxP4sYNx2o34+w=;
	b=KHDsM04Q4UqkXdPlvruCcVhvj6ts5HprKHncY3xEb58GQYvUBn52JFjRzmHzKMR4Dx+y6E
	lp5zHq1pom/q0z0wDpbv/y1/Bb/dV8R4+pv7EAa8j8SJGqCbJf0gCx21R7+SsPkBl4CVgr
	an8Qd0EPawVRPw9K4t0SVq6jI9S9nsA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781091220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oZwouWpCJHhhF7JH6RfZNFkFN/gPqxP4sYNx2o34+w=;
	b=jLeOh3BuiUvG5cjmCSA8bnq8we04XyajiFlZgOKBo9jx884YPbahWz1NVlAsTJn10pDf8G
	lnE8WvwkifaFtKNgC5imV5X8p6F86e9xiXcVSl5i886ShaIYQpsc/WUjH/Y8096Px1FBxc
	l7P7eO4avWNggVgkIHsutd0yDbLeeK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-MZvewNPfMD6JA26T-PYsyw-1; Wed, 10 Jun 2026 07:33:37 -0400
X-MC-Unique: MZvewNPfMD6JA26T-PYsyw-1
X-Mimecast-MFC-AGG-ID: MZvewNPfMD6JA26T-PYsyw_1781091216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490abeb7298so69591865e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 04:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091216; x=1781696016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oZwouWpCJHhhF7JH6RfZNFkFN/gPqxP4sYNx2o34+w=;
        b=SOxzL5reX6Vfh4YPV/2SWE//AP6VgcVpW5CthqlK6njtnHqWqqz5QT3vGos/KzxsSQ
         Xr+dvxg12BcA+madnNg26HHx5OLzYkGIQBeRs1JGA2jBQDHQFTGDc/ghgDCpiiJw2YLw
         MYKlt/XqF6XkJLP7CDGTI5So/YkJMsSZYFncwGQrwebmEyaMx+ZlUWCx2gUNSMK4iBdU
         4aGV/gF9r1h2woUOTGb7mk/2mmS+mZfU8clPTkaVhnMsY4F872AQiv/3zDbHDv8SHsTd
         2X463q9nTDralTOSD8HyC8fV59UmsrjgUWGrxwnoO1/U7ek0vvDQclcXYosf5obKuZiW
         GKAg==
X-Forwarded-Encrypted: i=1; AFNElJ8rKbafCn5jarQ6uVnf5rO/DyCdFoA85FT/RUF59NGmY3YAbgAXA034eaha4AXogUMIL/oyf9x961MjH5M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZXWghVF4J+prCIxmWQUvSGVVP5lLw1+j2rhxpJB2bLtywqYFD
	ZalcY2qHfQwtA2ixEbB8+CXfPaqsVi4RbXZYgXPz6+CRJVWsV6m6LdqNbsGw99X8PIc54EcWXu2
	nZtkv1lWxV9xiML4LeRIY0lIiJBDMK6BYWiPvNbrUnrkmfQMcTe6x8sR90isU0Ah2ouo=
X-Gm-Gg: Acq92OE0K0/pa9MWoCnGScaLczPecQH33Vy6yXDCbugP66Z/H5oQUCcbWLr1vWJ3vJo
	x/S9Ih+T6HEDxfmXWnGuj1XgdKmsiWTbhtEMwG6QgbSzUbFkNCyP+82WSlNXmC0tslOLgEDrFi2
	zWR9vbUkORjOiGU3U79Ha+cg49XB/5bs3Mn5UjkslW4F5jPQkLcEBgDSOYOWji92i7nafBNWBXB
	heMXTW+CJ9ePI7vYk/2yd564VwVyaH/5ckrfzsIc6kBIY4vGvp62ctwwSkLM6MsmjlYuwaB7RAB
	BEnDLHAi8Xu4sGAKZaucL0/jcsLuwL4tpJ24EhPnApSEhpL+G8ONzT+Snll/i8A33F8Lcsfu5nH
	VIOA90jUcKfC1YnozlCtzZ+/b7RHibw==
X-Received: by 2002:a05:600c:37c9:b0:490:b629:286c with SMTP id 5b1f17b1804b1-490c259ec1cmr406864025e9.12.1781091215823;
        Wed, 10 Jun 2026 04:33:35 -0700 (PDT)
X-Received: by 2002:a05:600c:37c9:b0:490:b629:286c with SMTP id 5b1f17b1804b1-490c259ec1cmr406863575e9.12.1781091215474;
        Wed, 10 Jun 2026 04:33:35 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm41032525e9.0.2026.06.10.04.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:33:34 -0700 (PDT)
Message-ID: <ab4d83d8-1ffa-4738-b4b5-12d9a4f2d9c0@redhat.com>
Date: Wed, 10 Jun 2026 13:33:33 +0200
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
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
 <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
 <0c95c25f-1400-4912-befc-c5b32968d9ab@redhat.com>
 <a406db02-3aeb-4922-b6b1-8a030ca45a7b@linux.ibm.com>
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
In-Reply-To: <a406db02-3aeb-4922-b6b1-8a030ca45a7b@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tUtYVH7ILp9PXKj_CCAlQgj9l0pfFVQf-_Y2VeivGBU_1781091216
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/06/2026 11.27, Chinmay Rath wrote:
> 
> On 6/8/26 19:27, Thomas Huth wrote:
>> On 08/06/2026 14.45, Thomas Huth wrote:
>>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>> Add some initial PMU testing.
>>>>
>>>> - PMC5/6 tests
>>>> - PMAE / PMI test
>>>> - BHRB basic tests
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>> ---
>>>>   lib/powerpc/asm/processor.h |   2 +
>>>>   lib/powerpc/asm/reg.h       |   9 +
>>>>   lib/powerpc/asm/setup.h     |   1 +
>>>>   lib/powerpc/setup.c         |  20 ++
>>>>   powerpc/Makefile.common     |   3 +-
>>>>   powerpc/pmu.c               | 567 ++++++++++++++++++++++++++++++++++++
>>>>   powerpc/unittests.cfg       |   3 +
>>>>   7 files changed, 604 insertions(+), 1 deletion(-)
>>>>   create mode 100644 powerpc/pmu.c
>>>
>>>   Hi Chinmay,
>>>
>>> the problem with Clang on Travis [*] still seems to persist:
>>>
>>>   https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142
>>>
>>> Could you please have a look?
>>>
>>>   Thanks,
>>>    Thomas
>>>
>>>
>>> [*] This already happened with Nicolas' last version:
>>>
>>>   https://www.spinics.net/lists/kvm/msg351218.html
>>
>> I managed to get access to a ppc64 machine. The error is:
>>
>> /tmp/pmu-eab466.s: Assembler messages:
>> /tmp/pmu-eab466.s:1649: Error: unrecognized opcode: `ldat'
>> clang: error: assembler command failed with exit code 1 (use -v to see 
>> invocation)
>> make: *** [<builtin>: powerpc/pmu.o] Error 1
>>
>>  HTH,
>>   Thomas
> Hi Thomas,
> 
> Thanks for looking into this and providing the exact error message.
> 
> I was looking into this Travis CI job that you pointed to and noticed that 
> the clang version being used was 14.
> I was wondering, would it be possible to use a newer version of clang for 
> the job since LDAT is a legit PPC insn,
> that was introduced with Power 9, ISA version 3.0, way back a decade in 2016 !
> So I was wondering if using a newer version of clang that recognizes the 
> instruction would be a better approach.

I can reproduce the very same issue on a ppc64le box with Clang 22:

# clang --version
clang version 22.1.6 (Fedora 22.1.6-1.fc44)
Target: ppc64le-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
# make
clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
-mno-altivec  -I /root/kvm-unit-tests/lib -I /root/kvm-unit-tests/lib/libfdt 
-I lib -Wa,-mregnames -g -MMD -MP -MF powerpc/.pmu.d -fno-strict-aliasing 
-fno-common -Wall -Wwrite-strings -Wempty-body -Wuninitialized 
-Wignored-qualifiers -Wno-missing-braces -Werror  -fomit-frame-pointer 
-fno-stack-protector    -Wno-frame-address   -fno-pic 
-Wunused-but-set-parameter  -Wno-override-init     -Wmissing-prototypes 
-Wstrict-prototypes  -mlittle-endian   -c -o powerpc/pmu.o powerpc/pmu.c
/tmp/pmu-f0c247.s: Assembler messages:
/tmp/pmu-f0c247.s:1656: Error: unrecognized opcode: `ldat'
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)
make: *** [<builtin>: powerpc/pmu.o] Error 1

Does compiling with Clang work for you? If so, which version?

  Thomas



