Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF7C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:17:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409421900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pKk8vaqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409421900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qyhh6M4KzDqVN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 09:17:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="pKk8vaqm"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qydl3Fx6zDqVP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 09:15:23 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id z124so5773143itc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NxtbMONzoE1s3tzmii8qj/NkqDi2oTH0iJ5EH+lwhzs=;
 b=pKk8vaqmEOWE7wmsQsAlpVqHxGSGlzdO18CvseUDa6Gqg3ToKg6HC+d6WIlSijUcfE
 eqZis0vwDECjehXasWtExjdgpfVBq/hrPtiOoQQSKzK3TjOl/nTT+9YmHvwUR+PM7IA4
 SOb/KicPs2Y3XnvO+puWR7yKpWhSgZFJhnJ6r4/irdDupSuupBFv6JOsvwLkAcOJVCvc
 /c6q0yBJIunL/GfMeaZCvO2zo7Le+40UBax9xxx16S5aZ0WDQh3P5CgePOvXOOBPFbgz
 HBnYydx8J6DIC1a5uoC8HcWUFBhtiH/ArOQmUpRQZYjiW5VzQldKh5YBRfOuJhQ/9xvp
 6L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NxtbMONzoE1s3tzmii8qj/NkqDi2oTH0iJ5EH+lwhzs=;
 b=nphR/Oy+L6jcqWC9Qblgt4n/iUtAkQTOLlnlMK6xXDTy6s/CzG+/+77xl3FfLKesix
 DtOypyRY1vI+y3xCQh9aIbINtaPSnSKCrzLfz7Hpa5PeN6iRfym5UBgbJDHhH6wQaolo
 OGOcskCOPo0TwG85YT3QUBOBHyApIYFIia+eI2l6TVFxdoTAdcC495bNh60yu4VJRlw6
 I/PAG1cKOHMfqqV1tPosbLFV3e/h8mh0xEZ1lL0oe5lU2rBfRln5w8e50Ulxi1F1nmaE
 Oro1ppdybSxRSFrVV3wKVRMzEmcYifvWVvPJBE3erGSxwP7Ye/GMTmUfII4aGWSDYirE
 yK+g==
X-Gm-Message-State: APjAAAXBmjCravdHmOuFV2ajF0wCyXJxA82Z5VTsWxoVVh0T0IavRm6X
 NMZ/2EMLXOKLW9X7cmzhlqCp26XUEGNuQQ4rxZs=
X-Google-Smtp-Source: APXvYqziYcin9TkCNIVMFnILirct4rYKpjMxOpZQfFl5u+ozFqvpcOi02iZydMgVTL758Vu3P43GvK0tXOYXgqNrS/o=
X-Received: by 2002:a24:298b:: with SMTP id p133mr3587931itp.43.1553292921652; 
 Fri, 22 Mar 2019 15:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-7-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-7-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Mar 2019 15:15:10 -0700
Message-ID: <CAA9_cmdDxh1ZYn1fO+ED1crzDMCPWk0fLjNPfxkFKUb5kNHgxA@mail.gmail.com>
Subject: Re: [RESEND 6/7] IB/qib: Use the new FOLL_LONGTERM flag to
 get_user_pages_fast()
To: ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Use the new FOLL_LONGTERM to get_user_pages_fast() to protect against
> FS DAX pages being mapped.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good modulo potential  __get_user_pages_fast() suggestion.
