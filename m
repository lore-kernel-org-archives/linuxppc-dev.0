Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 800391A0363
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:37:40 +1100 (AEDT)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EED31140213
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 14:37:39 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id q6so6998138pav.0
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 19:37:39 -0800 (PST)
Subject: Re: [PATCH 1/2] ppc64le live patch: clear out storage location(s) in
 mini stack frame
To: Torsten Duwe <duwe@lst.de>, Petr Mladek <pmladek@suse.com>
References: <20160309172821.GC27913@lst.de>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56E23D7A.4040903@gmail.com>
Date: Fri, 11 Mar 2016 14:37:30 +1100
MIME-Version: 1.0
In-Reply-To: <20160309172821.GC27913@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/03/16 04:28, Torsten Duwe wrote:
> This can be applied on top of Petr Mladek's v4 rework of the ppc64le
> live patching. Inspired by Balbir Singh's v5, information about the
> callee's r2 is stored in a "reserved" 32 bit location in the caller's
> stack frame, instead of 64 bits in the newly created mini frame 24(r1).
>
> It only needs to work for a local call, when caller's TOC == callee's
> TOC, and along with the return address (LR) it's all within a 4GiB
> range (+-31 bits). If the original call already was global, we are
> allowed to restore any nonsense into r2, because the global caller
> will restore its TOC anyway from the ABI compliant location 24(r1)
> right after return.
>
>
Hi, Torsten

Sorry, I've had no time to test this. Caught up with something else for the moment.
Hopefully I'll get a chance over the weekend.

Have you tested this against Petr's sample changes to patch printk?

Balbir Singh.
