Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425161A0806
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 11:39:06 +1100 (AEDT)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F77A140F93
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2015 11:39:05 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 9 Dec 2015 19:39:02 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0AA0138C804F
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2015 19:39:00 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBA0d0wO26804476
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2015 00:39:00 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBA0cwAn020312
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Dec 2015 19:38:59 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Add script to test HMI functionality
In-Reply-To: <87h9jrxkg0.fsf@gamma.ozlabs.ibm.com>
References: <1447821827-17876-1-git-send-email-dja@axtens.net>
 <CAOJe8K3xJ_Difk5aLJT=Jpz-f8tJfQx=9GE6=78FjRiqw4qHvA@mail.gmail.com>
 <87h9jrxkg0.fsf@gamma.ozlabs.ibm.com>
Date: Thu, 10 Dec 2015 11:38:47 +1100
Message-ID: <87vb87b0iw.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:
> I just realised I sent my reply to Denis not the list - apologies. This
> info goes for v2 as well.
>
>   > Could you explain why it's useful, and what it's useful for. Moreover,
>   > it's POWER8 feature, right?
>
>   I'm not sure whether you're asking about the script or HMIs. Explaining
>   HMIs helps make sense of the script, so I'll start there.
>
>   HMIs are a class of interrupt or exception that, broadly speaking,
>   require the hypervisor to intervene to 'do something'. They are (very
>   lightly) documented in the POWER ISA, which is available on the
>   OpenPOWER website. That file doesn't do a particuarly good job of
>   explaining what can trigger an HMI, because that's a Book IV question.
>
>   So, while I can't point you to documentation about what might cause an
>   HMI, I can point you to some source code. Here goes:
>
>   An HMI will (per the ISA) cause execution to jump to
>   0x0000 0000 0000 0E60. Through some asm and C you end up calling
>   ppc_md.hmi_exception_early() and then possibly
>   ppc_md.handle_hmi_expection(). This is only defined on PowerNV, where
>   they point to opal_hmi_exception_early() and
>   opal_handle_hmi_exception() respectively.
>
>   The early exception calls into opal through opal_handle_hmi, which is an
>   OPAL call (OPAL_HANDLE_HMI). skiboot/core/hmi.c lists the contents of
>   the HMER (Hypervisor Maintenance Exception Register), which identifies
>   the actual cause of the HMI. You can find the list in the skiboot repo
>   on github, including the action that will be taken:
>   https://github.com/open-power/skiboot/blob/master/core/hmi.c
>   The rest of the file fleshes out the mechanics of HMIs: for example,
>   where they are caused by the failure of a POWER8 co-processor such as
>   CAPI or NX.
>
>   Some HMIs are relayed by Skiboot to Linux by sending an OPAL_MSG_HMI_EVT
>   to Linux. This triggers off some further processing which causes a
>   message to be printed in dmesg. The relevant file here is
>   platforms/powernv/opal-hmi.c
>
>   The script, therefore, is useful because:
>    - HMIs are an exceptional/error condition that is not hit in normal
>      operation. Indeed, without the xscom commands in this script
>      (or a CAPI card), it's almost impossible to hit them.
>    - HMIs involve communications between Skiboot and Linux, involve
>      touching the PACA, and generally work in an area that is prone to
>      bugs, so testing them is especially valuable.
>    - The script is carefully calibrated to send HMIs that trigger a
>      message in dmesg but which don't checkstop the machine.
>
>   To answer your final question, I'm not entirely sure if HMIs are POWER8
>   specific. I suspect they've been around for a lot longer, but maybe
>   someone who's been around IBM chips for longer than me could clarify this.

Adding this to doc/ somewhere in kernel and/or skiboot would be
great. There's a skiboot doc/hmi.txt that's begging for a patch, you
know, creating it :)
