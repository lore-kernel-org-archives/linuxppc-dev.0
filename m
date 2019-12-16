Return-Path: <SRS0=uftn=2G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D0C43603
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 06:07:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FA720663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 06:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FA720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47brQZ1yVCzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47brNY47fNzDqT4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2019 17:05:31 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 28FAEBDBE;
 Mon, 16 Dec 2019 06:05:27 +0000 (UTC)
Date: Mon, 16 Dec 2019 07:05:20 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add barrier_nospec to raw_copy_in_user()
Message-ID: <20191216060520.GQ3986@kitsune.suse.cz>
References: <20190306011038.16449-1-sjitindarsingh@gmail.com>
 <20190821153656.57fabe9c@kitsune.suse.cz>
 <87o8zhvgyc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8zhvgyc.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 19, 2019 at 12:04:27AM +1000, Michael Ellerman wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> > On Wed,  6 Mar 2019 12:10:38 +1100
> > Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:
> >
> >> Commit ddf35cf3764b ("powerpc: Use barrier_nospec in copy_from_user()")
> >> Added barrier_nospec before loading from user-controller pointers.
> >> The intention was to order the load from the potentially user-controlled
> >> pointer vs a previous branch based on an access_ok() check or similar.
> >> 
> >> In order to achieve the same result, add a barrier_nospec to the
> >> raw_copy_in_user() function before loading from such a user-controlled
> >> pointer.
> >> 
> >> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >> ---
> >>  arch/powerpc/include/asm/uaccess.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> >> index e3a731793ea2..bb615592d5bb 100644
> >> --- a/arch/powerpc/include/asm/uaccess.h
> >> +++ b/arch/powerpc/include/asm/uaccess.h
> >> @@ -306,6 +306,7 @@ extern unsigned long __copy_tofrom_user(void __user *to,
> >>  static inline unsigned long
> >>  raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
> >>  {
> >> +	barrier_nospec();
> >>  	return __copy_tofrom_user(to, from, n);
> >>  }
> >>  #endif /* __powerpc64__ */
> >
> > Hello,
> >
> > AFAICT this is not needed. The data cannot be used in the kernel without
> > subsequent copy_from_user which already has the nospec barrier.
> 
> Suraj did talk to me about this before sending the patch. My memory is
> that he came up with a scenario where it was at least theoretically
> useful, but he didn't mention that in the change log. He was working on
> nested KVM at the time.
> 
> I've now forgotten, and he's moved on to other things so probably won't
> remember either, if he's even checking his mail :/

In absence of any argument for the code and absence of the same code on
other architectures I would say you were just confused when merging
this. The code is confusing after all.

Thanks

Michal
