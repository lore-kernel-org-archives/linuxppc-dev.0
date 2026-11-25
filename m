Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB90606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4o1XNDl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZTzm3gR6z2xwP;
	Thu, 26 Nov 2026 06:20:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795634452;
	cv=none; b=kRsbz3IfjFxupP0n21TLRbDw+FScZcOE3lZeSI04lqsAupzhvVTQW/hj2hAgVI9NCIPJ5wBsvN/BpOVkaUv1AJ8dnTTBInW2emxFIdtd6nJRkcvr61s8NYW5JY2jSClLJGUq65BSsXNkFggVXunzhaS94gN4/tcR8uAPF5VAQhrknxTET1bz9BsBKPxT74ArOZGojUbv5zNLhrrMI76GT9E2N/KxKVMKbgka5Sn5LafybTR1NTUxVRn5xbae2IvjU7Zs2w9RwZEUdk429bEf6qqvdBGdrs8SNUQNyhSubweOy/oghTaPRCKx2nO5CVULfRuu8NyxNPbZYAXHWcySew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795634452; c=relaxed/relaxed;
	bh=gjkmUYAQqhObZomEhSZvG/YB77KWT+YtxY8LYQ+JXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFxqQ+CIj+Nl8KdXmqaAH0HcEpbaurDx7D7linSj90o+uMpbgJTnmsV1ipuhbgRHGezfSaUdAwFy7HO5/wCy32ObjLIRgipAidDzlFjqL9ytgxTfEMNpZYVldMBsa0pP2SwqLsbrml2EmWsD6Tgw5ZiVj1gt0bLUgIfBK5g4YSr21YxiAPw1MFPUC8P1NK9FH90Z4GQHsRfeHYW4ahpPScCNSi6wpNikADyjoLxXkXRWfxEg2UBvXE2m3bKkGLom23IRbJGGjRcEaHAXapJZJKvxuaukmVAZ3QU/g6wABEStR59h4jgXWmUZMWebuwwY5hvAh9QdVq4y+nHzohH2AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4o1XNDl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4o1XNDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZTzk5Q0qz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 06:20:50 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYdNb1999322;
	Wed, 25 Nov 2026 19:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gjkmUY
	AQqhObZomEhSZvG/YB77KWT+YtxY8LYQ+JXBM=; b=b4o1XNDlfljukz22wGJQ0h
	hFDvCKahLQE5+oELMoxpvR8yus1xr/9HFGs7jXKfv24NedjQNfOPAQLQsOYaYxmJ
	dUFE5fhXckqAuW0PYjKLfUY4rjnJnXiiEJ3J6heXYs/hWnlWwEUIeiE6+U2PbLg2
	8YmBlg57Xz94o6TGMiXCPGRFMqcx7uqeKTvP5PT0Ve/GxmJjLufrD15klX7U8Hzv
	zal0O8X8xVHjp69b9e+a0liO17XVYXOOvkfuUiwLL6YKgBmTbYUQ+hOU7A7uWYN1
	Af/9bgIBBKYXWxK+4RRNAGIaKYwc8nTS7EMTL98PhsZN4n/5Bz49Dm62UQ2Sqx/g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fae8qk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 19:19:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJJJGp505545;
	Wed, 25 Nov 2026 19:19:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx22n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 19:19:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APJJdNd42139928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 19:19:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD8220043;
	Wed, 25 Nov 2026 19:19:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D8420040;
	Wed, 25 Nov 2026 19:19:14 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.67.112.155])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 19:19:14 +0000 (GMT)
Date: Thu, 26 Nov 2026 00:49:10 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 05/11] powerpc/vdso: Enable the vdsocheck tool
Message-ID: <awc0rvqmahY6cHtv@shivang.upadyay>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-5-161e218dd217@linutronix.de>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123-vdso-absolute-reloc-v6-5-161e218dd217@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3NiBTYWx0ZWRfX3whPefz46WC1
 hNygsADgWWH3q76IQ97vzHqlw0KVrxx7r7UAw5SVuBqmP03DlIHvveHdnCb8I+LFUdhf3IBTEF4
 8I0LKw8A6RDat+2jMShRhIdJyHC/snbMARzB3j97ZRg4dk9eQk6Kb/c17OPxkgsEeh56QxlIgDC
 wUPWuvr9YTBgUtvA8T8GCqkSSvcvT95hsmx8Ct0PUUDgvFCs7cWvxl/cHPmpiD4Kk1M2+/XY3xk
 DLiaxWKhSrSivaxvdgJ1EA4G7gz0ulJrAaMk8ySQ2/S47CSLA2FI3plB5nV4GNPFWQXLUfRWPHl
 QcXK+Qe1+YjjykPhUcW6RI716uPTfT8UPFmL8V6qwT/f4oC1rJT58R1VQobyjiFZ9MGmwr6WlCS
 z5ZKV+GghS12zlmcdRFYX61cx8WcuTghM7JYnVHIKLaR9Q0N8q8XzXIjmtuCeYWzKrV/9/k7FwS
 CZCtvJAPPqeb1X+3DCw==
X-Proofpoint-ORIG-GUID: 9DuPW81bc1Ne1-Acmq-ZFQ1oXTeQgO4D
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0734d1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=K52B-zMjTZoA2OaJzQcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: kgd6ntmKeCF4y3vpHzpfFLVurSHBIu2a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3NiBTYWx0ZWRfXwLCiikm0vVyM
 9boHPXPDQcdJQkQPxTdXN6x3x8c/RPGIYsu6hqtP046Hh/4b5uaJA5LSJKyG0fXuE8vE282QQVw
 jau+sQ3OeVvDMeZGSzccJJHxqp+Tqsg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250076
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 02:50:56PM +0100, Thomas Weißschuh wrote:
> +        bindings::EM_PPC64 => AllowedRelocations {
> +            in_object_file: &[
> +                10,  /* R_PPC64_REL24 */
> +                11,  /* R_PPC64_REL14 */
> +                26,  /* R_PPC64_REL32 */
> +                44,  /* R_PPC64_REL64 */
> +                249, /* R_PPC64_REL16 */
> +                250, /* R_PPC64_REL16_LO */
> +                251, /* R_PPC64_REL16_HI */
> +                252, /* R_PPC64_REL16_HA */
> +            ],
Seems to excluise list of all reletive relocations.
I only could find the following being actually used, for defconfig ppc64le.
But good to have all there.

[root@system vdso]# for i in `ls *.o`; do objdump -r -SD $i  | grep -oP 'R_PPC\w*' ; done | sort |  uniq
R_PPC64_REL16_HA
R_PPC64_REL16_LO
R_PPC64_REL24
R_PPC64_REL32
R_PPC64_REL64
[root@system vdso]#

Looks good. Feel free to add,
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.

