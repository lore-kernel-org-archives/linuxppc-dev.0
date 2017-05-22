Return-Path: <srs0=zkj/=44=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWbCw2Mx0zDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 20:55:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wWbCw1lJdz8wT6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 20:55:24 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wWbCv5lHPz9s4q
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 20:55:23 +1000 (AEST)
Date: Mon, 22 May 2017 12:55:19 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Prarit Bhargava
 <prarit@redhat.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Ankit Kumar
 <ankit@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Mahesh J
 Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/fadump: update about offset where fadump is
 reserved
Message-ID: <20170522125519.158e9a68@kitsune.suse.cz>
In-Reply-To: <149544568763.16888.16656118217496342159.stgit@hbathini.in.ibm.com>
References: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
 <149544568763.16888.16656118217496342159.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 22 May 2017 15:04:47 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> With commit f6e6bedb7731 ("powerpc/fadump: Reserve memory at an offset
> closer to bottom of RAM"), memory for fadump is no longer reserved at
> the top of RAM. But there are still a few places which say so. Change
> them appropriately.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  Documentation/powerpc/firmware-assisted-dump.txt |    4 ++--
>  arch/powerpc/kernel/fadump.c                     |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
> b/Documentation/powerpc/firmware-assisted-dump.txt index
> 9cabaf8..bdd344a 100644 ---
> a/Documentation/powerpc/firmware-assisted-dump.txt +++
> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -61,8 +61,8 @@
> as follows: boot successfully. For syntax of crashkernel= parameter,
>           refer to Documentation/kdump/kdump.txt. If any offset is
>           provided in crashkernel= parameter, it will be ignored
> -         as fadump reserves memory at end of RAM for boot memory
> -         dump preservation in case of a crash.
> +         as fadump uses a predefined offset to reserve memory
> +         for boot memory dump preservation in case of a crash.

What is the reason for fadump to prefer a random offset calculated by
the kernel over a random offset supplied by the user?

Since the random offset calculated by the kernel was recently adjusted
to counter issues with fadump registration maybe it would be reasonable
to allow the user to supply a custom random offset and override the
kernel-calculated random offset if they want to do so.

PS 'random' meaning in no relationship to actual system topology that
would warrant this offset to be in any way better than any other.

Thanks

Michal
