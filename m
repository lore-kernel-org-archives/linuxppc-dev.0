Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8487606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDltCQlm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNPHt6Qlsz2xKx;
	Mon, 09 Nov 2026 20:14:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794215690;
	cv=none; b=emutCzoCWhZJSNG9FgZOkY3ybHx1yeFKGF+3agFUFr9+k/iOX82aHWA+a9B2rHVUh8leS6Bc6OTyk6NI02wQg6cYviUk5v6R9SAmHGVwbVWq1XYXbk9+TezWaQTdUmvUN70P7hACCJyZs46CbySiWGdyTog8BrV2MOXgQrR7r2IS+0rtkqQkOrklYlTEvqEH0G7P5k8b8iiX70+ImofyqwDOh3vOv5XLzr2Z4F0d6HBEB/X9EbosKS85W4CD0IqCmUGNKzaEsXMtPeK7aJAdmsVps+6XAyLR3wmrdAuNXQg3bWeWbltgCUYfOwXuEHra0j2JM3cnn5RSIkXUW2J+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794215690; c=relaxed/relaxed;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZSMHwwUvGR/BmzCRkz2EcvJimhjCTJmktKmjFMk3GbJsagInd+d8R3Zm25Tov0jeBJ0HWtMzwjUfllAkgDl4JXYGsLFYCAHTO2ZOph5V2CTRUdox0LkTt6UbDl0Qt8jRBilhO0x/Va9MpbRhYtXArebmqrbyVfVnng2QaWsMXQ3Os+2IOQz4cetaT+pC7WohUKvVfZEbJGIMF6DF/6tibgmjlHOSaCxFQ3Z1i/6N3cI8twwFAxBwEMZcq1giWZk7cmT5qCMTVKqcHm+f0sbr81jmX4625M8VeLt5VeTT72y9RkgDJCbHoNVYQnrCrXkHWzNrvy0XAP0PZsPD82Swg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDltCQlm; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDltCQlm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNPHr3j5nz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:14:47 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A969qrH401313
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2026 09:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf5x4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso134964285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215684; x=1794820484; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=fDltCQlmb2YixRo8g2I/OT/2aJ/5PFPoN5V8hrtOgU5l/kjP1wojF9YNkRlzXTtqW5
         Zf/N+CaTy5vuFaMooLx/iD0UyMo/cFKF93WCw7xhRcbfHRUkoGya+CRaaFmn18+TLF6e
         2eQbssXoAX1bYEy1LDb786a2SZsQ2qezFjB7Y4J1h9PHyrRzAVHzilj1LjHNbbJuIOgu
         +XPqhsSGbkbxjImgXW2g/6NYQSS4/NeNuV3DXPN7H0YEPmFN9VzpGKhvsWqR53La29H+
         sepA7N0p5SeAtTukQAuuB6ZP1+q1RnBkaqk0AscSfhz1J+5vnPpWZ23WLBWsUD4WIHUz
         1pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215684; x=1794820484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=ieNBzyrZ848IW8eJaVp3KOuf9XDGjIbqKc5st0ad6V6mpi16WfQLYM8kmtv7JuKgPD
         LlVaXisOx2cDhLk4Ik8ytKYl+jeGwDnJcK9bo1BJciu51zcCgdkBtXQkY0YjSSZm9JGo
         LiMX7MqV9pIiS+1coXahSQVHs95Xvjgq76JxMpKJtUUazTeb7S12PBjsa1sq6QPHf9dT
         8R/GVrbqTuXqgqwKk9ZY7Iy03RwiXwBoHv5yjiUcOE7XGp8KTT14vj7eswv1hamkcvKn
         2RbEkfDuGMv16mumWJX61UmqR/Rzu+tFQZKw8LTbxhIvheSq0wDkjYftkX+EfwBL6h/W
         t8pw==
X-Forwarded-Encrypted: i=1; AL+hErFIlLfRUvKWky9ODkPZjFUdUkOzcaHXJUJDxkonNw24EWXLjzVhs9VAtmk7FDS9W+eOU0/61E3SSMskb3E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Ooypj3WGs6GPqd7P3RVsv82EFerC1Bi14D/vMBIySS4aV0qiI
	UQZHKO8CSS9teCSP8IJ/f7El5g3fzpefjLLbe6Osa77rhsb5+4PwpXSVcvv/EBrK6pjI8lHhWTs
	G1z67NKFzpQi9DBNTlbPq2TxBtj8ene5aWB+Fzcwr8scw+m3JCoREICMcUaXH6oMmBgjI
X-Gm-Gg: AYBFou3i4JDBLc/1PGHwb9JyKPrJKB+W+nO/UT3aR2VoJpF6fJR2pp5V/bD5zk4aJ77
	VIZAyri3a5PrkkN9TbrWXTCP9A6BesoN1p1Kj0pMfR5gdAFuJdz4Ok+EJLTPWEYLvUKsiJvzcpC
	WxlYN7fzUq+mhItQDjh67KxXvXJrbTFuNZha8ZNQ4LoD4l+BvEtXlV3JBx89Dxh/7VT7z/38eWz
	fQ/pnFdk4l20vWOPbvpG1lwV9DdDRRnxuLp+rZYlz9W9FQazo1/dqSHWjBjCPW2IR/0dqUnDAhq
	0IDcqGG+wFJEcbP/7tnENFarYIN/rqSsGymqXazC/6SAQh71DH88KAq7JkYcx8XvKPH2jbcE76K
	z5dOM/ZPHva7LDScasjwMhoOi39lOuoo7IdqH43cXGIlGgCYFhBIMMFJUV/Jkr3w=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886329485a.13.1794215683569;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX+XZRZJyQblIy
 RfJubI+nr0zgS6T/0zoUDSdYYQGbMISwuqdvh0X0oLY+ZNQLLBhOB45ls0aQGOZdPJ5SUU/q9/P
 IQeHYbZzrPzjF1DWLiup96Fo/Yn1YyY=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dybuhCeitabgM_vvJduB0-tmU2T6zkoq
X-Proofpoint-ORIG-GUID: dybuhCeitabgM_vvJduB0-tmU2T6zkoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX9w0dKMWUtR+2
 +HCwlIAfh1oc48fskIOIDZdAZOrJ9IVfTE9958j9VDpIqpx+EwEOpZ5xirmpbBMZrcE+0kq7Bbg
 beFTkpk4dB+Uqb0xtvTaCmnv+YzUH1VA+SZCKEIKo4RZaFujy80OksQJ0LL8dnqZ54O0akDk+eh
 sRKVEOhJKku9vCKVO06j9CePALKu0S9Mg3LuoXN2/2KKckg2pTP6Pr//Si6hLKgrgN2N5APknAT
 CkshQDOOw4dTqOuZHkqbgQf2BSmjbAFfj8alBqNiU53qCK9BTDI54w5brXDY7YViKePLPQg2VgT
 MjdfXZuHeP3k2K/GhRICYJKTz2ZhPVNJkW9C4OaIebjgwd+HjiKWAVMPLpFyj7VfZ4EIa6NoAFd
 nzO5mgTcQaUVZTyCDr3Q1iJsHjL7USo7gyafKGg6PYrFS0/DlGY0O7vcG6RYxFwVB7I6DwGR/89
 XEO9Y/iR0haL50HCXWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090036
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

