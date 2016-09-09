Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVyFV1xXpzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 23:08:45 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u89D3Ow0046722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 09:08:44 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25bc36j825-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Sep 2016 09:08:43 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 9 Sep 2016 23:08:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 949263578058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 23:08:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u89D8d7w53674108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 23:08:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u89D8cJp028149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 23:08:39 +1000
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal
 <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Stewart Smith <stewart@linux.vnet.ibm.com>, Eric
 Richter <erichte@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh <bsingharora@gmail.com>
Date: Fri, 09 Sep 2016 09:08:33 -0400
In-Reply-To: <87k2elhg22.fsf@x220.int.ebiederm.org>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org>
 <871t0vlrlv.fsf@x220.int.ebiederm.org> <3106532.NfQxgDJQ20@hactar>
 <87k2elhg22.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1473426513.2926.246.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-09-08 at 23:07 -0500, Eric W. Biederman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > Am Mittwoch, 07 September 2016, 09:19:40 schrieb Eric W. Biederman:
> >> ebiederm@xmission.com (Eric W. Biederman) writes:
> >> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> >> Hello,
> >> >> 
> >> >> The purpose of this new version of the series is to fix a small issue
> >> >> that I found, which is that the kernel doesn't remove the memory
> >> >> reservation for the hand-over buffer it received from the previous
> >> >> kernel in the device tree it sets up for the next kernel. The result
> >> >> is that for each successive kexec, a stale hand-over buffer is left
> >> >> behind, wasting memory.
> >> >> 
> >> >> This is fixed by changes to kexec_free_handover_buffer and
> >> >> setup_handover_buffer in patch 2. The other change is to fix checkpatch
> >> >> warnings in the last patch.
> >> > 
> >> > This is fundamentally broken.  You do not increase the integrity of a
> >> > system by dropping integrity checks.
> >> > 
> >> > No. No. No. No.
> >> > 
> >> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > The IMA measurement list can be verified without the need of a checksum over 
> > its contents by replaying the PCR extend operations and checking that the 
> > result matches the registers in the TPM device. So the fact that it is not 
> > part of the kexec segments checksum verification doesn't actually reduce the 
> > integrity of the system.
> 
> Bit flips and errant DMA transfers are the concern here.  That happens
> routinely and can easily result in a corrupt data structure which may be
> non-trivial to verify.

Point taken.  Before using the measurement list, the hash needs to be
verified.  So then the question is when and where that hash should be
taken and included.

New measurements can take place between the kexec load and execute.
Those measurements would be included in an additional execute of kexec
load, as you suggested. There are additional new measurements that are
the result of the kexec execute itself, as Thiago pointed out.  Having
to know a priori what those measurements are, or should be, makes
carrying the measurement list across kexec brittle.

One solution, as suggested by Thiago, would be to calculate the
measurement list hash, include the hash in the ima_kexec_hdr and verify
the hash, before restoring the measurement list.  Another option would
be to calculate the image hash on kexec load either with  a zero filled
measurement list segment or without the segment, verify the image hash
on kexec execute, before re-calculating the image hash.

> > Currently, IMA doesn't perform that verification when it restores the 
> > measurement list from the kexec handover buffer, so if you believe it's 
> > necessary to do that check at boot time, we could do one of the following:
> >
> > 1. Have IMA replay the PCR extend operations when it restores the 
> > measurement list from the handover buffer and validate it against the TPM 
> > PCRs, or
> >
> > 2. Have a buffer hash in the ima_kexec_hdr that IMA includes in the handover 
> > buffer, and verify the buffer checksum before restoring the measurement 
> > list.
> >
> > What do you think?
> 
> I think you are playing very much with fire and I am extremely
> uncomfortable with the entire concept.  I think you are making things
> more complicated in a way that will allow system to try and start
> booting when their memory is correct.  Which may wind up corrupting
> someones non-volatile storage.

Everything that was previously included in the image hash, before this
proposed patch set, is still included in the image hash.

Lets assume  for a moment that the measurement list hash is stored in
the ima_kexec_hdr.  In addition to preventing the measurement list from
being restored, we could either allow the reboot without the measurement
list to occur or halt the system.

Rebooting without the measurement list would result in the attestation
of the system failing.

> It makes me doubly nervous that this adds a general purpose facility
> that is generally not at all reusable.

Thiago has already agreed to reverting the skip hash bit. 

> I have seen malicious actors cause entirely too much damage to be at all
> comfortable using a data structure before we validate that it was valid
> before we started booting.  This isn't the same case but it is close
> enough I don't trust someone just splatting data structures.
> We can't guarantee integrity but we should not bypass best practices
> either.
> 
> >> To be constructive the way we have handled similiar situations in the
> >> past (hotplu memory) is to call kexec_load again.
> >
> > Thanks for your suggestion. Unfortunately it's always possible for new 
> > measurements to be added to the measurement list between the kexec_file_load 
> > and the reboot. We see that happen in practice with system scripts and 
> > configuration files that are only read or executed during the reboot 
> > process. They are only measured by IMA as a result of the kexec execute.
> 
> If I understand what you are saying correctly I expect things could be
> setup so that those measurements are forced to happen before kexec load.

> Especially in a boot loader context which you described earlier I
> believe you should have quite a lot of control of the system.  Having a
> facility that fundamentally undermines the design of kexec for a case
> where someone might do something you have not predicted does not make me
> comfortable.
> 
> Which is to say I don't see why you can't measure things before the
> kexec_load system call in a tightly controlled setup like a boot loader.
> Which should make it that in practice no measurements change.  I believe
> that should increase the reliability of the system overall.

Either we measure everything possible, making the measurement list
unnecessarily large, or have a brittle system that could break the
attestation of the target system, if any packages add new files/scripts
that are accessed on a soft reboot.

> Having code in the kernel that updates a buffer that kexec will use
> after that buffer is loaded in memory honestely gives me the heebie
> jeebies.

To address your understandable concerns, we suggested two possible
solutions for including and verifying the measurement list hash.
- calculate the image hash on load, verify it on kexec reload, before
recalculating the image hash with the measurement list segment.
- defer hashing and verifying the measurement list hash to IMA.

Mimi
