Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSybt35c2zDvvn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 09:18:02 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tSybs4wG3z9t1Q
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 09:18:01 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uATMENRw084255
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 17:17:59 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 271e97vvq0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 17:17:59 -0500
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 20:17:57 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A8CA61DC006D
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 17:17:55 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uATMHtTV35586214
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 20:17:55 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uATMHtxr025021
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 20:17:55 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
Date: Tue, 29 Nov 2016 20:17:48 -0200
In-Reply-To: <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
 <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2422829.EXrxmyBIVd@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andrew,

Am Dienstag, 29. November 2016, 13:45:18 BRST schrieb Andrew Morton:
> On Tue, 29 Nov 2016 23:45:46 +1100 Michael Ellerman <mpe@ellerman.id.au> 
wrote:
> > This is v11 of the kexec_file_load() for powerpc series.
> > 
> > I've stripped this down to the minimum we need, so we can get this in for
> > 4.10. Any additions can come later incrementally.
> 
> This made a bit of a mess of Mimi's series "ima: carry the
> measurement list across kexec v10".
> 
> powerpc-ima-get-the-kexec-buffer-passed-by-the-previous-kernel.patch
> ima-on-soft-reboot-restore-the-measurement-list.patch
> ima-permit-duplicate-measurement-list-entries.patch
> ima-maintain-memory-size-needed-for-serializing-the-measurement-list.patch
> powerpc-ima-send-the-kexec-buffer-to-the-next-kernel.patch
> ima-on-soft-reboot-save-the-measurement-list.patch
> ima-store-the-builtin-custom-template-definitions-in-a-list.patch
> ima-support-restoring-multiple-template-formats.patch
> ima-define-a-canonical-binary_runtime_measurements-list-format.patch
> ima-platform-independent-hash-value.patch
> 
> I made the syntactic fixes but I won't be testing it.

Sorry about that. We are preparing an updated version rebased on Michael's 
patches to address that.

Just to explain where v11 is coming from:

kexec_file_load v11 uses a minimal purgatory taken from kexec-lite, resulting 
in a purgatory object without relocations. This avoids the problem of having 
to have a lot of code to process purgatory relocations, which is the problem I 
was trying to address in the past couple versions of this patch series.

The new purgatory also doesn't need the kernel to set global variables to tell 
it where the stack, TOC and OPAL entrypoint are, so that code was dropped from 
setup_purgatory.

The other change was to move the code in elf_util.[ch] into kexec_elf_64.c, 
with no actual code change.

> > If no one objects I'll merge this via the powerpc tree. The three kexec
> > patches have been acked by Dave Young (since forever), and have been in
> > linux-next (via akpm's tree) also for a long time.
> 
> OK, I'll wait for these to appear in -next and I will await advice on

Mimi and I would like to thank you for your support and help with these 
patches, Andrew.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
