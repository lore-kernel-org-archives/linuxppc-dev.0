Return-Path: <linuxppc-dev+bounces-26978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84334C79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5Jm0Yhvz305v;
	Thu, 10 Sep 2026 02:06:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969976;
	cv=none; b=Q92ASgFp/mYiEqCewhUPOCr38YSTqzCF3ETYzSfxnuVxNasOfjHXTClx2hdTZo8QnhZBK3m54itt6j5/QI1CNh3UzSQImQ4gJIZAZjMQFtxQifqhTzuZ6imSMAaQj1AB37rfh/AdIOawkVR2yM1mNKQxAP5xTrMebuX+5nRPc+pTEAcjWfCmgob5bfovlp7jhdKPHqw5yes/aWWmtwTUePFuGb/ZGaUvd79LGMt88h+AthV8cjI/JrCrP06Zoyjl6yIKIKE/2jiPZm5RzMxlzMuruXSCqOw6wWJF3MeGTBkQHFBnoJPjUtyETLNrS/71iDdsBjDTTFqkVHKjD8BHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969976; c=relaxed/relaxed;
	bh=ZUf9IUVLEWqZ/RczI9mPizbv7RvSYMB90oDfAmbgUJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5yoWF173puztMNft3Up+ljhy0ENbhcM8veRRNMIv0g8WqRszRjSvKJP9sRYA5W5IXnNBpFpuDXIZJK3lqFaWGct7wgIQ4xA8fNCRDaKdwTRPpVXCUS7CVqFmttSaaFrUKhvSGU/kESnDA9PgPm00ao9nH04BrsMBlTeKYISTCIu88SYQh0QogODWTCMCBTeEhQfnc7ERh3W6CkgtkdS8NSXGb+aFXOkGp22Lv19+wQLNOi9HLnP5ypK5yb15heTtWRwyNMQqcpCHobshQBvIWHV30oUt7qGVxF4w6Dh+n2ZN8Mzsk3YBO8n4iYxoKBYtlASsSLOoPRFWkrz/wuaLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ko+yxq7N; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ko+yxq7N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5Jk59vgz3054
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:06:14 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1PEJ3801833;
	Wed, 9 Sep 2026 16:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZUf9IU
	VLEWqZ/RczI9mPizbv7RvSYMB90oDfAmbgUJU=; b=Ko+yxq7Ny2VAnV6bqx0ICc
	J3CJhQNk1zVeRz8S2FBqFzHB1TYMfGlEhvWJ+BBAHUbnly2gHkw9oCB2x4n73y4+
	phU1sEuOBwIbwMLX9jGUewLXBKJoekyLxeL1z9hkBNfuj74mchNraEs8gZMNFL56
	pxJN2tRD+xQqRJiDj/vas3vNuEHTAFVYhsebrRgl/Deg05AzvqMhB+cfGCqVxdbk
	fb1jwXyXjXknerW6LcBTvqNwnka3WEr1IWjY9BkbogWw1n+hTeWiDN7Tkyn49o1k
	XNYS6iUdJ60GpALLYswaal61jSmxqrh4hScYPbyrux/dgGtgn9ZX9RU5XgQPSMWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhky1aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:06:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuIuD016960;
	Wed, 9 Sep 2026 16:06:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqkb7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:05:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G5uq744171700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:05:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B403A2004E;
	Wed,  9 Sep 2026 16:05:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 045CE2004B;
	Wed,  9 Sep 2026 16:05:47 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:05:46 +0000 (GMT)
Message-ID: <951e04d1-1f0e-44bf-9927-71a43dce0a66@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:35:43 +0530
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
Subject: Re: [PATCH v2 19/22] selftests/coredump: hand the record stream to a
 sink
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
 <20260820-work-coredump-sparse-v2-19-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-19-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX/nTUjuG+ZIoG
 TzVqoN/OiDsxQ8DgrkwSwERa4BDUOqqalCE8FiVP94KnJ8kSaK+6aPS3IE81Y4gjHGvAsB90+Gt
 Xp8pgmTkLEQc80deK0yPnwGQx4ZbqVM=
X-Proofpoint-ORIG-GUID: NOkEk_pYqkM7PbxBoTGzdYKiEHVCWHb8
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa183ea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=B3ZA3r2n0Fxly1dS26oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfXyoOrPrb9R/d3
 2Jn3NBmeY+M8qXMNSxuqfqXtHDJZd3IPDZ8QWF3mDWzmlNHrkpeSjJxh+R1dKtFv50kQoQ92m0G
 3pbEqH7I8APD4dpKCqf/rTU92Qlr5wXynTQiAtE9iIDGCPcCsWvFaRRhaknd05y19NyN5lxCg6j
 j+qSdaV09GjDyju4c0UWCnSDjhJVM56+ZBbFdNCLai6o94iTo7PW2EPFLU0PSBrucUdcW6/L9/E
 iUaYcTigWcearHzSs1m1C1uRonw6zsiy8qeES08Wf0Wwv+SYgx2RYADvsSspq/v1rpSBZeVRrQg
 1P0vQguEt0RgJ1ygC9IScGM6aMZIxXMDgAu/Tu+PRQhrx3OU+h7Jz7/zQdtZ6apFTjl6y65pG+k
 sSHpbNI2lnkTa5XxjZB16G73SDZMviZY9fi9w4bopkjU9+VSyHlaRDEoMKiNQMms8CTvWZTw5db
 TUuTkZLYdScersFtNKw==
X-Proofpoint-GUID: _QmDvftTM8hs8guomGZZhJKwEkm3lgUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090178


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> Currently recv_coredump_records() parses the record stream and dumps it
> into a file. A coredump server may want to process the data it gets. So
> split the parsing from the processing.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   .../selftests/coredump/coredump_test_helpers.c     | 91 +++++++++++++++++-----
>   1 file changed, 72 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 5b2ffe17f7b7..45d76fa0f469 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -71,9 +71,19 @@ void crashing_child_sparse(size_t size)
>   	*(volatile int *)NULL = 0;
>   }
>   
> -/* Read @len bytes off the socket, writing them at @offset if @fd_out >= 0. */
> -static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
> -				 off_t offset)
> +/* Sink a reassembled record stream is handed to, record by record. */
> +struct coredump_record_sink {
> +	/* @len bytes of coredump data that belong at @offset. */
> +	int (*data)(void *ctx, const void *buf, size_t len, __u64 offset);
> +	/* @len zero bytes that belong at @offset. */
> +	int (*zero)(void *ctx, __u64 offset, __u64 len);
> +	void *ctx;
> +};
> +
> +/* Read @len bytes off the socket and hand them to @sink, if there is one. */
> +static ssize_t recv_record_bytes(int fd_coredump, __u64 len,
> +				 const struct coredump_record_sink *sink,
> +				 __u64 offset)
>   {
>   	ssize_t received = 0;
>   
> @@ -89,11 +99,8 @@ static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
>   			return -1;
>   		}
>   
> -		if (fd_out >= 0 &&
> -		    pwrite(fd_out, buffer, ret, offset + received) != ret) {
> -			fprintf(stderr, "%s: pwrite failed: %m\n", __func__);
> +		if (sink && sink->data(sink->ctx, buffer, ret, offset + received))
>   			return -1;
> -		}
>   
>   		received += ret;
>   		len -= ret;
> @@ -102,14 +109,34 @@ static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
>   	return received;
>   }
>   
> +/* Put the data where the records say it goes and leave the holes alone. */
> +static int file_sink_data(void *ctx, const void *buf, size_t len, __u64 offset)
> +{
> +	int fd = *(int *)ctx;
> +
> +	if (pwrite(fd, buf, len, offset) != (ssize_t)len) {
> +		fprintf(stderr, "%s: pwrite failed: %m\n", __func__);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int file_sink_zero(void *ctx, __u64 offset, __u64 len)
> +{
> +	/* Nothing has to be written for a hole. */
> +	return 0;
> +}
> +
>   /*
> - * Reassemble a record stream. If @fd_peer_pidfd is valid the task behind
> - * it is killed once a data record has arrived, so the kernel has to cut
> - * the coredump short with the stream already under way.
> + * Read a coredump strea and funnel it into @sink. Allow to pass in a
> + * @fd_peer_pidfd to simulate coredump truncation by killing it after having
> + * received a coredump record.
>    */
> -ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
> -			      off_t *coredump_size, bool *truncated,
> -			      int fd_peer_pidfd)
> +static ssize_t __recv_coredump_records(int fd_coredump,
> +				       const struct coredump_record_sink *sink,
> +				       off_t *coredump_size, bool *truncated,
> +				       int fd_peer_pidfd)
>   {
>   	ssize_t received = 0;
>   	off_t size = 0;
> @@ -169,7 +196,8 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
>   		}
>   
>   		/* Discard any part of the header we have no use for. */
> -		ret = recv_record_bytes(fd_coredump, record.size - known_size, -1, 0);
> +		ret = recv_record_bytes(fd_coredump, record.size - known_size,
> +					NULL, 0);
>   		if (ret < 0)
>   			return -1;
>   		received += ret;
> @@ -185,10 +213,12 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
>   		switch (record.type) {
>   		case COREDUMP_RECORD_ZERO:
>   			/* A hole. It comes with no data and needs none. */
> +			if (sink->zero(sink->ctx, record.offset, record.len))
> +				return -1;
>   			break;
>   		case COREDUMP_RECORD_DATA:
> -			ret = recv_record_bytes(fd_coredump, record.len,
> -						fd_core_file, size);
> +			ret = recv_record_bytes(fd_coredump, record.len, sink,
> +						record.offset);
>   			if (ret < 0)
>   				return -1;
>   			received += ret;
> @@ -230,6 +260,32 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
>   	if (truncated)
>   		*truncated = is_truncated;
>   
> +	*coredump_size = size;
> +
> +	fprintf(stderr, "Received %zd bytes for a %s coredump of %llu bytes\n",
> +		received, is_truncated ? "truncated" : "complete",
> +		(unsigned long long)size);
> +	return received;
> +}
> +
> +/* Reassemble a record stream into the coredump it describes. */
> +ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
> +			      off_t *coredump_size, bool *truncated,
> +			      int fd_peer_pidfd)
> +{
> +	struct coredump_record_sink sink = {
> +		.data	= file_sink_data,
> +		.zero	= file_sink_zero,
> +		.ctx	= &fd_core_file,
> +	};
> +	ssize_t received;
> +	off_t size = 0;
> +
> +	received = __recv_coredump_records(fd_coredump, &sink, &size, truncated,
> +					   fd_peer_pidfd);
> +	if (received < 0)
> +		return -1;
> +
>   	/*
>   	 * Nothing is written for a hole, so grow the file to the size the
>   	 * records describe in case the coredump ended in one.
> @@ -243,9 +299,6 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
>   	if (coredump_size)
>   		*coredump_size = size;
>   
> -	fprintf(stderr, "Received %zd bytes for a %s coredump of %llu bytes\n",
> -		received, is_truncated ? "truncated" : "complete",
> -		(unsigned long long)size);
>   	return received;
>   }
>   
>
-- 
Thanks and Regards
R.Nageswara Sastry


