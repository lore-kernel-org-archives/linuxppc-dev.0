Return-Path: <linuxppc-dev+bounces-23939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224EFC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 15:16:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwz811mLNz3c9w;
	Fri, 10 Jul 2026 01:16:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783610193;
	cv=none; b=DEQVraCX6UvLwBYT0HIQEIdH0Pgx0aQcP+XCnr35wf2t5FsjztatTidNPU9/MiNOvuMJMyA0JVWjaLlcaAVQHPzqWPbcjfWKDDeaP7V4qHDhZB1+oIageyYAi1rrEqEEz6m4xB0GSKWmDyQoClj2aPxSb3rCFwnbfZSzhL4olnAMyZRfvWMnzuYiuol16oNFs/6qaZ5qbEZcqClWwcH+KtQPZT/7GtAYTfwIhTrWlND9sV+oQiwiWZkAUSyteXrW8FPzRyJ7GN3GAaOPnPEtDnyw8CpnVrT1XfW62HK9pJlDM7XXS58rpW1HJeCnHuGf6Oa58A8OGGDStPhm8a6MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783610193; c=relaxed/relaxed;
	bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvwyKx578YjcLyA4O3HiqMAHtnec5x/l+puSWJdKw6vuK2xG8IauWVDGQQZ7mdsVBToSyydn/tMgSyxEzc1tlI+VulmZBFkf7/M7NPZ3fBFys4U0CGbRtHmkynMlkvXdybDaXZeOKIcyr2NE1cNCWMth57Z22Fxrw4Jz9dA8BGjNPclsyCPeG7q5J8GKGNy6FbvVKsmrfKAsKiE2d08geWsQ9pFvBmpiLBRf7VTh98oPKmjBF5LhmuknEzBTpyHR5aXptQERGJVTPMUJkByd42SHj9H2xd5L2cWK5xsgv5ITq0EY6ijW+NiR7IVnO1ABs1XSSPNDHmQpm0PHn5ctVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H/Fm+gws; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e0toPmIB; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H/Fm+gws;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e0toPmIB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwz7z0YXVz3c6n
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 01:16:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783610181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
	b=H/Fm+gwsdz82fWb+bTf/WhkwEDx2Ay3bpulrBPm7k3oG2ZZ10AXbXcFEa6haf5QZvSbh+O
	SDyNbh07+D0saHhwap/3fcXmuNtCQ9V7X55yh7Sm27RcIV1Gj7eC0qLBpG9QoDh+HF9mKp
	oUfmM6K7qRvib1CGe+KlQE4EaCG/4LE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783610182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
	b=e0toPmIB1Bc/1Am/M+O1Nq5tlHasabT1z/aBtXqIt17jElbYWsjc/VnZfOIluXHf6gaGaF
	7RPk/TxDCLgrohHU8lqJFYHgaJWVNHghcRntTPeagwzFrjwc6/RQCPnGRUNY3/Ofg8012l
	N+N8f9yuOQz8MMfk8UaXj5S0LTDWP7U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-zcJ2kja7M1-5J-jzvtXj6A-1; Thu, 09 Jul 2026 11:16:20 -0400
X-MC-Unique: zcJ2kja7M1-5J-jzvtXj6A-1
X-Mimecast-MFC-AGG-ID: zcJ2kja7M1-5J-jzvtXj6A_1783610179
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698c181a258so1260278a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 08:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610179; x=1784214979;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
        b=aFxxlwBrlJ7XK5E8cyuzK2UAG7/HTMjK/Jjb2r0k5Ou+dBVx4UyN0hQnBu/IaCWncQ
         D4b07uYXjTS4s8D4ttNxlwTG5+YU1a653Db411yHq4nUHP1VaXoUqsT7kr4I2s+EXdoQ
         5uO6TSFoVvZl4lNTz469un55+5QUp9MkWF6qEoFCRi8wNDkU4LmhdLCDVqXLVX7JFEO2
         U8bWgVJJCtYF5uzznM86wVQP7Q33e6HEsubX8MxyeoLutsz945ci0ND7i8wd/V5Vgi9A
         DgMpFtMwH6xLMhnFQ4WxWHjD2t105vdrtdN+N34spXp77eyPSOOuNa+VZCJGyWiMiDlP
         IL0A==
X-Forwarded-Encrypted: i=1; AHgh+RosVQWGftWictF6UC3j1b019AWuO4pE/e34nNEbinKr2E0GEOerIqBKvHg9/K7EGjlOm9f3bhSSKjkt3XY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyvl51jmSUFInSSbH7oKycx5xmkWlyr3XNbfPzUuINaKllDfT66
	vn8URduMp7YEAVlbxIcyRat810+6NQK4tjkCBxAByebXo3+pF5uIFTD/kVHE2Nj3KRxJwa7Arqx
	uPjE02a7AzhneoBKvWhLQarE1KA4jqV5tXFInxv2zqKFOGFJDeiFdltTegZqV2tiLAZc=
X-Gm-Gg: AfdE7ckG7QX/XoG2DzYsNOBu3RPQ5smwGOiScjBgH3lWb1LhXZzyUOjoGp1L0/0d8oa
	faalAbnZMmuxA3mk4uvVxdff3iKu5UyDFHIVsXfi5wcbMoHnptrjQFLru4rFvKgqCB/qJKYUq1G
	qfjACaXXvwmNrqHMl8HNarvXGk+o5CjHr2W3RcPkgT8e0RQTrYrGjyQ7/DFNuftJuP+emBCycFo
	DIYPKHbbsm7PnzsElBVl2yYrKkQYfS0N/+D22VWXpbvii48zY06vqlVmuXtUE2bPSQUbmrYnjCj
	EJlYj7aKpveJZuE0TOb78jTUDO41TCGWS8kam1qMSz2DumjErsrGCNhf3vJQIGLocxXM8/WOLUH
	ssQ7dCxsw
X-Received: by 2002:a05:6402:5d3:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-69ab4488cf6mr3022671a12.18.1783610179226;
        Thu, 09 Jul 2026 08:16:19 -0700 (PDT)
X-Received: by 2002:a05:6402:5d3:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-69ab4488cf6mr3022632a12.18.1783610178610;
        Thu, 09 Jul 2026 08:16:18 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4b4fsm9498949a12.10.2026.07.09.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 08:16:17 -0700 (PDT)
Message-ID: <73573868-2fb9-445d-b5c6-02166a0feb25@redhat.com>
Date: Thu, 9 Jul 2026 17:16:15 +0200
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
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, andrew.jones@linux.dev, sbhat@linux.ibm.com,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
 <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
 <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
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
In-Reply-To: <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PAXEtnB_7SeEAweDHr9EgVBHqz4Dyy9ppkDp2FH7uU0_1783610179
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2026 16.32, Harsh Prateek Bora wrote:
> + folks who might be interested.
> 
> Hi Thomas,
> 
> On 09/07/26 12:16 pm, Thomas Huth wrote:
>>> +++ b/powerpc/unittests.cfg
>>> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>>>   machine = pseries
>>>   groups = selftest migration
>>> +# make a kvm-only version for CI for now
>>> +# TCG accel support with Qemu and distro release used in gitlab CI needs 
>>> to checked.
>>> +[selftest-migration-ci]
>>> +file = selftest-migration.elf
>>> +machine = pseries
>>> +groups = nodefault selftest migration
>>> +accel = kvm
>>
>> This does not make sense (or I don't understand it) - gitlab-CI currently 
>> only runs with TCG for the ppc64 jobs, so adding a separate test for this 
>> with "accel = kvm" just adds a job there that will always be skipped. What 
>> should this be good for?
> 
> I understand it may get skipped in gitlab CI for kvm-unit-tests,
> but it might be helpful to those who can run it on their Power HW.
> If the job can safely skip on non-ppc HW, I hope it's fine?
> We would like to get it integrated in IBM's internal CI with Power HW.
You mean you also use a gitlab instance internally within IBM? ... otherwise 
it does not make sense to add this to the .gitlab-ci.yml file (which you did 
earlier in this patch).

  Thomas


