Return-Path: <zohar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTLGT2LTbzDvJD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 00:04:17 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTLGS5lcrz9t2g
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2016 00:04:16 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUD43BG071450
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 08:04:15 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 271u566uy0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 08:04:10 -0500
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 18:34:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 437773940060
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 18:34:01 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUD40qH26148936
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 18:34:00 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUD3vJ0010111
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 18:34:00 +0530
Subject: Re: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com
Date: Wed, 30 Nov 2016 08:03:46 -0500
In-Reply-To: <87inr5po0n.fsf@concordia.ellerman.id.au>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
 <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
 <87inr5po0n.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1480511026.18110.102.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-30 at 15:52 +1100, Michael Ellerman wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Tue, 29 Nov 2016 23:45:46 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >> This is v11 of the kexec_file_load() for powerpc series.
> >> 
> >> I've stripped this down to the minimum we need, so we can get this in for 4.10.
> >> Any additions can come later incrementally.
> >
> > This made a bit of a mess of Mimi's series "ima: carry the
> > measurement list across kexec v10".
> 
> Urk, sorry about that. I didn't realise there was a big dependency
> between them, but I guess I should have tried to do the rebase.
> 
> > powerpc-ima-get-the-kexec-buffer-passed-by-the-previous-kernel.patch
> > ima-on-soft-reboot-restore-the-measurement-list.patch
> > ima-permit-duplicate-measurement-list-entries.patch
> > ima-maintain-memory-size-needed-for-serializing-the-measurement-list.patch
> > powerpc-ima-send-the-kexec-buffer-to-the-next-kernel.patch
> > ima-on-soft-reboot-save-the-measurement-list.patch
> > ima-store-the-builtin-custom-template-definitions-in-a-list.patch
> > ima-support-restoring-multiple-template-formats.patch
> > ima-define-a-canonical-binary_runtime_measurements-list-format.patch
> > ima-platform-independent-hash-value.patch
> >
> > I made the syntactic fixes but I won't be testing it.

Dmitry Kasatkin's acked-by needs to be included for the IMA patches.

> Thanks. 
> 
> TBH I don't know how to test the IMA part, I'm relying on Thiago and
> Mimi to do that.

It should be straight forward.  Enable CONFIG_IMA_KEXEC to carry the
measurements from one kernel to the next.  Use a kexec_file_load version
of kexec to boot the next kernel.  On the boot command line add
"ima_tcb" or "ima_policy=ima_tcb".

If the measurements were carried across kexec, the IMA measurement list
<securityfs>/ima/ascii_runtime_measurements should contain an initial
"boot_aggregate", as the first record, and a "boot_aggregate", as a
delimiter, for each subsequent kexec.

> >> If no one objects I'll merge this via the powerpc tree. The three kexec patches
> >> have been acked by Dave Young (since forever), and have been in linux-next (via
> >> akpm's tree) also for a long time.
> >
> > OK, I'll wait for these to appear in -next and I will await advice on 
> 
> Thanks. I'll let them stew for a few more hours and then put them in my
> next for tomorrows linux-next.

Thaigo tested the patches yesterday.   Everything seemed fine.  After
cherry picking the kexec_file_load() patches and rebasing the
restore_kexec patches on top of it in my tree, there were some problems.
Perhaps there is some dependencies that I'm missing.

Mimi
