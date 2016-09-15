Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZjQf56GCzDsXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 01:44:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FFhGJG138106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:44:40 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fr7bwhff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:44:40 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:14:36 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4E9F31258026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:14:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FFiR5c22544580
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:14:27 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FFiUFV021992
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:14:33 +0530
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Sep 2016 11:44:23 -0400
In-Reply-To: <1472683086.2607.17.camel@linux.vnet.ibm.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
 <1472683086.2607.17.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1473954263.2526.88.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Wed, 2016-08-31 at 18:38 -0400, Mimi Zohar wrote:
> On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
> > On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > 
> > > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > > of the running kernel must be saved and then restored on the subsequent
> > > boot, possibly of a different architecture.
> > > 
> > > The existing securityfs binary_runtime_measurements file conveniently
> > > provides a serialized format of the IMA measurement list. This patch
> > > set serializes the measurement list in this format and restores it.
> > > 
> > > Up to now, the binary_runtime_measurements was defined as architecture
> > > native format.  The assumption being that userspace could and would
> > > handle any architecture conversions.  With the ability of carrying the
> > > measurement list across kexec, possibly from one architecture to a
> > > different one, the per boot architecture information is lost and with it
> > > the ability of recalculating the template digest hash.  To resolve this
> > > problem, without breaking the existing ABI, this patch set introduces
> > > the boot command line option "ima_canonical_fmt", which is arbitrarily
> > > defined as little endian.
> > > 
> > > The need for this boot command line option will be limited to the
> > > existing version 1 format of the binary_runtime_measurements.
> > > Subsequent formats will be defined as canonical format (eg. TPM 2.0
> > > support for larger digests).
> > > 
> > > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> > > hand-over for the next kernel" patch set. 
> > > 
> > > These patches can also be found in the next-kexec-restore branch of:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > 
> > I'll merge these into -mm to get some linux-next exposure.  I don't
> > know what your upstream merge plans will be?
> 
> Sounds good.  I'm hoping to get some review/comments on this patch set
> as well.  At the moment, I'm chasing down a kernel test robot report
> from this afternoon.

My concern about changing the canonical format as originally defined in
patch 9/9 from big endian to little endian never materialized.  Andreas
Steffan, the patch author, is happy either way.

We proposed two methods of addressing Eric Biederman's concerns of not
including the IMA measurement list segment in the kexec hash as
described in  https://lkml.org/lkml/2016/9/9/355.

- defer calculating and verifying the serialized IMA measurement list
buffer hash to IMA
- calculate the kexec hash on load, verify it on the kexec execute,
before re-calculating and updating it.

We implemented both options, which can be found in the
next-kexec-restore.with-ima-checksum and next-kexec-restore branches of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Thiago's patches posted yesterday and mine posted this morning are based
on kexec doing the hashing (the second option).

Lastly, we've addressed the automated kernel build and runtime bug
reports.

Since the IMA patches are dependent on the kexec ones, the two patch
sets need to be upstreamed together.  How should we proceed?   Should
they be upstreamed through your tree?

Mimi
