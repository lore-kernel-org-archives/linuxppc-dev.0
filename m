Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:02:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868512146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868512146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVSh50TKzDqBj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:02:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVNR5LQVzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44PVNR2tZ9z9sPM; Wed, 20 Mar 2019 23:58:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVNR1Lmsz9sPL;
 Wed, 20 Mar 2019 23:58:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 02/10] powerpc/powernv/idle: Restore AMR/UAMOR/AMOR
 after idle
In-Reply-To: <20190313081630.GB4047@aks.ibm>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-2-mpe@ellerman.id.au> <20190313081630.GB4047@aks.ibm>
Date: Wed, 20 Mar 2019 23:58:45 +1100
Message-ID: <87o965ya62.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> On Fri, Mar 08, 2019 at 12:16:11PM +1100, Michael Ellerman wrote:
>> In order to implement KUAP (Kernel Userspace Access Protection) on
>> Power9 we will be using the AMR, and therefore indirectly the
>> UAMOR/AMOR.
>> 
>> So save/restore these regs in the idle code.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>> v5: Unchanged.
>> v4: New.
>> 
>>  arch/powerpc/kernel/idle_book3s.S | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> Opps.. i posted a comment on the v4. 
>
> It would be good if we can make AMOR/UAMOR/AMR save-restore
> code power9 only.

Yes that would be a good optimisation.

If you can send an incremental patch against this one I'll squash it in.
If not I'll try and get it done at some point before merging.

cheers
