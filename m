Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb6kg6D9CzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:44:43 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NGi5Gv051251
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:44:39 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q797812p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:44:39 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 13:44:37 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 8222B352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:44:18 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NGiYe637093464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:44:34 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NGiYHU008366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:44:34 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Thu, 23 Jun 2016 13:44:30 -0300
In-Reply-To: <576B25FF.1010307@gmail.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2895031.4C8tZ3BP2G@hactar> <576B25FF.1010307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1612090.Qxo4UiJulB@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 23 Juni 2016, 09:57:51 schrieb Balbir Singh:
> On 23/06/16 03:02, Thiago Jung Bauermann wrote:
> >>> 3. have IMA pass-on its event log (where integrity measurements are
> >>> 
> >>>    registered) accross kexec to the second kernel, so that the event
> >>>    history is preserved.
> >> 
> >> OK.. and this is safe? Do both the kernels need to be signed by the
> >> same certificate?
> > 
> > They don't. The integrity of the event log (assuming that is what you
> > mean by "this" in "this is safe") is guaranteed by the TPM device. Each
> > event in the measurement list extends a PCR and records its PCR value.
> > It is cryptographically guaranteed that if you replay the PCR extends
> > recorded in the event log and in the end of the process they match the
> > current PCR values in the TPM device, then that event log is correct.
> 
> What I meant was how does the new kernel know that the old kernel did not
> cheat while passing on the values? I presume because we trust that kernel
> via a signature.

Sorry, I still don't understand your concern. What kind of cheating? Which 
values? If it's the values in the event log, there's no need to trust the 
old kernel. The new kernel knows that the old kernel didn't pass wrong 
measurement values in the event log because it can recalculate the PCR 
extend operations recorded in the log and compare the results of the replay 
with the current PCR values stored in the TPM device. If they match, then 
the event log is guaranteed to be correct. If they don't match, either the 
memory was corrupted somehow during the kexec process, or the old kernel 
tried to pass a falsified event log.

There's no known way to construct an alternative series of PCR extend 
operations that will result in the same final value in the PCR register of 
the TPM device. If you can do that, you discovered a hash collision attack 
on the SHA-1 or SHA-256 algorithms (depending on which algorithm is being 
used by IMA in the event log). Or a bug in the TPM device implementation.

> and
> 
> How do we know the new kernel is safe to load - I guess via a signature
> that the new kernel is signed with (assuming it is present in the key
> ring).

Correct. That goal is met by signature verification, not by integrity 
assurance.

I'll note that even with both of my patch series there's still code missing 
for kernel signature verification in PowerPC. I believe there's not a file 
format defined yet for how to store a signature in a PowerPC kernel image.

Integrity assurance doesn't depend on kernel signature verification though. 
There's value in both my patch series even without kernel signature 
verification support. They're complementary features.
 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
