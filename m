Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E7C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2F4218A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F4218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KF9J4xW9zDqWY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:49:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KF6c4YB9zDqdg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 10:46:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43KF6c21sbz9s2P;
 Wed, 19 Dec 2018 10:46:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 0/2] of: phandle_cache, fix refcounts,
 remove stale entry
In-Reply-To: <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
Date: Wed, 19 Dec 2018 10:46:48 +1100
Message-ID: <87mup2s8if.fsf@concordia.ellerman.id.au>
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rob Herring <robh+dt@kernel.org> writes:
> On Mon, Dec 17, 2018 at 1:56 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Non-overlay dynamic devicetree node removal may leave the node in
>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>> will incorrectly find the stale entry.  This bug exposed the foloowing
>> phandle cache refcount bug.
>>
>> The refcount of phandle_cache entries is not incremented while in
>> the cache, allowing use after free error after kfree() of the
>> cached entry.
>>
>> Changes since v1:
>>   - make __of_free_phandle_cache() static
>>   - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
>>
>> Frank Rowand (2):
>>   of: of_node_get()/of_node_put() nodes held in phandle cache
>>   of: __of_detach_node() - remove node from phandle cache
>
> I'll send this to Linus this week if I get a tested by. Otherwise, it
> will go in for 4.21.

I think it can wait to go into 4.21, it's not super critical and it's
not a regression since 4.19.

cheers
