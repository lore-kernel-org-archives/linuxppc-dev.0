Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F6C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 17:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54D820850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 17:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54D820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RSF91XFSzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 04:29:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RSCC4T4QzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 04:27:35 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24AAA8762D;
 Sat, 23 Mar 2019 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-251.rdu2.redhat.com
 [10.10.120.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE5560851;
 Sat, 23 Mar 2019 17:27:32 +0000 (UTC)
Subject: Re: ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
To: Steven Rostedt <rostedt@goodmis.org>
References: <20190323131950.GA30948@redhat.com>
 <20190323121732.59533e78@grimm.local.home>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <16061c33-4b42-8b8c-008c-123b2991677c@redhat.com>
Date: Sat, 23 Mar 2019 13:27:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190323121732.59533e78@grimm.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Sat, 23 Mar 2019 17:27:33 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/23/2019 12:17 PM, Steven Rostedt wrote:
> On Sat, 23 Mar 2019 09:19:50 -0400
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
>> Perhaps this is gcc version specific?  I didn't see any other reports,
>> so maybe its specific to my config.  If I run make V=1, I can see that
>> gcc is called with '-pg -mprofile-kernel', but then the record_mcount
>> script is skipped.  Any ideas?
> 
> But you see it running the script if you remove that commit? Do you
> happen to see -mrecord-mcount at all in a V=1 make?
> 

See entire make output from the two runs here:
http://people.redhat.com/~jolawren/ppc64le-mprofile/

-- Joe
