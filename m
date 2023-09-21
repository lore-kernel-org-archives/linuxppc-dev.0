Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F62E71060
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:27:22 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=b687BW/T;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrvmT1zYyz3cPN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 22:27:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=b687BW/T;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrvlS20xMz2ymM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2023 22:26:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1695299186;
	bh=bC6X1py1SuoJtQxgFRw2Ryvn0wAzoIONYvfkgObrO/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b687BW/TgpeWKwniyy7LJa+Q+crc7hK9dcN5nxIiKaTQwPR20r4+nJoMYJ7svqNCj
	 /9RmYxIq7saR8Kb1/TIP2XEODSZ4i5hv8Q/hZeq7pF11pfpX5EG7q1Ib7+4WXf6b2Q
	 8A7PwdhUfkL042R8T1EpbwTr+S5QU+MY4gwQ/D/+Jhje4RjhdUNe7v4w4rDLoIRrDx
	 s08TCC0peYnEmH8y4ZL3QgHOv3QQcIu5t8azjGBN2Ko+2/C5eKQHnbVvMwhyhxAywb
	 8wqnarIilxNt6r1mqCBJ+jahygWV0uJGWRAKev5Wx5qUJzMjPWTsO/6HidLroKFqhB
	 RpNBBqLs/S+hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrvlP6nYLz4wy9;
	Thu, 21 Sep 2023 22:26:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: Recent Power changes and stack_trace_save_tsk_reliable?
In-Reply-To: <ZQr-vmBBQ66TRobQ@alley>
References: <ZO4K6hflM/arMjse@redhat.com> <87o7ipxtdc.fsf@mail.lhotse>
 <87il8xxcg7.fsf@mail.lhotse>
 <cca0770c-1510-3a02-d0ba-82ee5a0ae4f2@redhat.com> <ZQr-vmBBQ66TRobQ@alley>
Date: Thu, 21 Sep 2023 22:26:22 +1000
Message-ID: <8734z7ogpd.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, Ryan Sullivan <rysulliv@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Petr Mladek <pmladek@suse.com> writes:
> On Wed 2023-08-30 17:47:35, Joe Lawrence wrote:
>> On 8/30/23 02:37, Michael Ellerman wrote:
>> > Michael Ellerman <mpe@ellerman.id.au> writes:
>> >> Joe Lawrence <joe.lawrence@redhat.com> writes:
>> >>> We noticed that our kpatch integration tests started failing on ppc64le
>> >>> when targeting the upstream v6.4 kernel, and then confirmed that the
>> >>> in-tree livepatching kselftests similarly fail, too.  From the kselftest
>> >>> results, it appears that livepatch transitions are no longer completing.
...
>> > 
>> > The diff below fixes it for me, can you test that on your setup?
>> > 
>> 
>> Thanks for the fast triage of this one.  The proposed fix works well on
>> our setup.  I have yet to try the kpatch integration tests with this,
>> but I can verify that all of the kernel livepatching kselftests now
>> happily run.
>
> Have this been somehow handled, please? I do not see the proposed
> change in linux-next as of now.

I thought I was waiting for Joe to run the kpatch integration tests, but
in hindsight maybe he was hinting that someone else should run them (ie. me) ;)

Patch incoming.

cheers
