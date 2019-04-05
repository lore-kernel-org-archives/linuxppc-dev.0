Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B7C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 13:20:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563EC21850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 13:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W/hHlYqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563EC21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bL674rzBzDqSR
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 00:20:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=alien8.de
 (client-ip=2a01:4f8:190:11c2::b:1457; helo=mail.skyhub.de;
 envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.b="W/hHlYqT"; 
 dkim-atps=neutral
X-Greylist: delayed 362 seconds by postgrey-1.36 at bilbo;
 Sat, 06 Apr 2019 00:18:39 AEDT
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bL3z31gtzDqRJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 00:18:39 +1100 (AEDT)
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9ED3F1EC0104;
 Fri,  5 Apr 2019 15:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1554469939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=0PtObtUbIUtRj5xTEtTQd7chnLlXqEY1n/Wt3CU011Q=;
 b=W/hHlYqTe/u/bUCJGIvbWrNUBfT1HO1LNiFSjZdUVC8wz0HByWEeFVSXK1hzBTacd9I2X4
 CuOsWOEgE3IX7gT6Btm9nvNpXAcu0//CcwP4Ih8Jf6DC69+VKEGH6tcQyB5uAR3mrw4/eK
 AjfjimryC8XXbwofPlxDno66fGvsXdw=
Date: Fri, 5 Apr 2019 15:12:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190405131211.GE23348@zn.tnic>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 04, 2019 at 11:44:11AM -0500, Josh Poimboeuf wrote:
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> their own custom way to mitigate the same vulnerability.

Yap, we definitely need something like that.

> Most users fall into a few basic categories:
> 
> a) they want all mitigations off;
> 
> b) they want all reasonable mitigations on, with SMT enabled even if
>    it's vulnerable; or

Uff, "reasonable" - there's the bikeshed waiting to happen.

> c) they want all reasonable mitigations on, with SMT disabled if
>    vulnerable.
> 
> Define a set of curated, arch-independent options, each of which is an
> aggregation of existing options:
> 
> - cpu_spec_mitigations=off: Disable all mitigations.

"cpu_spec_mitigations" is too long, TBH.

Imagine yourself in a loud, noisy data center - you basically can't wait
to leave - crouched over a keyboard in an impossible position, having
to type that thing and then making a typo. Whoops, too late, already
pressed Enter. Shiiiit!

Now you have to wait at least 15 mins for the damn single-threaded added
value BIOS crap to noodle through all the cores just so you can try
again, because you just rebooted the box.

And I know, my ideas for shorter cmdline options are crazy, like

cpu_spec_mtg=

which people would say, yuck, unreadable...

Oh, I know! How about

cpu_vulns=

?

We already have /sys/devices/system/cpu/vulnerabilities so it'll be the
same as that. Less things to remember.

> - cpu_spec_mitigations=auto: [default] Enable all the default
>   mitigations, but leave SMT enabled, even if it's vulnerable.
> 
> - cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
>   disabling SMT if needed by a mitigation.

Yah, the suboption choices make sense to me.

> 
> Currently, these options are placeholders which don't actually do
> anything.  They will be fleshed out in upcoming patches.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++++++
>  include/linux/cpu.h                           |  8 +++++++
>  kernel/cpu.c                                  | 15 ++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c4d830003b21..ac42e510bd6e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2544,6 +2544,29 @@
>  			in the "bleeding edge" mini2440 support kernel at
>  			http://repo.or.cz/w/linux-2.6/mini2440.git
>  
> +	cpu_spec_mitigations=
> +			[KNL] Control mitigations for CPU speculation
> +			vulnerabilities on affected CPUs.  This is a set of
> +			curated, arch-independent options, each of which is an
> +			aggregation of existing options.
> +
> +			off
> +				Disable all speculative CPU mitigations.

Alias to

cpu_vulns=make_linux_fast_again

:-P

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
