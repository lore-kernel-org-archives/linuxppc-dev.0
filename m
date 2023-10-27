Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C609CC25B47
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 10:48:12 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=R7an/BvX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGzsR3jDgz3cV0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 21:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=R7an/BvX;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGzrV34Ttz3c4M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 21:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698403640;
	bh=scnewICwos28uY3w6B5+AVxL28jk/U3U4erXzZ/w740=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R7an/BvXmk6zHAjf/zZOxIofIyozCb1FFKCl2wait4uupeZxCA6t6WNDOgPydtEgu
	 fw35hyN4ijQkAjQN3zd8HMNak0z/OlLE1qjSkib/ZIHRHG1N52q1NLMb8fKVr1i6fa
	 yW4yMlLU19dHKRnNRO86oqzyaT0Y3xOWP/6LbFmgLG4vUO+/P+9xrtNMuXvJz3/cYo
	 EQVS4L821yQBt/F6cxmmLBUdwRPSN2k98FUtP4RKxQ7raeqA7fGVqedpEbAKroSubd
	 w0Igv8+qlkcRuGotBM1woCbYmVIyefNCjGsyWZ8m+oHSxZOV2jS8Qv2awIvqsG9jQV
	 9VdioeV2QEzKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGzrR6ZLyz4wcj;
	Fri, 27 Oct 2023 21:47:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Barrat
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] cxl: make cxl_class constant
In-Reply-To: <2023102533-anyway-bullish-75be@gregkh>
References: <2023102434-haiku-uphill-0c11@gregkh>
 <9573ec63-a8d6-4c69-a70b-9095838d521d@linux.ibm.com>
 <2023102533-anyway-bullish-75be@gregkh>
Date: Fri, 27 Oct 2023 21:47:16 +1100
Message-ID: <8734xwuytn.fsf@mail.lhotse>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Oct 25, 2023 at 10:16:55AM +0200, Frederic Barrat wrote:
>> On 24/10/2023 13:48, Greg Kroah-Hartman wrote:
>> > Now that the driver core allows for struct class to be in read-only
>> > memory, we should make all 'class' structures declared at build time
>> > placing them into read-only memory, instead of having to be dynamically
>> > allocated at runtime.
>> > 
>> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
>> > Cc: Andrew Donnellan <ajd@linux.ibm.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> 
>> Thanks!
>> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Thanks for the review of these, I'll take them through my char/misc tree
> now.

Ack.

cheers
