Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A090ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3B1206B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3B1206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gJD25JsYzF3Cs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 05:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gJB54srpzDrM9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 05:07:05 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FC6F3097042;
 Wed, 24 Oct 2018 18:07:03 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-91.ams2.redhat.com
 [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFB1607A1;
 Wed, 24 Oct 2018 18:07:01 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Michael Sammler <msammler@mpi-sws.org>
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
References: <20181024153523.10974-1-msammler@mpi-sws.org>
Date: Wed, 24 Oct 2018 20:06:59 +0200
In-Reply-To: <20181024153523.10974-1-msammler@mpi-sws.org> (Michael Sammler's
 message of "Wed, 24 Oct 2018 17:35:23 +0200")
Message-ID: <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 24 Oct 2018 18:07:03 +0000 (UTC)
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
Cc: Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>,
 linux-api@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Michael Sammler:

> Add the current value of the PKRU register to data available for
> seccomp-bpf programs to work on. This allows filters based on the
> currently enabled protection keys.

> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 9efc0e73..e8b9ecfc 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -52,12 +52,16 @@
>   * @instruction_pointer: at the time of the system call.
>   * @args: up to 6 system call arguments always stored as 64-bit values
>   *        regardless of the architecture.
> + * @pkru: value of the pkru register
> + * @reserved: pad the structure to a multiple of eight bytes
>   */
>  struct seccomp_data {
>  	int nr;
>  	__u32 arch;
>  	__u64 instruction_pointer;
>  	__u64 args[6];
> +	__u32 pkru;
> +	__u32 reserved;
>  };

This doesn't cover the POWER implementation.  Adding Cc:s.

And I think the kernel shouldn't expose the number of protection keys in
the ABI.

Thanks,
Florian
