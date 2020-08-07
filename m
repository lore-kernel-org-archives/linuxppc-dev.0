Return-Path: <SRS0=e617=BS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8260C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 01:00:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE2720866
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 01:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE2720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNkRV50lgzDqvK
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 11:00:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2002:c35c:fd02::1;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNZpF5W97zDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2020 05:16:05 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k47on-00BJ6k-Ez; Fri, 07 Aug 2020 19:14:17 +0000
Date: Fri, 7 Aug 2020 20:14:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-1 tag
Message-ID: <20200807191417.GU1236603@ZenIV.linux.org.uk>
References: <87h7tey4xq.fsf@mpe.ellerman.id.au>
 <CAHk-=wif9A9Y1i1xbie5Qsr7e-YoTpv9O_YSF8NCHWksDPEa2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wif9A9Y1i1xbie5Qsr7e-YoTpv9O_YSF8NCHWksDPEa2Q@mail.gmail.com>
X-Mailman-Approved-At: Sat, 08 Aug 2020 10:06:32 +1000
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 desnesn@linux.ibm.com, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 ego@linux.vnet.ibm.com, aik@ozlabs.ru, jniethe5@gmail.com,
 bin.meng@windriver.com, psampat@linux.ibm.com, bala24@linux.ibm.com,
 msuchanek@suse.de, sathnaga@linux.vnet.ibm.com,
 Oliver O'Halloran <oohall@gmail.com>, fthain@telegraphics.com.au,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, equinox@diac24.net,
 leobras.c@gmail.com, santosh@fossix.org, maddy@linux.ibm.com,
 Nayna Jain <nayna@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>,
 mahesh@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
 anju@linux.vnet.ibm.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 weiyongjun1@huawei.com, alastair@d-silva.org, harish@linux.ibm.com,
 Waiman Long <longman@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, dyoung@redhat.com,
 vdronov@redhat.com, nathanl@linux.ibm.com, miltonm@us.ibm.com,
 palmerdabbelt@google.com, ajd@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>,
 lirongqing@baidu.com, sandipan@linux.ibm.com, kjain@linux.ibm.com,
 muriloo@linux.ibm.com, Nick Piggin <npiggin@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>, Joe Perches <joe@perches.com>,
 chris.packham@alliedtelesis.co.nz, Vaibhav Jain <vaibhav@linux.ibm.com>,
 felix@linux.ibm.com, hbathini@linux.ibm.com,
 Christophe Leroy <christophe.leroy@c-s.fr>, atrajeev@linux.vnet.ibm.com,
 wenxiong@linux.vnet.ibm.com, sbobroff@linux.ibm.com,
 Randy Dunlap <rdunlap@infradead.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, sourabhjain@linux.ibm.com,
 bharata@linux.ibm.com, Tejun Heo <tj@kernel.org>, miaoqinglang@huawei.com,
 Jeremy Kerr <jk@ozlabs.org>, grandmaster@al2klimov.de,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, fbarrat@linux.ibm.com,
 huntbag@linux.vnet.ibm.com, kaloz@openwrt.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 07, 2020 at 10:46:13AM -0700, Linus Torvalds wrote:
> On Fri, Aug 7, 2020 at 6:14 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Just one minor conflict, in a comment in drivers/misc/ocxl/config.c.
> 
> Well, this morning I merged the ptrace ->regset_get() updates from Al,
> and that brought in a different conflict.
> 
> I _think_ I resolved it correctly, but while the new model is fairly
> readable, the old one sure wasn't, and who knows how messed up my
> attempt to sort it out was. I don't know the pkey details on powerpc..
> 
> So I'd appreciate it if both Al and Aneesh Kumar would check that what
> I did to pkey_get() in arch/powerpc/kernel/ptrace/ptrace-view.c makes
> sense and works..

Grabbing...

Looks sane and yes, 3 membuf_store() instead of membuf_write() + membuf_store()
would make sense (might even yield better code).  Up to ppc folks...

> Side note - it might have been cleaner to just make it do
> 
>         membuf_store(&to, target->thread.amr);
>         membuf_store(&to, target->thread.iamr);
>         return membuf_store(&to, default_uamor);
> 
> instead of doing that membuf_write() for the first two ones and then
> the membuf_store() for the uamor field, but I did what I did to keep
> the logic as close to what it used to be as possible.
> 
> If I messed up, I apologize.
> 
> And if you agree that making it three membuf_store() instead of that
> odd "depend on the exact order of the thread struct and pick two
> consecutive values", I'll leave that to you as a separate cleanup.
> 
>                    Linus
