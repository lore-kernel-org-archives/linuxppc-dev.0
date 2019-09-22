Return-Path: <SRS0=KyHJ=XR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92807C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Sep 2019 12:06:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B0A2054F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Sep 2019 12:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46bmPw1tldzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Sep 2019 22:06:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46bmMb4h8MzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2019 22:04:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46bmMZ0TJPz9sCJ;
 Sun, 22 Sep 2019 22:04:09 +1000 (AEST)
Date: Sun, 22 Sep 2019 22:03:59 +1000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com>
 <1569003478.5576.202.camel@lca.pw>
 <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
To: Dan Williams <dan.j.williams@intel.com>,Qian Cai <cai@lca.pw>
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 21 September 2019 4:31:16 am AEST, Dan Williams <dan=2Ej=2Ewilliams@int=
el=2Ecom> wrote:
>On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca=2Epw> wrote:
>>
>> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K=2EV wrote:
>> > Qian Cai <cai@lca=2Epw> writes:
>> >
>> > > The linux-next commit "libnvdimm/dax: Pick the right alignment
>default when
>> > > creating dax devices" causes powerpc failed to build with this
>config=2E Reverted
>> > > it fixed the issue=2E
>> > >
>> > > ERROR: "hash__has_transparent_hugepage"
>[drivers/nvdimm/libnvdimm=2Eko] undefined!
>> > > ERROR: "radix__has_transparent_hugepage"
>[drivers/nvdimm/libnvdimm=2Eko]
>> > > undefined!
>> > > make[1]: *** [scripts/Makefile=2Emodpost:93: __modpost] Error 1
>> > > make: *** [Makefile:1305: modules] Error 2
>> > >
>> > > [1] https://patchwork=2Ekernel=2Eorg/patch/11133445/
>> > > [2]
>https://raw=2Egithubusercontent=2Ecom/cailca/linux-mm/master/powerpc=2Eco=
nfig
>> >
>> > Sorry for breaking the build=2E How about?
>>
>> It works fine=2E
>
>Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
>default when creating dax devices" until after -rc1 to allow Michael
>time to ack/nak this new export=2E

Thanks Dan=2E It looks fine to me:

Acked-by: Michael Ellerman <mpe@ellerman=2Eid=2Eau>

cheers
--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
