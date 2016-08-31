Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPgK93KKNzDrn7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 08:38:37 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7VMahtZ066828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 18:38:34 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2561d1jmy9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 18:38:34 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 04:08:30 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9CE8AE0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 04:07:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7VMcCZt24379618
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 04:08:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7VMcAgn001679
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 04:08:11 +0530
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Date: Wed, 31 Aug 2016 18:38:06 -0400
In-Reply-To: <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1472683086.2607.17.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
> On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > of the running kernel must be saved and then restored on the subsequent
> > boot, possibly of a different architecture.
> > 
> > The existing securityfs binary_runtime_measurements file conveniently
> > provides a serialized format of the IMA measurement list. This patch
> > set serializes the measurement list in this format and restores it.
> > 
> > Up to now, the binary_runtime_measurements was defined as architecture
> > native format.  The assumption being that userspace could and would
> > handle any architecture conversions.  With the ability of carrying the
> > measurement list across kexec, possibly from one architecture to a
> > different one, the per boot architecture information is lost and with it
> > the ability of recalculating the template digest hash.  To resolve this
> > problem, without breaking the existing ABI, this patch set introduces
> > the boot command line option "ima_canonical_fmt", which is arbitrarily
> > defined as little endian.
> > 
> > The need for this boot command line option will be limited to the
> > existing version 1 format of the binary_runtime_measurements.
> > Subsequent formats will be defined as canonical format (eg. TPM 2.0
> > support for larger digests).
> > 
> > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> > hand-over for the next kernel" patch set. 
> > 
> > These patches can also be found in the next-kexec-restore branch of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> 
> I'll merge these into -mm to get some linux-next exposure.  I don't
> know what your upstream merge plans will be?

Sounds good.  I'm hoping to get some review/comments on this patch set
as well.  At the moment, I'm chasing down a kernel test robot report
from this afternoon.

Mimi
