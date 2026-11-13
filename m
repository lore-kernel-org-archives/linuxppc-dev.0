Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08931606A8AF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQwsM5LLyz2ySV;
	Fri, 13 Nov 2026 23:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794571447;
	cv=none; b=hSywkpYwPzYtpLuGUIxZxYTK4BFmFtajj/hbJyZYsK7qwfKUKXFOMrXLSqHhS2StG3+P4kMjClaq+EofVy+rLQW3brtS2/9OrNcmgKAeKyD+2S171KEqA4oBp/r5ixQfmcZJ/oF21CVzzG3pyyKptGq0T6XFsh9F63aJ39Dr+R7xUUyZ7StGDdBWnMFLxvnFQEm+65Ac7HdYP73N1gT6V0uORgc3hhK65yB9GSRJfH2+7eZMtwu/E133twDr3NM3rIuNrwUMp0palu1Sd6bjASoQDYohwPbXe3Mramywzjt36KGxtZ+a85ipmcatyBoFnHDF4dVjGvnpAMV3ejZu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794571447; c=relaxed/relaxed;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lCXBoiKMTe4QA30NYs94ZAYSCwTepZCBqkqlPKT3+QlQQbPvtyogQ08zXoltexE0JCDuTlq4eAECv+4YjQ4l+pE5CTIUjEFU4n0+ZlXCGdSOjDRHVtJvggZsPTzbzGZEUnJY8GiefFTJbu4P4B64RKIpEW9vemPZMVkXzr+Lks88abtV7lF32jg1Ych/1c08sxbCDFDJI6zGRpzqPpp9qhm9FgcKKCnvNaUtNXmV1WaYfiw62OTIcLbpPOVAxwDnEy25QOsLrUPg2l+D7Y2ppVpLOH3y4L5t6cEbySJSZFu+554+ghty6X6PEq5UZdALKFhVfYyf6rdcdeXEcCGEQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQwsL6HgBz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:04:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794571444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	b=b3WUoynU+xYy77iKucujOEClblu6BnVpmDkjnUNrvt0rV/yne/HsVWEw1IwB7AFJj3GY56
	CZrXjSa2iWGgMeHOoT2zPro/PG7zeX9XUjqUefgmbNWHXh7K8WFMpIz87DDC8GTItA2TDl
	yhcri0aqIHWfQE+8KcVlgxOIHzAT6Q4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794571444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	b=b3WUoynU+xYy77iKucujOEClblu6BnVpmDkjnUNrvt0rV/yne/HsVWEw1IwB7AFJj3GY56
	CZrXjSa2iWGgMeHOoT2zPro/PG7zeX9XUjqUefgmbNWHXh7K8WFMpIz87DDC8GTItA2TDl
	yhcri0aqIHWfQE+8KcVlgxOIHzAT6Q4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794571444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	b=b3WUoynU+xYy77iKucujOEClblu6BnVpmDkjnUNrvt0rV/yne/HsVWEw1IwB7AFJj3GY56
	CZrXjSa2iWGgMeHOoT2zPro/PG7zeX9XUjqUefgmbNWHXh7K8WFMpIz87DDC8GTItA2TDl
	yhcri0aqIHWfQE+8KcVlgxOIHzAT6Q4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-2udTNM5qPZWcVzT7-qXnAw-1; Fri, 13 Nov 2026 07:04:02 -0500
X-MC-Unique: 2udTNM5qPZWcVzT7-qXnAw-1
X-Mimecast-MFC-AGG-ID: 2udTNM5qPZWcVzT7-qXnAw_1794571441
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so9605445e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571441; x=1795176241;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
        b=N4keUJd0zgfjFJHm23MGtynXsuqA0iO870imzQ6QM7PSbTe3QerpWVNSKaL2BsC2JB
         kJTVrvanmArH3SYMSvYULu6pRpUEk9/vwWG0h+ZNpRSZrGMPwGb9WIdi4jwnYJMI+4D5
         /mLarl0p/ohpOETHZzJXX+z7uYmIOwO2dXjTi9c7F8uY5SK59ZmhJCDbrV9gzVG/AbaD
         9yXKTQoKnEuNcRjpFop3WNKU30dHoA/MRtWlvW9Hq4HeHu8R3ndXTO3UOBYZZkdyC8qZ
         B2Hn/PVbjJpEH+6bUWxHgJkZIVMaNjccvXh0xjRBZdND4VAiU4FyydObgRXew4HcyDO1
         7d0Q==
X-Forwarded-Encrypted: i=1; AL+hErE24wdVWLJvkhqhmZEv3Gy610Wr8BYqLnvzf/kY1MhMTqPIiG0gcafsLRXPr/Kc6jbcdOC1lqTklqH97EQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/+09oeyGAPN1DyOsw0VgzHJ8juOJevaoIcyUqJYRu6WTPwKcKq
	aSmTndhEgy08cfXkzs4Clri9ZOIlv35GSxJnxVCES0XiSLVbLafxxlJQ0iGiAY5vf0uus/dqLCS
	ZTfem996SRvocq4UputCyWMwjndqWLEr6kpVOGwYz0UCJTEx/5swO9Yx7z8jKEpSbf1A=
X-Gm-Gg: AYBFou053un/oX9to+6vAhIjoewkl7riQ83phBKoS/PZm2F1D+a2KZ+yYIUoOXeRouG
	SPq+bg1SMRlMRsZ6dpSG7dJk9anHRR66QZiWy319g8IAQfai08U4hQcg6+51ELyXsb/+Kb5haNf
	/ex+2mEC82wo/XLKjWcfJ1FoAigojS8XtxTRNv9pkJY+Fcse63xWUdNDx8WgjQZ/A+ykRKySd8b
	QIcKlfHBR3E42G8hM59a5PVyh3idLJlO2cIT2WpXA7q128CgSuY1c5glHRpHsHzTRPbeezFV0vU
	QCIajsZRutLxHQof3mxChA2fhxm13MhWeKUuK5PrYDWN1RPg31Oc+Sz9o2IwJNguNIaaz4ydHr6
	7q/ARVD7Ac8KpHgyd2yda3BzVUx5yLBqBcBVlb2/SlP0e
X-Received: by 2002:a05:600c:1c03:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb55a42fe4mr50493025e9.5.1794571441021;
        Fri, 13 Nov 2026 04:04:01 -0800 (PST)
X-Received: by 2002:a05:600c:1c03:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb55a42fe4mr50492575e9.5.1794571440636;
        Fri, 13 Nov 2026 04:04:00 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae4414sm60149395e9.9.2026.11.13.04.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:03:59 -0800 (PST)
Message-ID: <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
Date: Fri, 13 Nov 2026 13:03:58 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
 <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
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
In-Reply-To: <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vvlzzIlmd2WKgx_OUh9AXb9L_7lTTNuIJjWdkxzZ-Eo_1794571441
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 11.11.26 um 11:18 schrieb Amit Machhiwal:
> Hi Thomas,
> 
> On 2026/11/11 08:54 AM, Thomas Huth wrote:
>> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
>>> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
>>> test binaries:
>>>
>>>     /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>   Hi!
>>
>> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
>> 44) ... which compiler and distro are you using?
> 
> Thanks for checking!
> 
> I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more details
> are below).  Are you cross compiling on an x86 host by any chance where you are
> not seeing this problem?

Yes, I was cross-compiling, so that's likely the reason why I did not see 
the issue.

Anyway, could you please check the following patch to see whether it fixes 
the issue for you, too:

   https://lore.kernel.org/kvm/20261113120101.145183-1-thuth@redhat.com/

... that compiles the powerpc code with "-fpie" in the CFLAGS, so I think it 
should cure the issue, too, and it's likely the better way instead of 
suppressing the warnings with "-z notext".

  Thomas


