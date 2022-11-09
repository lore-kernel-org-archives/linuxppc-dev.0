Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1E5C4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Nov 2022 11:50:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N6jvk1djkz3dvZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Nov 2022 22:50:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lvOnCMWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:2:267::; helo=out0.migadu.com; envelope-from=yajun.deng@linux.dev; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lvOnCMWJ;
	dkim-atps=neutral
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N6jt84WLJz3cMc
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2022 22:49:02 +1100 (AEDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1667994539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lW0LJebmesD/58H5kukJ16h9hALOR1xtn+1+pkrJwxU=;
	b=lvOnCMWJbgBbCgtGjQV3h71e9sEP5uht70CvH/oqAXjZTPOmYjLXhQo4eQcPCGllKLC0/q
	6Koj8UQJ5LkeGE6mopltTVDph5Zn5+5dqbB3ISGyEqZxc/WC+fznEEADeC9573ZqhOFWFa
	E22PuorhYmbAtEN87YZDjm6NpuFe9Mw=
Date: Wed, 09 Nov 2022 11:48:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fccbe6b1bd533a84f50cd675b57ecb17@linux.dev>
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
To: "Mike Rapoport" <rppt@linux.ibm.com>
In-Reply-To: <Y2uSH8jm1MzY9Rgf@linux.ibm.com>
References: <Y2uSH8jm1MzY9Rgf@linux.ibm.com>
 <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
 <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
 <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
 <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
 <6e32f14ae25909138e40b2cfd7448ed8@linux.dev>
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
Cc: linux-mm@kvack.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, Sachin Sant <sachinp@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

November 9, 2022 7:42 PM, "Mike Rapoport" <rppt@linux.ibm.com> wrote:=0A=
=0A> Hi Yajun,=0A> =0A> On Wed, Nov 09, 2022 at 11:32:27AM +0000, Yajun D=
eng wrote:=0A> =0A>> November 9, 2022 6:55 PM, "Sachin Sant" <sachinp@lin=
ux.ibm.com> wrote:=0A>> =0A>> On 09-Nov-2022, at 3:55 PM, Yajun Deng <yaj=
un.deng@linux.dev> wrote:=0A>> =0A>> November 9, 2022 6:03 PM, "Yajun Den=
g" <yajun.deng@linux.dev> wrote:=0A>> =0A>> Hey Mike,=0A>> =0A>> Sorry, t=
his email should be sent to Sachin but not Mike.=0A>> Please forgive my c=
onfusion. So:=0A>> =0A>> Hey Sachin,=0A>> Can you help me test the attach=
ed file?=0A>> Please use this new patch instead of the one in memblock tr=
ee.=0A>> =0A>> Thanks for the fix. With the updated patch kernel boots co=
rrectly.=0A>> =0A>> Thanks for your test results.=0A>> =0A>> Hi Mike,=0A>=
> Do you have any other suggestions for this patch? If not, I'll send a v=
3 patch.=0A> =0A> Unfortunately I don't think the new version has much va=
lue as it does not=0A> really eliminate the second loop in case memory al=
location is required.=0A> I'd say the improvement is not worth the churn.=
=0A> =0AOK, I got it.=0A=0A>> Tested-by: Sachin Sant <sachinp@linux.ibm.c=
om <sachinp@linux.ibm.com>>=0A>> =0A>> - Sachin=0A> =0A> --=0A> Sincerely=
 yours,=0A> Mike.
