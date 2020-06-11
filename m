Return-Path: <SRS0=eRxT=7Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFEBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 12:12:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5DF20760
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 12:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5DF20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49jN5y2ScRzDqnr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 22:12:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.233;
 helo=out03.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=xmission.com
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49jMZ94pW2zDqmY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2020 21:48:32 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out03.mta.xmission.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.90_1)
 (envelope-from <ebiederm@xmission.com>)
 id 1jjLfz-0007P3-5f; Thu, 11 Jun 2020 05:47:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com) by in02.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1jjLfw-0001Mk-3p; Thu, 11 Jun 2020 05:47:18 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Xiaoming Ni <nixiaoming@huawei.com>
References: <1591847640-124894-1-git-send-email-nixiaoming@huawei.com>
Date: Thu, 11 Jun 2020 06:43:00 -0500
In-Reply-To: <1591847640-124894-1-git-send-email-nixiaoming@huawei.com>
 (Xiaoming Ni's message of "Thu, 11 Jun 2020 11:54:00 +0800")
Message-ID: <87ftb1u8u3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jjLfw-0001Mk-3p; ; ; mid=<87ftb1u8u3.fsf@x220.int.ebiederm.org>;
 ; ; hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX19hP4CdPcUEAK+CnByFjrA5zF9D0pP6nXA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] All arch: remove system call sys_sysctl
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-Mailman-Approved-At: Thu, 11 Jun 2020 22:09:32 +1000
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
Cc: linux-sh@vger.kernel.org, catalin.marinas@arm.com, paulus@samba.org,
 ak@linux.intel.com, paulburton@kernel.org, geert@linux-m68k.org,
 mattst88@gmail.com, brgerst@gmail.com, acme@kernel.org, cyphar@cyphar.com,
 viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de,
 surenb@google.com, rth@twiddle.net, young.liuyang@huawei.com,
 linux-parisc@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, jongk@linux-m68k.org,
 linux@dominikbrodowski.net, James.Bottomley@HansenPartnership.com,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp,
 deller@gmx.de, yzaikin@google.com, mszeredi@redhat.com, gor@linux.ibm.com,
 linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, tony.luck@intel.com,
 linux-api@vger.kernel.org, zhouyanjie@wanyeetech.com, minchan@kernel.org,
 sargun@sargun.me, alexander.shishkin@linux.intel.com,
 heiko.carstens@de.ibm.com, alex.huangjianhui@huawei.com, will@kernel.org,
 krzk@kernel.org, borntraeger@de.ibm.com, vbabka@suse.cz,
 samitolvanen@google.com, flameeyes@flameeyes.com, ravi.bangoria@linux.ibm.com,
 elver@google.com, keescook@chromium.org, arnd@arndb.de, bp@alien8.de,
 christian@brauner.io, tsbogend@alpha.franken.de, jiri@mellanox.com,
 martin.petersen@oracle.com, yamada.masahiro@socionext.com, oleg@redhat.com,
 sudeep.holla@arm.com, olof@lixom.net, shawnguo@kernel.org, davem@davemloft.net,
 bauerman@linux.ibm.com, dalias@libc.org, fenghua.yu@intel.com,
 peterz@infradead.org, dhowells@redhat.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, jolsa@redhat.com, svens@stackframe.org,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 naveen.n.rao@linux.vnet.ibm.com, paulmck@kernel.org, sfr@canb.auug.org.au,
 npiggin@gmail.com, namhyung@kernel.org, dvyukov@google.com, axboe@kernel.dk,
 monstr@monstr.eu, haolee.swjtu@gmail.com, linux-mips@vger.kernel.org,
 ink@jurassic.park.msu.ru, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Xiaoming Ni <nixiaoming@huawei.com> writes:

> Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
> sys_sysctl is actually unavailable: any input can only return an error.
>
> We have been warning about people using the sysctl system call for years
> and believe there are no more users.  Even if there are users of this
> interface if they have not complained or fixed their code by now they
> probably are not going to, so there is no point in warning them any
> longer.
>
> So completely remove sys_sysctl on all architectures.



>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>
> changes in v2:
>   According to Kees Cook's suggestion, completely remove sys_sysctl on all arch
>   According to Eric W. Biederman's suggestion, update the commit log
>
> V1: https://lore.kernel.org/lkml/1591683605-8585-1-git-send-email-nixiaoming@huawei.com/
>   Delete the code of sys_sysctl and return -ENOSYS directly at the function entry
> ---
>  include/uapi/linux/sysctl.h                        |  15 --
[snip]

> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index 27c1ed2..84b44c3 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -27,21 +27,6 @@
>  #include <linux/types.h>
>  #include <linux/compiler.h>
>  
> -#define CTL_MAXNAME 10		/* how many path components do we allow in a
> -				   call to sysctl?   In other words, what is
> -				   the largest acceptable value for the nlen
> -				   member of a struct __sysctl_args to have? */
> -
> -struct __sysctl_args {
> -	int __user *name;
> -	int nlen;
> -	void __user *oldval;
> -	size_t __user *oldlenp;
> -	void __user *newval;
> -	size_t newlen;
> -	unsigned long __unused[4];
> -};
> -
>  /* Define sysctl names first */
>  
>  /* Top-level names: */
[snip]

The uapi header change does not make sense.  The entire point of the
header is to allow userspace programs to be able to call sys_sysctl.
It either needs to all stay or all go.

As the concern with the uapi header is about userspace programs being
able to compile please leave the header for now.

We should leave auditing userspace and seeing if userspace code will
still compile if we remove this header for a separate patch.  The
concerns and justifications for the uapi header are completely different
then for the removing the sys_sysctl implementation.

Otherwise
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric
