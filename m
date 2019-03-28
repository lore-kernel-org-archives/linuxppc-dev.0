Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:38:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFFE206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFFE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VQth3S0RzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:38:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VQr958NDzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 00:36:24 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0C6AC0798F9;
 Thu, 28 Mar 2019 13:36:19 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B353F5D73F;
 Thu, 28 Mar 2019 13:36:17 +0000 (UTC)
Subject: Re: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount
 findstring
To: Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190325160438.8982-1-joe.lawrence@redhat.com>
 <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
 <20190326173308.GA26546@redhat.com>
 <CAK7LNAT4VTUOtjEvJfe9+7yNemkodUnDo6bMoKxSgqGq7H4mOQ@mail.gmail.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <4f13ecb6-9aa8-5037-a18e-150c026254c2@redhat.com>
Date: Thu, 28 Mar 2019 09:36:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT4VTUOtjEvJfe9+7yNemkodUnDo6bMoKxSgqGq7H4mOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 28 Mar 2019 13:36:21 +0000 (UTC)
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/28/19 8:57 AM, Masahiro Yamada wrote:
> Hi Joe,
> 
> OK, confirmed.
 >
 > [ ... snip .... ]
> 
> First, I was wondering why I could not reproduce this issue.
> Then, I found the reason was I was using the latest GNU Make
> compiled from the git source tree.
> 
> I found the following commit:
> 
> commit b90fabc8d6f34fb37d428dc0fb1b8b1951a9fbed
> Author: Paul Smith <psmith@gnu.org>
> Date:   Sat May 27 20:07:30 2017 -0400
> 
>      * NEWS: Do not insert a space during '+=' if the value is empty.
> 
>      * doc/make.texi (Appending): Document this behavior.
>      * variable.c (do_variable_definition): Only add a space if the variable
>      value is not empty.
>      * tests/scripts/variables/flavors: Test this behavior.
> 
> diff --git a/NEWS b/NEWS
> index e60644a..6e2c5c6 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -29,6 +29,12 @@
> http://sv.gnu.org/bugs/index.php?group=make&report_id=111&fix_release_id=108&set
>     This was claimed to be fixed in 3.81, but wasn't, for some reason.
>     To detect this change search for 'nocomment' in the .FEATURES variable.
> 
> +* WARNING: Backward-incompatibility!
> +  Previously appending using '+=' to an empty variable would result in a value
> +  starting with a space.  Now the initial space is only added if the variable
> +  already contains some value.  Similarly, appending an empty string does not
> +  add a trailing space.
> +
>   * The previous limit of 63 jobs under -jN on MS-Windows is now
>     increased to 4095.  That limit includes the subprocess started by
>     the $(shell) function.
> 
> Applied to linux-kbuild/fixes with additional comments.
> 
> [Additional info by masahiro.yamada:
> This issue only happens in the released versions of GNU Make.
> CC_FLAGS_FTRACE will not contain the trailing space if you use
> the latest GNU Make, which contains commit b90fabc8d6f3
> ("* NEWS: Do not insert a space during '+=' if the value is empty.")
> ]
Wow, this one gets even more specific.  I had gone down the rabbit hole 
on this one, I didn't care to learn how or why that extra space got 
there :)  Now we know, thanks for running that down and adding the note 
about GNU Make.

-- Joe
