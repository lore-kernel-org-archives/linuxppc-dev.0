Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F22811A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 10:39:29 +1100 (AEDT)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F6B714076E
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 10:39:29 +1100 (AEDT)
Received: by mail-pa0-x22a.google.com with SMTP id fy10so20944881pac.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 15:39:29 -0800 (PST)
Subject: Re: [PATCH 06/12] powerpc/module: Rework is_early_mcount_callsite()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-6-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE3F25.8030100@gmail.com>
Date: Thu, 25 Feb 2016 10:39:17 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-6-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25/02/16 01:28, Michael Ellerman wrote:
> is_early_mcount_callsite() needs to detect either the two instruction or
> the three instruction versions of the _mcount() sequence.
>
> But if we're running a kernel with the two instruction sequence, we need
> to be careful not to read instruction - 2, otherwise we might fall off
> the front of a page and cause an oops.
>
> While we're here convert to bool to make the return semantics clear.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/module_64.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> Squash.
>
>
Do we even need to do this anymore?

Balbir Singh.
