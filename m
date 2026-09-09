Return-Path: <linuxppc-dev+bounces-26961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466DEC79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:55:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5465lgXz2yvs;
	Thu, 10 Sep 2026 01:55:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969318;
	cv=none; b=SaUwH6/ICrYcXcqKhoZXO2Nm3FD4Q1Y2mD7duv22L5/8KewNTRHWIDi8L4/3F+E31vrBux1bpueVAQ0YWfBG/IgVJbNbZkBH0UTdxKxWZ4mqGeQnPMNxpNDJyEtJoNj88utUdtp5YyaA3IKG9MdSVxn62LgK3gHzIxHtIsESHn6+tFeYXI70BgE5bqk9YpWbISDk44/ZSfY6M3diZDjfF76VYfuLJO74UU4KbGEhyZZnOFByYJlF1cLWhhD9vjaBFFiN/GDgF45gtVUesB3WyNFbNlZrcBOAehbX6aAmhv9EfmYF/Lmh0oDIDTqIJ98uOYqAmVLsg3k2FqCJpXUcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969318; c=relaxed/relaxed;
	bh=DPR7wY4sW6m51NDZV9JnodbSa+OSMudUiHulqkML5v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRI90kWMOdxZDHA+CEYLHkjudZA2uR7PMDzq01FS9Q9M+D3GwMJJ340fMdvHtAyHwFdf1BkMaOx7WiKT01bqLNXhKAvXaxoNmPBu1ZrIiumZiu7PwMJe7Tfs8cqKrOq6JwTAPzKbmb1tSgtk0WasCT2WA3uO1L5bbPndRAgMBc74brd2PSUXa6vaVKE3nGMJa/wS9DRkNGVVAEH2NX/U3n2qUsFLlnEUl2I9fiCagwTqJzAEbecls/pUqb6FTuB/TXMZ16bOyq6O3LvV9PhvnQhfR4vHJoPKC7VrNZetDZTcXlnNm/3U+4G392UZLzizmoevU06h8uz+LXcJvUwnzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pYl9cGzv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pYl9cGzv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5460Yxdz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:55:17 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1WLX3802331;
	Wed, 9 Sep 2026 15:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DPR7wY
	4sW6m51NDZV9JnodbSa+OSMudUiHulqkML5v8=; b=pYl9cGzvNN4iHBtBgFL3Sb
	m3OR68FcWeXtslsiHK2Za7xOgNFb0EbeoBTJ3YwawlNbHkmLsbQuQPkrPwkXdXIC
	A8UXZNxJq74y2SHitQHGL8sqgvHGJ3IBC/uSjFNkXnrxqVVLqEKv6GODOgXssXLf
	mE2kMt9Y2Mttzh5oFvwV5lQhFfu29HDQLOL7Ubo5s8AcVMilGbY6joFS4mcd2M+z
	qlO02hW0akN72d/XhsgY886/u7FmFAbi9oZ4ja/QrQ1ys1NiogvnD5VgpMvYPi8H
	3+xrVhQz8M/RlHqmWbrbr6fhVHwpJ2REdmaDTnWIlF6H028hDlqkWwofrKDB83hg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkxyhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:55:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689Fo0VD013230;
	Wed, 9 Sep 2026 15:55:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgk01g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:55:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FsxHQ48824728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:55:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899E120043;
	Wed,  9 Sep 2026 15:54:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806CE2004D;
	Wed,  9 Sep 2026 15:54:49 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:54:48 +0000 (GMT)
Message-ID: <233bec97-49d2-4871-b9a2-150586aead35@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:24:44 +0530
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
Subject: Re: [PATCH v2 05/22] selftests/coredump: collapse the expected
 request check into the helper
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-5-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-5-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX2ijOao04jEPl
 sOqXlZGSc53aFoP0mB2eQ9O9GqCxaSo+tkzVbkfe6/T6QQYiDsDIqzoK313a04Ppe+sQx4IuFMW
 lu6+i9JfHBr1eXClQ30BHIV7vga9okA=
X-Proofpoint-ORIG-GUID: fxOo5EfkOznYK9mh8NsAR-PEOkzbjlYO
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa18159 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sk-MaRmfesVMUlk1-wEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX5tzXgFGqHe1r
 LI+btOXdiiSSk1u1UrmKz4puFPgltxhBDssyO62uTMXU08hImAJk/GpWJ9bnR2YNTznVBee+j/t
 irK2qrKciF4u21q6bRSFPtbJ+YeRY5S4CJ8Hx41YKeJfCU+AY/vyzg44X4hRvBdJHZfQp2vu3hz
 N+PqEfZc9hbPEAi+8rFkYNo3nyNaOAXRDzGYq5G58Zd9rev9k30/XuApw4pVMKpUsvC00uro1rx
 VJVWvOsUBY2rVSF2paOgQtexVv0ZMyUYNzQeIytQHYXDHDOsuYId0b3o/Wjz+rmJLP2u1Z3t/aI
 aIPSaMWzjwHAp6qaENtE9358mseW1EKESX08+8LAlu01ZgLsuzDJpsBQByDEAZu2taCztvaVhPR
 SxEH8B5jclUBuIWH1wuMHBZ5cl43Q21oNFCKidxIJgyvgd1Qm77CtQGRn9BmPQyClNj3TRl9/HV
 OAxitreq06Z8UEfVFTA==
X-Proofpoint-GUID: miMcpF0MFS-O-087c61rypd3mGFBxbzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> All nine callers spell the expected flags. So every new feature bit the
> kernel learns has to be cargo culted.
>
> The callers also all pass COREDUMP_ACK_SIZE_VER0 as the minimum request
> size although what is being validated is coredump_req->size. And
> read_coredump_req() makes the same mixup twice more.
>
> Clean this all up.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   .../coredump/coredump_socket_protocol_test.c       | 36 ++++++----------------
>   tools/testing/selftests/coredump/coredump_test.h   |  3 +-
>   .../selftests/coredump/coredump_test_helpers.c     | 35 +++++++++++++--------
>   3 files changed, 32 insertions(+), 42 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> index d9fa6239b5a9..60a357e628eb 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> @@ -151,9 +151,7 @@ TEST_F(coredump, socket_request_kernel)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_kernel: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -301,9 +299,7 @@ TEST_F(coredump, socket_request_userspace)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_userspace: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -441,9 +437,7 @@ TEST_F(coredump, socket_request_reject)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_reject: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -581,9 +575,7 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -702,9 +694,7 @@ TEST_F(coredump, socket_request_unknown_flag)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -822,9 +812,7 @@ TEST_F(coredump, socket_request_invalid_size_small)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -944,9 +932,7 @@ TEST_F(coredump, socket_request_invalid_size_large)
>   			goto out;
>   		}
>   
> -		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -					COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -					COREDUMP_REJECT | COREDUMP_WAIT)) {
> +		if (!check_coredump_req(&req)) {
>   			fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
>   			goto out;
>   		}
> @@ -1355,9 +1341,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
>   				goto out;
>   			}
>   
> -			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -						COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -						COREDUMP_REJECT | COREDUMP_WAIT)) {
> +			if (!check_coredump_req(&req)) {
>   				fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
>   				goto out;
>   			}
> @@ -1509,9 +1493,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
>   				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_coredump_req failed\n");
>   				goto out;
>   			}
> -			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> -						COREDUMP_KERNEL | COREDUMP_USERSPACE |
> -						COREDUMP_REJECT | COREDUMP_WAIT)) {
> +			if (!check_coredump_req(&req)) {
>   				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: check_coredump_req failed\n");
>   				goto out;
>   			}
> diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
> index ed47f01fa53c..a02809145e2d 100644
> --- a/tools/testing/selftests/coredump/coredump_test.h
> +++ b/tools/testing/selftests/coredump/coredump_test.h
> @@ -51,8 +51,7 @@ bool read_marker(int fd, enum coredump_mark mark);
>   bool read_coredump_req(int fd, struct coredump_req *req);
>   bool send_coredump_ack(int fd, const struct coredump_req *req,
>   		       __u64 mask, size_t size_ack);
> -bool check_coredump_req(const struct coredump_req *req, size_t min_size,
> -			__u64 required_mask);
> +bool check_coredump_req(const struct coredump_req *req);
>   int open_coredump_tmpfile(int fd_tmpfs_detached);
>   void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
>   
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 524fa5370593..306711e1b24d 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -200,7 +200,7 @@ bool read_marker(int fd, enum coredump_mark mark)
>   bool read_coredump_req(int fd, struct coredump_req *req)
>   {
>   	ssize_t ret;
> -	size_t field_size, user_size, ack_size, kernel_size, remaining_size;
> +	size_t field_size, user_size, known_size, kernel_size, remaining_size;
>   
>   	memset(req, 0, sizeof(*req));
>   	field_size = sizeof(req->size);
> @@ -214,9 +214,9 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>   	}
>   	kernel_size = req->size;
>   
> -	if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
> +	if (kernel_size < COREDUMP_REQ_SIZE_VER0) {
>   		fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
> -			kernel_size, COREDUMP_ACK_SIZE_VER0);
> +			kernel_size, COREDUMP_REQ_SIZE_VER0);
>   		return false;
>   	}
>   	if (kernel_size >= PAGE_SIZE) {
> @@ -225,11 +225,11 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>   		return false;
>   	}
>   
> -	/* Use the minimum of user and kernel size to read the full request. */
> +	/* Consume as much of the request as we know about. */
>   	user_size = sizeof(struct coredump_req);
> -	ack_size = user_size < kernel_size ? user_size : kernel_size;
> -	ret = recv(fd, req, ack_size, MSG_WAITALL);
> -	if (ret != ack_size)
> +	known_size = user_size < kernel_size ? user_size : kernel_size;
> +	ret = recv(fd, req, known_size, MSG_WAITALL);
> +	if (ret != known_size)
>   		return false;
>   
>   	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
> @@ -287,15 +287,24 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
>   	return true;
>   }
>   
> -bool check_coredump_req(const struct coredump_req *req, size_t min_size,
> -			__u64 required_mask)
> +/* Every option the kernel is expected to advertise in coredump_req->mask. */
> +#define TEST_REQ_MASK_ALL					\
> +	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
> +	 COREDUMP_REJECT | COREDUMP_WAIT)
> +
> +bool check_coredump_req(const struct coredump_req *req)
>   {
> -	if (req->size < min_size)
> -		return false;
> -	if ((req->mask & required_mask) != required_mask)
> +	if (req->size < COREDUMP_REQ_SIZE_VER0) {
> +		fprintf(stderr, "%s: size %u below minimum %d\n",
> +			__func__, req->size, COREDUMP_REQ_SIZE_VER0);
>   		return false;
> -	if (req->mask & ~required_mask)
> +	}
> +	if (req->mask != TEST_REQ_MASK_ALL) {
> +		fprintf(stderr, "%s: mask 0x%llx, expected 0x%llx\n",
> +			__func__, (unsigned long long)req->mask,
> +			(unsigned long long)TEST_REQ_MASK_ALL);
>   		return false;
> +	}
>   	return true;
>   }
>   
>
-- 
Thanks and Regards
R.Nageswara Sastry


