Return-Path: <SRS0=VIHX=6D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBDDC38A30
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 11:55:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8315D214D8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 11:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8315D214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 494pF656f7zDrHF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 21:55:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=xmission.com
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494pBb3p9yzDqbv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2020 21:53:41 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out01.mta.xmission.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.90_1)
 (envelope-from <ebiederm@xmission.com>)
 id 1jQ8W1-0003fL-D0; Sun, 19 Apr 2020 05:53:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com) by in02.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1jQ8Vz-0006Fr-TU; Sun, 19 Apr 2020 05:53:37 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20200414070142.288696-1-hch@lst.de>
 <87r1wl68gf.fsf@x220.int.ebiederm.org> <20200419081926.GA12539@lst.de>
Date: Sun, 19 Apr 2020 06:50:32 -0500
In-Reply-To: <20200419081926.GA12539@lst.de> (Christoph Hellwig's message of
 "Sun, 19 Apr 2020 10:19:26 +0200")
Message-ID: <87o8rn3d9z.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQ8Vz-0006Fr-TU; ; ; mid=<87o8rn3d9z.fsf@x220.int.ebiederm.org>;
 ; ; hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX1++Xt8JJKQGcbPJViucMNdTMbptPpl2UTk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: remove set_fs calls from the exec and coredump code v2
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:

> On Fri, Apr 17, 2020 at 05:41:52PM -0500, Eric W. Biederman wrote:
>> > this series gets rid of playing with the address limit in the exec and
>> > coredump code.  Most of this was fairly trivial, the biggest changes are
>> > those to the spufs coredump code.
>> >
>> > Changes since v1:
>> >  - properly spell NUL
>> >  - properly handle the compat siginfo case in ELF coredumps
>> 
>> Quick question is exec from a kernel thread within the scope of what you
>> are looking at?
>> 
>> There is a set_fs(USER_DS) in flush_old_exec whose sole purpose appears
>> to be to allow exec from kernel threads.  Where the kernel threads
>> run with set_fs(KERNEL_DS) until they call exec.
>
> This series doesn't really look at that area.  But I don't think exec
> from a kernel thread makes any sense, and cleaning up how to set the
> initial USER_DS vs KERNEL_DS state is something I'll eventually get to,
> it seems like a major mess at the moment.

Fair enough.  I just wanted to make certain that it is on people's radar
that when the kernel exec's init the arguments are read from kernel
memory and the set_fs(USER_DS) in flush_old_exec() that makes that not
work later.

It is subtle and easy to miss.  So I figured I would mention it since
I have been staring at the exec code a lot lately.

Eric
