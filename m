Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 13:12:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA53E206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 13:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA53E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YQ2R1LY7zDqjp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 23:11:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.233;
 helo=out03.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=xmission.com
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YPwt2t7PzDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 23:07:09 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out03.mta.xmission.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.90_1)
 (envelope-from <ebiederm@xmission.com>)
 id 1jeeiv-00076E-WD; Fri, 29 May 2020 07:06:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com) by in02.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1jeeiu-000531-Ok; Fri, 29 May 2020 07:06:57 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Luis Chamberlain <mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-13-mcgrof@kernel.org>
Date: Fri, 29 May 2020 08:03:02 -0500
In-Reply-To: <20200529074108.16928-13-mcgrof@kernel.org> (Luis Chamberlain's
 message of "Fri, 29 May 2020 07:41:07 +0000")
Message-ID: <878shasxkp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeeiu-000531-Ok; ; ; mid=<878shasxkp.fsf@x220.int.ebiederm.org>;
 ; ; hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/iLtuGsGMkvU0ljnm4/gjNHORnB+bZL0A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 12/13] sysctl: add helper to register empty subdir
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
Cc: jack@suse.cz, rafael@kernel.org, airlied@linux.ie, amir73il@gmail.com,
 clemens@ladisch.de, dri-devel@lists.freedesktop.org,
 joseph.qi@linux.alibaba.com, sfr@canb.auug.org.au, mark@fasheh.com,
 rdna@fb.com, yzaikin@google.com, joonas.lahtinen@linux.intel.com,
 keescook@chromium.org, arnd@arndb.de, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, julia.lawall@lip6.fr, viro@zeniv.linux.org.uk,
 rodrigo.vivi@intel.com, nixiaoming@huawei.com, vbabka@suse.cz, axboe@kernel.dk,
 tytso@mit.edu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com, jlbec@evilplan.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Luis Chamberlain <mcgrof@kernel.org> writes:

> The way to create a subdirectory from the base set of directories
> is a bit obscure, so provide a helper which makes this clear, and
> also helps remove boiler plate code required to do this work.

I agreee calling:
register_sysctl("fs/binfmt_misc", sysctl_mount_point)
is a bit obscure but if you are going to make a wrapper
please make it the trivial one liner above.

Say something that looks like:
	struct sysctl_header *register_sysctl_mount_point(const char *path)
        {
        	return register_sysctl(path, sysctl_mount_point);
        }

And yes please talk about a mount point and not an empty dir, as these
are permanently empty directories to serve as mount points.  There are
some subtle but important permission checks this allows in the case of
unprivileged mounts.

Further code like this belong in proc_sysctl.c next to all of the code
it is related to so that it is easier to see how to refactor the code if
necessary.

Eric

>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/sysctl.h |  7 +++++++
>  kernel/sysctl.c        | 16 +++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 33a471b56345..89c92390e6de 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -208,6 +208,8 @@ extern void register_sysctl_init(const char *path, struct ctl_table *table,
>  extern struct ctl_table_header *register_sysctl_subdir(const char *base,
>  						       const char *subdir,
>  						       struct ctl_table *table);
> +extern void register_sysctl_empty_subdir(const char *base, const char *subdir);
> +
>  void do_sysctl_args(void);
>  
>  extern int pwrsw_enabled;
> @@ -231,6 +233,11 @@ inline struct ctl_table_header *register_sysctl_subdir(const char *base,
>  	return NULL;
>  }
>  
> +static inline void register_sysctl_empty_subdir(const char *base,
> +						const char *subdir)
> +{
> +}
> +
>  static inline struct ctl_table_header *register_sysctl_paths(
>  			const struct ctl_path *path, struct ctl_table *table)
>  {
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f9a35325d5d5..460532cd5ac8 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3188,13 +3188,17 @@ struct ctl_table_header *register_sysctl_subdir(const char *base,
>  		{ }
>  	};
>  
> -	if (!table->procname)
> +	if (table != sysctl_mount_point && !table->procname)
>  		goto out;
>  
>  	hdr = register_sysctl_table(base_table);
>  	if (unlikely(!hdr)) {
> -		pr_err("failed when creating subdirectory sysctl %s/%s/%s\n",
> -		       base, subdir, table->procname);
> +		if (table != sysctl_mount_point)
> +			pr_err("failed when creating subdirectory sysctl %s/%s/%s\n",
> +			       base, subdir, table->procname);
> +		else
> +			pr_err("failed when creating empty subddirectory %s/%s\n",
> +			       base, subdir);
>  		goto out;
>  	}
>  	kmemleak_not_leak(hdr);
> @@ -3202,6 +3206,12 @@ struct ctl_table_header *register_sysctl_subdir(const char *base,
>  	return hdr;
>  }
>  EXPORT_SYMBOL_GPL(register_sysctl_subdir);
> +
> +void register_sysctl_empty_subdir(const char *base,
> +				  const char *subdir)
> +{
> +	register_sysctl_subdir(base, subdir, sysctl_mount_point);
> +}
>  #endif /* CONFIG_SYSCTL */
>  /*
>   * No sense putting this after each symbol definition, twice,
