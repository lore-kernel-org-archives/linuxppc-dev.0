Return-Path: <SRS0=oNnW=L3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2FAC07E95
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Jul 2021 03:05:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CE06108B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Jul 2021 03:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CE06108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGxf84FgYz3bXt
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Jul 2021 13:05:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=yi.zhang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GGxdn0C64z2yNs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jul 2021 13:05:14 +1000 (AEST)
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GGxWP1Z0qz1BSYn;
 Sat,  3 Jul 2021 10:59:45 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 3 Jul 2021 11:05:07 +0800
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
To: Theodore Ts'o <tytso@mit.edu>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com> <YN86yl5kgVaRixxQ@mit.edu>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <36778615-86fd-9a19-9bc9-f93a6f2d5817@huawei.com>
Date: Sat, 3 Jul 2021 11:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YN86yl5kgVaRixxQ@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, Jan Kara <jack@suse.cz>,
 Guoqing Jiang <guoqing.jiang@linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2021/7/3 0:11, Theodore Ts'o wrote:
> On Fri, Jul 02, 2021 at 09:52:13PM +0800, Zhang Yi wrote:
>>
>> Sorry about not catching this problem, this fix is not format corrected,
>> if you think this fix is OK, I can send a patch after test.
> 
> The issue I see with your approach, which removes the
> jbd2_journal_unregister_shrinker() call from jbd2_destsroy_journal(),
> is that means that *all* callers of jbd2_destroy_journal now have to
> be responsible for calling jbd2_journal_unregister_shrinker() --- and
> there a number of call sites to jbd2_journal_unregister_shrinker():
> 
> fs/ext4/super.c:		err = jbd2_journal_destroy(sbi->s_journal);
> fs/ext4/super.c:		jbd2_journal_destroy(sbi->s_journal);
> fs/ext4/super.c:	jbd2_journal_destroy(journal);
> fs/ext4/super.c:		jbd2_journal_destroy(journal);
> fs/ext4/super.c:	jbd2_journal_destroy(journal);
> fs/ocfs2/journal.c:	if (!jbd2_journal_destroy(journal->j_journal) && !status) {
> fs/ocfs2/journal.c:		jbd2_journal_destroy(journal);
> fs/ocfs2/journal.c:	jbd2_journal_destroy(journal);
> 

Originally, I want to add this shrinker as a optional feature for jbd2 because
only ext4 use it now and I'm not sure does ocfs2 needs this feature. So I export
jbd2_journal_[un]register_shrinker(), ext4 could invoke them individually.

If with my fix, there is no responsible for calling
jbd2_journal_unregister_shrinker() before every jbd2_journal_destroy(). There
are only two places that need to do this, one is the error path after
ext4_load_journal() because we have already register the shrinker, other one
is in ext4_put_super() before the final release of the journal.
jbd2_journal_unregister_shrinker() and jbd2_journal_destroy() do not have
the strong dependence.

And one more thing we to could do is rename the 'j_jh_shrink_count' to something
like 'j_checkpoint_jh_count' because we always init it no matter we register the
shrinker or not later.

> So it probably makes more sense to keep jbd2_journal_unregister_shrinker()
> in jbd2_destroy_journal(), since arguably the fact that we are using a
> shrinker is an internal implementation detail, and the users of jbd2
> ideally shouldn't need to be expected to know they have unregister
> jbd2's shirnkers.
> 
> Similarly, perhaps we should be moving jbd2_journal_register_shirnker()
> into jbd2_journal_init_common().  We can un-export the register and
> unshrink register functions, and declare them as static functions internal
> to fs/jbd2/journal.c.
> 

Yeah, it's make sense and It's sound good to me if the shrinker doesn't have
side effects on osfs2.

Thanks,
Yi.
