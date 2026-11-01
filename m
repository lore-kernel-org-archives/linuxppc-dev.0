Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A48606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KEbBjcyD;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PNDAkENG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHXpM67dTz2y7r;
	Sun, 01 Nov 2026 22:35:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.51 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793532955;
	cv=pass; b=Pg0U8P02ge5afima9J+EWw3p0Hdzc/cGdcJiI3/2qs/2j5Jo3YCBXiOcgYRI4tkHgPIZKnu3YbhblEjySp8VehweMHJ+jdxWoF30YQVSJxX0JPphNcJFt+0XvexGZfFacQvdRVPTv36X/Kdmmu4nBfMRvFHWtDiaC2tpHb4HNDE0kjAQyrRpfY5CGT23in6DCNCwkT9vlIRPBOqxSmiaXCnoI9Co6sBRybtDYr0Jwhp5ljCSkWhdr9VN1lLPqgp8r3s/0cOlWhy+nzZJuZqORtTyxzqRZ7nWeaBVuwE7l2ok1wJUd+PwUcKBkuR+lkNvAMozsak0ckWso7uXfLdhVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793532955; c=relaxed/relaxed;
	bh=e2074Najjr40eJjq29H8HmdCXIfITYYaEJGmkIK26yw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mJOXIAdDpAOYiq8AL7aoSmVa3QxvVMftmjQ/Ze+T/3DBPas9wXljoFvGMFg6tjyJSETBhtoMSFwpZmaEB7KHzCDAfcO4ySXd5SU6FKlH80xQSEvpsD7XItOaa6sI2CV/onBLih6B9ADpG5pUn0qlQYpI2g4ab/tibQdTMbvgKMlGteZBcblilwrooKHqvOHDpOjZsb7JvRhlvnYrGPcbYv/+Q/6RP22vuy/iTUkhdv1xKXzOdU1AIA7De8jBPcMHDmhIu6pJXuS8ovyO8lkdNlEizWo4pD/fDmkUTd2SuYwhpRqYOXodOTdmKAI0/UqFHqcf3viHTZdBVr3TJJinnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KEbBjcyD; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PNDAkENG; dkim-atps=neutral; spf=pass (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KEbBjcyD;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PNDAkENG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHXpH039Yz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 22:35:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793532943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MvHWs6uUGz4sokDNLAnqKxqDP5NQmEpadvtiGWm58YaDpzkmcmRhZcrUJBGcdT89xV
    79DbKt4+2ZhKaLab25sivqy/By2Q1FY7m1LwlJHDLKZ3W+oO9e1ftD0QMVFH29LMMRz+
    9t+tTsAls/vAZF2j2fnV6xZJYjmaj7uj56NSOWcpoNvirvxCJXHY9h0PGV/CjPAYjnuS
    Y3FXfOmnGxJi6741x0C9L5spTf4b96SRRgLDGMNEYlFFcAYKM/7lf88aWZk0F2NY5MRw
    B1YqSkRQECEpb+6W7l93T2IyV73lkXAuF3MXWtu10kFhSm08N2Ql7bItL0653RUBKMIf
    /S+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793532943;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=e2074Najjr40eJjq29H8HmdCXIfITYYaEJGmkIK26yw=;
    b=TYa7RsAfV3CmiQNjfW+L6S3Tl/RHCRW1GWXsDJ72XBRC/fDio6KhPCKTdQzUJCwq36
    0EWeIDEDxCjJkYFOOG735welSONLCnFSelX850BylYA4RrlvZlNrRoex1/qLVjR3aUDr
    Ajcevdrjtsaz+sm1/O1slVPsadM6WzgA/iOygbHGd143jxgQd3F2TodE96Qhdz02jBAk
    FRE5gQwuVjNmdC4oOZNV8ceTGz1KTKMIc5cFHP5HvfhmCRhFGNZg/mGmaP7T2yX9ed3u
    /FWYwhVGi1J+I/186E3n1atVSrIU83Bx+Zna+K5DmkQOYXWQNVEfcEp+WiwlrLAyzffz
    wW9A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793532943;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=e2074Najjr40eJjq29H8HmdCXIfITYYaEJGmkIK26yw=;
    b=KEbBjcyDZ57FlO0eps0VF47jJTpv9lDVMjf4a0R9RhUvZT7Ig3+/Z/wVk1zHLoNcP8
    0/eDKD/vSVNTvK3u/6wDweHdWAb6nv4NWdeG5XhxCcPA/EEIU517FYmlsm68Pmw2Jd8W
    sKTaeow4kZkeHyWGhTSZhBLQ0YRDoQ1DxrefaHznTZNLChzMv8QoXEcvmR+Z2XcSFxRQ
    pLAD8LurK5gO6MbT9b2YICBElKNsIvP71me6xjac+crAvx1seJjWQaIojWntpPpKvf63
    xDdDbx2hNZlbNK2QrKpXCn3HvAC4voMk6XnZ4FA/uVlweQdkCmp29Bky7xpCEy9mKi5+
    MOgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793532943;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=e2074Najjr40eJjq29H8HmdCXIfITYYaEJGmkIK26yw=;
    b=PNDAkENGFyPCp/YKfD9D8JtQ2Fl6OavCRQAlvZCVPHKi0SBzYLzlFvalBuw+lGvOGE
    FIYWCs7w32Hcc48xD0Dw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7xzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92A1BZg5TE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Nov 2026 12:35:42 +0100 (CET)
Subject: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com,
 gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky
 <info@xenosoft.de>, Darren Stevens <darren@stevens-zone.net>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-2-sshegde@linux.ibm.com>
 <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com>
 <2a75097f-6b49-456a-bfef-d5e559ce719a@linux.ibm.com>
 <33tnw44q.ritesh.list@gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <8353fe7a-2313-8669-9603-c534f9b9bf9d@xenosoft.de>
Date: Sun, 1 Nov 2026 12:35:41 +0100
X-Mailer: BrassMonkey/35.0.2
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
In-Reply-To: <33tnw44q.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 05:21 PM, Ritesh Harjani (IBM) wrote:
 > Let's ask Christian directly :)
 > @Christian - Once we have v2, would you kindly help us test that
 > please?
 >
 > We think the other approach which Narayana suggested might be a better
 > fix for this and it can avoid preempt_enable/disable() dance. However,
 > looks like we may not have the board where we can reproduce this.
 >
 >
 > -ritesh
 >

Hi all,

Is it possible to add the following patch to the kernel?

Link: 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2026-October/305189.html

It is more important for us because the Nemo board can't boot without 
this patch.

Thanks,
Christian

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


