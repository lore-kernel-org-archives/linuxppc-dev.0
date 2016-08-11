Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s95LG5TyszDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:25:58 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BBOTwK077253
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 07:25:56 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24rqx11vu7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 07:25:56 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 16:55:51 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C5B64E0069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 17:00:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BBPiFa15532032
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:55:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BBPfNA003388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:55:43 +0530
Subject: Re: [PATCH 0/7] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Date: Thu, 11 Aug 2016 07:25:36 -0400
In-Reply-To: <46d115a8-de96-1e9f-9d08-b0e9b6cca93a@gmail.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
 <1470746204.2881.101.camel@linux.vnet.ibm.com>
 <46d115a8-de96-1e9f-9d08-b0e9b6cca93a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470914736.10123.34.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-08-11 at 17:38 +1000, Balbir Singh wrote:
> 
> On 09/08/16 22:36, Mimi Zohar wrote:
> > On Tue, 2016-08-09 at 15:19 +1000, Balbir Singh wrote:
> >>
> >> On 04/08/16 22:24, Mimi Zohar wrote:
> >>> The TPM PCRs are only reset on a hard reboot.  In order to validate a
> >>> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> >>> of the running kernel must be saved and then restored on the subsequent
> >>> boot.
> >>>
> >>> The existing securityfs binary_runtime_measurements file conveniently
> >>> provides a serialized format of the IMA measurement list. This patch
> >>> set serializes the measurement list in this format and restores it.
> >>>
> >>> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> >>> hand-over for the next kernel" patch set* for actually carrying the
> >>> serialized measurement list across the kexec.
> >>>
> >>> Mimi
> >>>
> >>
> >> Hi, Mimi
> >>
> >> I am trying to convince myself of the security of the solution. I asked
> >> Thiago as well, but may be I am be lagging behind in understanding.
> >>
> >> We trust the kernel to hand over PCR values of the old kernel (which
> >> cannot be validated) to the IMA subsystem in the new kernel for storage.
> >> I guess the idea is for ima_add_boot_aggregate to do the right thing?
> >> How do we validate what the old kernel is giving us? Why do we care for
> >> the old measurement list? Is it still of significance in the new kernel?
> >>
> > 
> > Hi Balbir,
> > 
> > To validate the hardware TPM PCR values requires walking the measurement
> > list simulating the TPM extend operation.  The resulting values should
> > match the hardware TPM PCRs.
> > 
> > In the case of a soft reboot, the TPM PCRs are not reset to 0, so all
> > the measurements of the running system, including those from previous
> > soft reboots, need to be included in the measurement list.   Without
> > these measurements, the simulated PCR values will not match the hardware
> > TPM PCR values.  Thus the need for this patch set.
> > 
> > Measurements can not be added/removed/changed in the measurement list
> > without it being detectable.
> > 
> 
> Thanks Mimi
> 
> I think that makes sense
> 
> So effectively we do
> 
> first kernel boot -> <measurements match PCR and measurements are saved>
> second kernel boot -> <new PCR = first save measurements + new measurements>
> 
> and so on

No, the running system doesn't verify the measurement list against the
PCRs, before saving and carrying it across kexec. If the system has been
compromised, it can't be trusted to verify itself.  Verifying the
measurement list needs to be done by a trusted third party.  The system
just carries the measurement list(s) across kexec.

Mimi
