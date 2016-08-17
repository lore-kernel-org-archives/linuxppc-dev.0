Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDcT32Q0LzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 14:59:03 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H4rxP7133907
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 00:59:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24va4w64hs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 00:59:00 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 01:58:58 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8E85C1DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 00:58:46 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H4wtKo8126932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 01:58:55 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H4wstx028333
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 01:58:55 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ima-devel@lists.sourceforge.net,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@aculab.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] kexec_file: Add buffer hand-over for the next
 kernel
Date: Wed, 17 Aug 2016 01:58:51 -0300
In-Reply-To: <20160817025226.GA4638@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160817025226.GA4638@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <7590280.XAE4qXVcVR@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dave,

Am Mittwoch, 17 August 2016, 10:52:26 schrieb Dave Young:
> On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > This series applies on top of v5 of the "kexec_file_load implementation
> > for PowerPC" patch series (which applies on top of v4.8-rc1):
> > 
> > https://lists.infradead.org/pipermail/kexec/2016-August/016843.html
> 
> I'm trying to review your patches, but seems I can not apply them
> cleanly to mainline kernel or v4.8-rc1

Strange, I just did a test using the patches I received via the kexec 
mailing list, and git am applied them cleanly on v4.8-rc1.

> Apply the kexec_file_load series failed as below on v4.8-rc1:
> 
> Applying: kexec_file: Allow arch-specific memory walking for
> kexec_add_buffer
> error: patch failed: include/linux/kexec.h:149
> error: include/linux/kexec.h: patch does not apply
> Patch failed at 0001 kexec_file: Allow arch-specific memory walking for
> kexec_add_buffer
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> What is the order of your patch series of the three patchset?
> 
> [PATCH v2 0/2] extend kexec_file_load system call
> [PATCH v5 00/13] kexec_file_load implementation for PowerPC
> [PATCH v2 0/6] kexec_file: Add buffer hand-over for the next kernel

Yes, that is correct.

> Do they depend on other patches?

No, they apply directly on v4.8-rc1.

I just published a branch with the patches, if you want you can use that 
instead. The branch is called kexec-patches and is at the repo 
git@github.com:bauermann/linux

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
