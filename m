Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbJ8f15h2zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 09:49:20 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NNnB4e132586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:49:17 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q6r6dsgh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:49:17 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 20:49:15 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 071721DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:49:05 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NNnCO45189824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 20:49:12 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NNnBVA023503
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 20:49:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Thu, 23 Jun 2016 20:49:10 -0300
In-Reply-To: <576C63B4.8060302@gmail.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1612090.Qxo4UiJulB@hactar> <576C63B4.8060302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1489849.szMRu2Hvtq@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 24 Juni 2016, 08:33:24 schrieb Balbir Singh:
> On 24/06/16 02:44, Thiago Jung Bauermann wrote:
> > Sorry, I still don't understand your concern. What kind of cheating?
> > Which values? If it's the values in the event log, there's no need to
> > trust the old kernel. The new kernel knows that the old kernel didn't
> > pass wrong measurement values in the event log because it can
> > recalculate the PCR extend operations recorded in the log and compare
> > the results of the replay with the current PCR values stored in the TPM
> > device. If they match, then the event log is guaranteed to be correct.
> > If they don't match, either the memory was corrupted somehow during the
> > kexec process, or the old kernel tried to pass a falsified event log.
> 
> Yep, get it/got it. My concern was anything using passed on the values
> should compare the results with the current PCR values.
> 
> BTW, what do we gain by passing the values if we are relying on the PCR
> registers anyway, can't we directly read them off from there? Aren't we
> going to ready anyway to compare, what does passing the values gain?

The PCR values themselves change for reasons that the application/user may 
not care about. For example, just changing the order in which measurements 
are made changes the final value of the PCR, even if all the measurements 
themselves don't change. And in current multi-processor machines this order 
does change at each boot, so you can't rely on two boots of the same machine 
with the same software to have the same PCR values.

Also, you may want to verify only the measurement of one of the components 
and not care about the other components.

With an event log, you can verify the checksum of each measured component 
individually, and the PCR value serves to confirm that the event log is 
correct. Just having the final PCR value without the event log, you don't 
know which measurements were made.

> >> and
> >> 
> >> How do we know the new kernel is safe to load - I guess via a signature
> >> that the new kernel is signed with (assuming it is present in the key
> >> ring).
> > 
> > Correct. That goal is met by signature verification, not by integrity
> > assurance.
> > 
> > I'll note that even with both of my patch series there's still code
> > missing for kernel signature verification in PowerPC. I believe there's
> > not a file format defined yet for how to store a signature in a PowerPC
> > kernel image.
> > 
> > Integrity assurance doesn't depend on kernel signature verification
> > though. There's value in both my patch series even without kernel
> > signature verification support. They're complementary features.
> 
> Thanks for clarifying

Thank you for your interest.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
