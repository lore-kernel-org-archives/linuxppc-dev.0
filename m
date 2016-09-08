Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVVYN5C4rzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 05:20:55 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u88JIVkh038556
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 15:20:52 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25bc2r6f34-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 15:20:52 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 8 Sep 2016 16:20:50 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5E8291DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 15:20:48 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u88JKmKW24117598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 16:20:48 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u88JKloR019386
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 16:20:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
Date: Thu, 08 Sep 2016 16:20:45 -0300
In-Reply-To: <871t0vlrlv.fsf@x220.int.ebiederm.org>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org> <871t0vlrlv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3106532.NfQxgDJQ20@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 07 September 2016, 09:19:40 schrieb Eric W. Biederman:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> Hello,
> >> 
> >> The purpose of this new version of the series is to fix a small issue
> >> that I found, which is that the kernel doesn't remove the memory
> >> reservation for the hand-over buffer it received from the previous
> >> kernel in the device tree it sets up for the next kernel. The result
> >> is that for each successive kexec, a stale hand-over buffer is left
> >> behind, wasting memory.
> >> 
> >> This is fixed by changes to kexec_free_handover_buffer and
> >> setup_handover_buffer in patch 2. The other change is to fix checkpatch
> >> warnings in the last patch.
> > 
> > This is fundamentally broken.  You do not increase the integrity of a
> > system by dropping integrity checks.
> > 
> > No. No. No. No.
> > 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

The IMA measurement list can be verified without the need of a checksum over 
its contents by replaying the PCR extend operations and checking that the 
result matches the registers in the TPM device. So the fact that it is not 
part of the kexec segments checksum verification doesn't actually reduce the 
integrity of the system.

Currently, IMA doesn't perform that verification when it restores the 
measurement list from the kexec handover buffer, so if you believe it's 
necessary to do that check at boot time, we could do one of the following:

1. Have IMA replay the PCR extend operations when it restores the 
measurement list from the handover buffer and validate it against the TPM 
PCRs, or

2. Have a buffer hash in the ima_kexec_hdr that IMA includes in the handover 
buffer, and verify the buffer checksum before restoring the measurement 
list.

What do you think?

> To be constructive the way we have handled similiar situations in the
> past (hotplu memory) is to call kexec_load again.

Thanks for your suggestion. Unfortunately it's always possible for new 
measurements to be added to the measurement list between the kexec_file_load 
and the reboot. We see that happen in practice with system scripts and 
configuration files that are only read or executed during the reboot 
process. They are only measured by IMA as a result of the kexec execute.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
