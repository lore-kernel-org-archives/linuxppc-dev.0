Return-Path: <linuxppc-dev+bounces-20785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF3CCD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 12:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFFdv45N0z2xjQ;
	Tue, 12 May 2026 22:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778577116;
	cv=none; b=kC4Ln1SuEIsTYVDMA0yXLObVyNnMXVBjLFW7nX8pAo66UyACu7nUd18KWhcXLlRVyA99N3GHkAy2fhfaYLcv0bN1XJsHAB1tfy3gPeh06jICIzRq//E/KlveRsEGqoQQcF97o3lNmkvjYaGTww/NURtsLAn7gjWqLLyyNvtxoZ+wkjS5ARqpB0anCfou8NjYDu/w8KmUYsx7MZWGbw3d6QBXMYvMt7i3ifhdu2++KLy30Yk4p2+P0AsjxcNaq69nhtAuMW92HIOdCyV1FDZeZA362IpWdHjWRCY39Z8kit4qcmrgMqflpi0oqBzul9odnY2nGch7jRdToZOIF8jRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778577116; c=relaxed/relaxed;
	bh=ewLHYzVyPIcnfA0lWvcYFQpDp7JkXVt+pOOD3Figg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVI3DxBtgmem/uuCDIPyb6gXmVPeidrZV5CYNcZPNq4IHWUk2Ekn66YManJjqGunqPLJqY3PARCK2nC2dPO3lmcHQUKBJG3CZdLzvd8E9idsooTJSwerXNWObikdjRbcm4kG0+4hEjLO19oyTf2iIOaqzBjQ6ND2WPpiVfGNiuYOqiq9Gsc+OOPZjiNVzbP5vPuBAw+s89zs0i4KRwlIBkZvauDJ88RCrKqP/Vn8gMVnkr7nQajywLcMoIAyxTJSWvlVZLJ4V7sRVWfXJG6Ku3FICtZfhkiFgE6muGYChTihJMpS9Vw4BSRGZiBxkvIpziDJ966LnkB2W8nI5S57mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PRB+G7+a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sumanthk@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PRB+G7+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sumanthk@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9p350JZz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:11:54 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7FWo3775794;
	Tue, 12 May 2026 09:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ewLHYzVyPIcnfA0lWvcYFQpDp7JkXV
	t+pOOD3Figg4E=; b=PRB+G7+arGYomjB3z3x33qbhpQNSiKXpaIlzhEdy+CL8hX
	uPGJyzns1MSvMNOF0kpe3uKexcsu7ag6GSr6JW9jYoG8EB1DvDIAzjpkThbNPy+1
	8oX5/4eF0ZghhSJOEmOmgKLx8NHEJpWUUXF5sZ/ADscKE/Dpi2zv2aM+Io41BHaE
	SJM/TUsa/UI8sgv/Wj2ZPujkgC2s5nFBfzacRxKhl56SLu1OwBd//Ly/EedVknXw
	kkLUtBSQOTYgVaWzo8RX8Sox0UFpClpdX/a+2pLzXqP1EutEQe/JjXLV3bmobBDB
	ec6Sff9h4NJC+NtyFlXoPPiiq0mH/s0rjJEnVZgQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6j5rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 09:11:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C99PJC008832;
	Tue, 12 May 2026 09:11:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgtfd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 09:11:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C9B29h60752286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 09:11:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71732004D;
	Tue, 12 May 2026 09:11:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A1120040;
	Tue, 12 May 2026 09:11:01 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.138.92])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 May 2026 09:11:01 +0000 (GMT)
Date: Tue, 12 May 2026 11:10:59 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
        driver-core@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R . Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Danilo Krummrich <dakr@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Donet Tom <donettom@linux.ibm.com>, muchun.song@linux.dev
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
Message-ID: <agLuo_m5zQqbxTbD@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260512072635.3969576-1-songmuchun@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a02eeac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=968KyxNXAAAA:8 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8 a=YAm8QR2gnoILv_Wa2p8A:9
 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA5MiBTYWx0ZWRfX1uUy5DU8yQym
 J4XkJjIEkPTbZdE9YFwMIa2Kt4hhshMO4XebX9z9M6CeML9oIWNXXDqNMmzk0Xautn6MgAKwJfS
 nEj6ZJ/qaViKvn6wlOUVt4hY0oxz73evURw16Dlpvr7vfWPSrnsNgiiwI+sgY7UZe96RJesya5W
 avsU5cTH7loipW1URaKMpdLGbmoLbF9WSnwZOE29jf5535XRFtOPbBBlQosxmcTDFBEtbrB7WNg
 B3kINotmKXT+IkL3Lgsl6upXkAOTtKXzBwobeJm0PoIS6bH9u3e7G+BCXhdLrZ+8ouQ1+8ULlU4
 5syABJUTpbEGkCn+ToG5qh+3KXWfkhhKuXyLq6BwcD2Aihp6JvC5Qo7nAPFv1kZA/DfaPbAMr2w
 f0LWQJzAOFCdbfuwXuU1rwbRhGVlXJ/zuP/qVvCXh1P05wXyua6W9bCstNhjl8kXGlgb4fEFxv0
 GKAJimPwyx/3VIP5HaQ==
X-Proofpoint-GUID: BwsJ5X2pLXcwXHTrX6Rw9tGfynxABbWb
X-Proofpoint-ORIG-GUID: q7xDGR8Cmfhkkj9U_wVZEmghYWVpiYxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120092

On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), remove
> find_memory_block(), and use memory_block_get() as the single block-id
> based lookup interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com> #s390

