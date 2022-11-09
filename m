Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8818AC433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Nov 2022 11:33:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N6jXB0Fq2z3dtj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Nov 2022 22:33:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pEMkcgyD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=94.23.1.103; helo=out0.migadu.com; envelope-from=yajun.deng@linux.dev; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pEMkcgyD;
	dkim-atps=neutral
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N6jW71T1Xz2xHT
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2022 22:32:33 +1100 (AEDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1667993547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yu+w3QHApO1TE2YmVSkeE9AnWV+eYHtsSJh4PBsvKg=;
	b=pEMkcgyDVRTho3dCslvw5uAjkUeTmBUMKnIjLPUtnxUlcXOsVbDAoM7LFvyfvv4YPJpCXz
	SYnTMdhBHnt3hudbQnN6f8sTckrsquf/XU85CbpnKWoygOcchlnek3xwIcHDqWuDG3Zjrd
	nBH2scm75Ip+tG2TlxoO/y9wAOE7WGE=
Date: Wed, 09 Nov 2022 11:32:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <6e32f14ae25909138e40b2cfd7448ed8@linux.dev>
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
To: "Sachin Sant" <sachinp@linux.ibm.com>, "Mike Rapoport"
 <rppt@linux.ibm.com>
In-Reply-To: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
References: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
 <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
 <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
 <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

November 9, 2022 6:55 PM, "Sachin Sant" <sachinp@linux.ibm.com> wrote:=0A=
=0A>> On 09-Nov-2022, at 3:55 PM, Yajun Deng <yajun.deng@linux.dev> wrote=
:=0A>> =0A>> November 9, 2022 6:03 PM, "Yajun Deng" <yajun.deng@linux.dev=
> wrote:=0A>> =0A>>> Hey Mike,=0A>> =0A>> Sorry, this email should be sen=
t to Sachin but not Mike.=0A>> Please forgive my confusion. So:=0A>> =0A>=
> Hey Sachin,=0A>> Can you help me test the attached file?=0A>> Please us=
e this new patch instead of the one in memblock tree.=0A> =0A> Thanks for=
 the fix. With the updated patch kernel boots correctly.=0A> =0A=0AThanks=
 for your test results.=0A=0AHi Mike,=0ADo you have any other suggestions=
 for this patch? If not, I'll send a v3 patch.=0A=0A> Tested-by: Sachin S=
ant <sachinp@linux.ibm.com <sachinp@linux.ibm.com>>=0A> =0A> - Sachin
