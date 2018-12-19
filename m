Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D9C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 09:53:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0285220873
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 09:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KVZM70VfzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 20:53:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KVX43LXWzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 20:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43KVX36DTLz9s3Z;
 Wed, 19 Dec 2018 20:51:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc/32: Include .branch_lt in data section
In-Reply-To: <20181118082652.GA21617@bubble.grove.modra.org>
References: <20181114030218.25508-1-joel@jms.id.au>
 <20181114040045.GX29784@bubble.grove.modra.org>
 <87wopetslj.fsf@concordia.ellerman.id.au>
 <20181118082652.GA21617@bubble.grove.modra.org>
Date: Wed, 19 Dec 2018 20:51:13 +1100
Message-ID: <87tvj9rgj2.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alan Modra <amodra@gmail.com> writes:
> On Thu, Nov 15, 2018 at 11:47:52PM +1100, Michael Ellerman wrote:
>> Alan Modra <amodra@gmail.com> writes:
>> 
>> > On Wed, Nov 14, 2018 at 01:32:18PM +1030, Joel Stanley wrote:
>> >> I wasn't sure where this should go or if the ordering matters.
>> >
>> > The usual answer is: "Look at where the section goes in the standard
>> > linker scripts."   But that doesn't apply here.  The section will be
>> > empty for a kernel build so it doesn't matter where it goes.
>> 
>> If it's empty why don't we just discard it?
>
> That can be a recipe for finding linker bugs.  Not that I'm against
> you finding linker bugs.  ;-)

Seems we might have found a linker bug :)

With a binutils 2.29 toolchain discarding .branch_lt causes a segfault
when linking:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13618838/log/

  /kisskb/src/scripts/link-vmlinux.sh: line 85: 74627 Segmentation fault      (core dumped) ${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${2} -T ${lds} ${objects}


That toolchain is here:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/x86_64-gcc-5.5.0-nolibc-powerpc64-linux.tar.xz

It seems to be better with binutils 2.30, it doesn't crash but still
doesn't link:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13620269/log/

  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: linkage table error against `0002bf55.xdp_rxq_info_reg_mem_model'
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: stubs don't match calculated size
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: can not build stubs: Bad value
  make[1]: *** [/kisskb/src/Makefile:1036: vmlinux] Error 1

So I guess I'll take this version of the patch for now.

cheers
