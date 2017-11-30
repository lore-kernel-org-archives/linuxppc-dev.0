Return-Path: <srs0=f6o4=c4=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynbGk5tp5zDqpl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 22:46:54 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ynbGk5KNLz8t9s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 22:46:54 +1100 (AEDT)
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ynbGk0v6Zz9t6n
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2017 22:46:53 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id w47so5524463uah.3
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2017 03:46:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151203273555.16587.12957613472048945542.stgit@jupiter.in.ibm.com>
References: <151203273555.16587.12957613472048945542.stgit@jupiter.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 30 Nov 2017 22:46:51 +1100
Message-ID: <CAKTCnz=xS87Gp3g5ThThq1_m-kahOZx+9ZuJcdU7eZY87j1i6g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/radix: Remove trace_tlbie call from
 radix__flush_tlb_all
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 30, 2017 at 8:05 PM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> radix__flush_tlb_all() is called only in kexec path in real mode and any
> tracepoints at this stage will make kexec to fail if enabled.
>
> To verify enable tlbie trace before kexec.
>
> $ echo 1 > /sys/kernel/debug/tracing/events/powerpc/tlbie/enable
> == kexec into new kernel and kexec fails.
>
> Fix this by not calling trace_tlbie from radix__flush_tlb_all().
>
> Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
