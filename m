Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbWmj58jpzDsdn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Sep 2016 09:33:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GNX7AR081804
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:33:07 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25gq68xbew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:33:07 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 16 Sep 2016 20:33:04 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2B9231DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:33:03 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8GNX3nD5058676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:33:03 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8GNX2nW004757
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:33:02 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Date: Fri, 16 Sep 2016 20:32:58 -0300
In-Reply-To: <87lgyrsk3i.fsf@x220.int.ebiederm.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1473954263.2526.88.camel@linux.vnet.ibm.com>
 <87lgyrsk3i.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2097581.F8Sg9EkmE6@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Eric,

Am Freitag, 16 September 2016, 14:47:13 schrieb Eric W. Biederman:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > Hi Andrew,
> > 
> > On Wed, 2016-08-31 at 18:38 -0400, Mimi Zohar wrote:
> >> On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
> >> > On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar 
<zohar@linux.vnet.ibm.com> wrote:
> >> > > The TPM PCRs are only reset on a hard reboot.  In order to validate
> >> > > a
> >> > > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement
> >> > > list
> >> > > of the running kernel must be saved and then restored on the
> >> > > subsequent
> >> > > boot, possibly of a different architecture.
> >> > > 
> >> > > The existing securityfs binary_runtime_measurements file
> >> > > conveniently
> >> > > provides a serialized format of the IMA measurement list. This
> >> > > patch
> >> > > set serializes the measurement list in this format and restores it.
> >> > > 
> >> > > Up to now, the binary_runtime_measurements was defined as
> >> > > architecture
> >> > > native format.  The assumption being that userspace could and would
> >> > > handle any architecture conversions.  With the ability of carrying
> >> > > the
> >> > > measurement list across kexec, possibly from one architecture to a
> >> > > different one, the per boot architecture information is lost and
> >> > > with it
> >> > > the ability of recalculating the template digest hash.  To resolve
> >> > > this
> >> > > problem, without breaking the existing ABI, this patch set
> >> > > introduces
> >> > > the boot command line option "ima_canonical_fmt", which is
> >> > > arbitrarily
> >> > > defined as little endian.
> >> > > 
> >> > > The need for this boot command line option will be limited to the
> >> > > existing version 1 format of the binary_runtime_measurements.
> >> > > Subsequent formats will be defined as canonical format (eg. TPM 2.0
> >> > > support for larger digests).
> >> > > 
> >> > > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> >> > > hand-over for the next kernel" patch set.
> >> > > 
> >> > > These patches can also be found in the next-kexec-restore branch
> >> > > of:
> >> > > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> >> > > .git
> >> > 
> >> > I'll merge these into -mm to get some linux-next exposure.  I don't
> >> > know what your upstream merge plans will be?
> >> 
> >> Sounds good.  I'm hoping to get some review/comments on this patch set
> >> as well.  At the moment, I'm chasing down a kernel test robot report
> >> from this afternoon.
> > 
> > My concern about changing the canonical format as originally defined in
> > patch 9/9 from big endian to little endian never materialized.  Andreas
> > Steffan, the patch author, is happy either way.
> > 
> > We proposed two methods of addressing Eric Biederman's concerns of not
> > including the IMA measurement list segment in the kexec hash as
> > described in  https://lkml.org/lkml/2016/9/9/355.
> > 
> > - defer calculating and verifying the serialized IMA measurement list
> > buffer hash to IMA
> > - calculate the kexec hash on load, verify it on the kexec execute,
> > before re-calculating and updating it.
> 
> I need to ask: How this is anticipated to interact with kexec on panic?
> Because honestly I can't see this ever working in that case.  The
> assumption is that the original kernel has gone crazy.  So from a
> practical standpoint any trusted path should have been invalided.

We are not interested in carrying the measurement list in the case of kexec 
on panic. I see that the code is adding a hand-over buffer to the crash 
image as well, but that is a bug.

The fix is to do nothing in ima_add_kexec_buffer if image->type != 
KEXEC_TYPE_DEFAULT.
 
> This entire idea of updating the kexec image makes me extremely
> extremely nervious.  It feels like sticking a screw driver through the
> spokes of your bicicle tires while ridding down the road.
> 
> I can see tracking to see if the list has changed at some
> point and causing a reboot(LINUX_REBOOT_CMD_KEXEC) to fail.

Yes, that is an interesting feature that I can add using the checksum-
verifying part of my code. I can submit a patch for that if there's 
interest, adding a reboot notifier that verifies the checksum and causes a 
regular reboot instead of a kexec reboot if the checksum fails.

> At least the common bootloader cases that I know of using kexec are very
> minimal distributions that live in a ramdisk and as such it should be
> very straight forward to measure what is needed at or before
> sys_kexec_load.  But that was completely dismissed as unrealistic so I
> don't have a clue what actual problem you are trying to solve.

We are interested in solving the problem in a general way because it will be 
useful to us in the future for the case of an arbitrary number of kexecs 
(and thus not only a bootloader but also multiple full-blown distros may be 
involved in the chain).

But you are right that for the use case for which we currently need this 
feature it's feasible to measure everything upfront. We can cross the other 
bridge when we get there.

> If there is anyway we can start small and not with this big scary
> infrastructure change I would very much prefer it.

Sounds good. If we pre-measure everything then the following patches from my 
buffer hand-over series are enough:

[PATCH v5 2/5] kexec_file: Add buffer hand-over support for the next kernel
[PATCH v5 3/5] powerpc: kexec_file: Add buffer hand-over support for the 
next kernel

Would you consider including those two?

And like I mentioned in the cover letter, patch 1/5 is an interesting 
improvement that is worth considering.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
