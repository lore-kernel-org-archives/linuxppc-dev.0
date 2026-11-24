Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB0606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=buyHQ1tj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYfzb5HQvz2xlw;
	Tue, 24 Nov 2026 22:02:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.168.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795505882;
	cv=pass; b=L3q74eOdfpTMW05MeDMr8Y/XuOmtaZvSpnoo/l9niIL3TEHNXpxFCB5w9cyW69uf+rU8jIRar51Xox+D2Cn9QwzQziyZb+tKEhmlMg+lafxPDiRKsqs+i2BiJaiUA31tqcF59GFhvaQbXpLF8ddBVnaiIdXb36Swyz8c3/Ckq97M9hLqCuzynkkUCbT0cc1i9FaVnc7O5AkMb7PXJfafbS5QO8ue+yWHxxKTxQoh4mfgm3Mp9akLwh3HBmwJRKZm2w527xAOkRFUwNLxP9q3OVl3eZ2JeeTuwp4wDWvTkBFLA4ix5ad8LCQ+zX2FTQtXZJPxeVCrjor7vhymkP4p3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795505882; c=relaxed/relaxed;
	bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5IHzzjOmq+p9/0RKARzckPsuY558gFyDQBqxbwl6eRhFd+kvs9UYhiXIXockaKmRpjqhs0tqyN8yx81rJfy7BQYKZnblj1WJ0gLUZwetwfh+FQbRCv/mpXV5IX3x+ep4BV+YjUt/CDjpeN/iYgjoDj2CdxAlKFAi1HZXfAruSdhbzuEYtlv6WBX5UdGaL1BGALmDQJvJFXlw5ltTvljimdFZPr2iu9yUKqT5XCl2EXjVFh4IdhDCpg0E9wn9cBFGyNpG8SW8ycCOWaHO9LPtBBZwZfJL9A/7rbxsitW/CUtqraSHh2m9/dzxa7tqUiS/3vGwp9bmMfx5Ws5ZMCkdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=buyHQ1tj; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=jens.wiklander@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=buyHQ1tj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=jens.wiklander@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYZRD3BGrz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 18:37:59 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k6mM901973
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=; b=jB2OhFnb5kcQJfBh
	9PooZCIYHGNUVjDcGwumXONQT2rphRiM+HKb+Z5rBcfoZ9URBb6HmUCKyU398p1z
	0DE3n1unAJCPGSKA9qHqDKxoWrwnFiNfWRaB4F0mZuQ+gIyw7qVkk0rFFWIT+hr0
	xlGvD+nbKD4m1GM6eRm0zn5N+zABS6NWAAQ4zM+xLUUTfkXPLcKrmGNQSuaj6NVk
	LSMFCUkYtOrVzKgsE9JjRJp/p/+NgBxqv/l5UGfpSyCfsEnsySH6HhHWtAFvnFTH
	QiJHfUK8nig+0y+RvbrdRu8nHxWlPz45JWmVSfVxj87VvZ9rM/3qatNGi8g/YvkN
	LVZ85g==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6st1a4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 07:37:55 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b50256700cso64738007b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 23:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505875; cv=none;
        d=google.com; s=arc-20260327;
        b=TPmKWOsUUCTPtQRvBRW9vZl+th8uGNWfa8p0VJIpgvQT/8GxFGblZWxtXkZ2LSXFs2
         nVviuh07D5+xlsgXAblMFsjj2o5hMllXvJqP/NYlYDvI/07tEelfpVvYjZdy9UmifPKM
         B2dZMvi9YkDj/zQ+lcaWMIMmYwt+aU2T11kTsskoqp24vobYey1oIPA6wvpyQXOeOSWX
         dR7rG7r3xTVfolKYBCro2IGMcnmM8MT5YIbp4R43WXvy0rro4Ch16FbyxlhsMmtxokFE
         mRQBJlwhM9XikTo9N9Fezc/RHY3unclBrRYvVPvcQq2Y1FksR+XJ73F8PSkm7tME/oLL
         fwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        fh=OQ5jRewd1oxkUOxHG+9h8hwKHG+Nsf/HOhIuriRc+lo=;
        b=hR9bgTIKQh2Jnf+2amZ8cxAvd/HxEvxZYpwxquV02kgSQt2t5CEs1qPm1ggyC7BlCr
         Qwgqc6IM5HqrD8PEOM1I9fyrMer6CLNdwJ7rYH5VoW4jizjwl+wgrV0vHEENK2GQ1yP9
         mjFJngqDmxbV4rbSE/66R6JXFRaUmyu+mbixzUGhkYIe69mkN3nKB3viFGhcpRjvo1OT
         75X8HuKCjzWOMFi0X3an3AMp5V79vlvx1rhyN4iOfLsU/c5qCFHN/uL6pPMrFzG2+Vcr
         micXuiyOboVOf2n0m7gD+iaqcqbODxFiJES7pWGMUyBay3S5S5DvhpJZ82CINXcOndeg
         mqjg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795505875; x=1796110675; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=buyHQ1tjKg56x2TeWYiS2NMpODyLl3+d7S0MLkApi3Zq54rcs5UqYc5pCcrICHMA7Q
         7mC8ZoCHBIWIcYtC/WeJGvy7G6ZB/A/Dv+RPcpYweOwdoSXdbtYKTARd4udNi/p7PJdF
         WTLBVDhJhetF/KOw+jXiWUkJD9eoGzozSfD50BWeW1PaORJttm4bTGLnkQ6GBC14+6RK
         Puh1JsZRjy0Ivz965D/EwfO4+JvPGBAEuaDgda2DIRe4y8v/y28JdvV25Tv62CfD1mwQ
         wwxMuLsMky9o0cWAUGc9nyfLt8haJGmSKRmINiS3aiv8C8GPC1+WqPbetqc0t6Zw8Mx0
         iI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505875; x=1796110675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=iNTsPD08c6WOVR74aSxmNfEH05vTROwch/ZkRFz4eG1xpP+AMtdp6gS8MAGv/8V1UI
         NmPkK/m3FkaK4gJBBE25AooAbtWYAeDOHkLTOkY3QwtlUZwmVvgZilKChxcaaiJzq/Nm
         2U8ONno9YS6d6W43l3UnzvUxak1bmPMXdFf+3iDgnWUw4JdQnzqE9WVRbip6ujAPcLam
         psgivPFR4IdPUt2HECN/9/yRr1wEI4KEkIzdan8pqk6ykZMMgOlTWkYdABDe5oudUYMj
         Cob9I77EhzbAD13UC80KCgVexQdHTyDyHNt2DDYxEY+M/00ufkstCyqTe4OBvbBbsiDu
         eBVg==
X-Forwarded-Encrypted: i=1; AL+hErGjcATIFjWf8ESb/v34TDurlrc1fcEkmgIa2UxPMfjc0puOftlfTqz1GcHK5k1tTbPnafiXZwDFpXV1KIY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ulvYmLLlskhBKy2vFPLz/ZOcfq/i6cNTOyHZy7YzT3wyvu0I1
	xts2AR+yVlVzDNa0yjbrnCXLQJA8tEowpLYlJacdCqz/F4kLYNa85JbBZebwSKmby6dYJZ6Hx70
	nU5K7QE2vfwqOoCKuEFbnTN2mqNjz1eVJoFb/jV3b78Lw1/0qjndK0H25Q+Z7O0UmWIsJWXPgSA
	CwxtxGFpnFd+79UincV32YZ1yLcSMmLi/V+SMwfEehqLk=
X-Gm-Gg: AZFdTZfssUkSqxwRgSU9zbhxRLnb+iw/+wXXKHg4fVvXK5AWPgKG8tD2VcxUWYpjd58
	8g7MdMHUXjW6h22LXUetHn5jnPGo4s/pflKEoIeKOd1cJXimz9jEbA9vgxR5cW8BALCG6pDNw75
	KwnXLORf0F/hyW51LwvytFuA+vz4htyWERkA4SGH9dMtEWUGue24s8aAYNHmbpsNTJFAlU8AiBi
	UfdvRQRHYKdIWBqBLl81rGh+29BeRSpHh2sxO2I
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id 956f58d0204a3-67df447c2b9mr2926904d50.75.1795505874992;
        Mon, 23 Nov 2026 23:37:54 -0800 (PST)
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67df447c2b9mr2926857d50.75.1795505874551; Mon, 23 Nov 2026
 23:37:54 -0800 (PST)
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
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:37:43 +0100
X-Gm-Features: Aa3M54q5vxZ2pH5GHxV6_gcu1Tnc83EBXhtYw1pJ9H77Fl7U3CQoqAKpEumRrbk
Message-ID: <CAGgiveX=Z5gS7iJWBanyysVUStDRbgTnVktQwJySXw_-xL+sUA@mail.gmail.com>
Subject: Re: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
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
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mBmun29fpxnrEy5ioW8EUfbl4D6p62Vv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX0cvB+NttGP6H
 q0ckCASdUqNMKcT4KCTn+xEWTl62WJr0aM0zeV+AcAeC14lyg7mgAjPOU7ZWNvklsJLn6EOCTqa
 /hyP4fBWztSfMjY/bhIZcZvr/BCZBIc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX2JpqHo+SK2ry
 YjEo2pJUIdnUmGqrzLmOUt/RQHaKtlB8cheKaipyI9mEqoct+N3jkfVEmq6FAvYJ/4L2KRmmV5H
 87xnvD7diXpnRaC57/BPZRY5KFCp/SJi91JGTpkoVpnPVFr0sA5cTfZ+HXKnRyB9y0obDXfcAwy
 jUh7anqqbhAEmSu/TTnx2LxKgZVU0V8nmlsSdWENBS5xQmhXJwSqMrGZEek6PQL5vO30XZf3EI8
 iRm0ASfz27cEnU6DtjgloduCP5lw2nZgS284ivrU7uTkpb76ebqGLqNoW8K8RjrPbL83H1CrsMY
 0vRWPwdvGB5lSw5YkCkTLA4Pr5zVVdg0c9UHVW1mrGhSttWOFaOvHI9p73VlGFWyUY4MU2i6o4Z
 z7n943K0tIlhAG8ClxiXSf9UM897EucNVg7nPtSdkalPTiO6J3zvRNsirgHpDeIaioghO0UL1eX
 UwGR+sSj3P3EIXu98tA==
X-Proofpoint-ORIG-GUID: mBmun29fpxnrEy5ioW8EUfbl4D6p62Vv
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b053ed4 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=97S62Xg_vF6B0O42EdoA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240030
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 10:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> PFN remap mmap action to map the shared memory.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  drivers/tee/tee_shm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1e089e..8fcbf0232aeb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, =
struct file *filp)
>         return 0;
>  }
>
> -static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> +static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       struct tee_shm *shm =3D filp->private_data;
> -       size_t size =3D vma->vm_end - vma->vm_start;
> +       struct tee_shm *shm =3D desc->file->private_data;
>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> @@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
>                 return -EINVAL;
>
>         /* check for overflowing the buffer's size */
> -       if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> +       if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> -       return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHI=
FT,
> -                              size, vma->vm_page_prot);
> +       mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
> +
> +       return 0;
>  }
>
>  static const struct file_operations tee_shm_fops =3D {
>         .owner =3D THIS_MODULE,
>         .release =3D tee_shm_fop_release,
> -       .mmap =3D tee_shm_fop_mmap,
> +       .mmap_prepare =3D tee_shm_fop_mmap_prepare,
>  };
>
>  /**
>
> --
> 2.56.0
>

