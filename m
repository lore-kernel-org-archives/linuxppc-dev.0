Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMds0QW4zDvXv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:41:53 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tLMdr38cHz9t1L
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 15:41:52 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAJ4cUGa045578
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 23:41:50 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26tcj362mg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 23:41:49 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 19 Nov 2016 14:41:46 +1000
Subject: Re: [PATCH 09/13] KVM: PPC: Book3S HV: Adapt TLB invalidations to
 work on POWER9
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Sat, 19 Nov 2016 15:41:44 +1100
In-Reply-To: <20161119041434.GE29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
 <87y40gn941.fsf@linux.vnet.ibm.com> <1479506248.27850.18.camel@au1.ibm.com>
 <20161119041434.GE29462@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1479530504.27850.34.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-19 at 15:14 +1100, Paul Mackerras wrote:
> 
> > These should be a device-tree property. We can fallback to hard wired
> > values if it doesn't exist but we should at least look for one.
> 
> Tell me what the property is called and I'll add code to use it. :)
> That's the whole reason why I moved this to C code.
> 
> > 
> > Note: P8 firmwares all have a bug creating a bogus "tlb-sets" property
> > in the CPU node, so let's create a new one instead, with 2 entries
> > (hash vs. radix) or 2 new ones, one for hash and one for radix (when
> > available).

Well, as I said above, there's a defined one but it has bogus values
on almost all P8 firwmares. So I think we need the core code to export
values for use by both the core mm and KVM which can then be picked up
from the DT with "quirks" to fixup the DT values.

(A bit like I did for the never-applied cache geometry patches)

That or we make up new names.

The question remains whether we need a separate property for radix
vs. hash though, we probably should as the "radix is half of hash"
might not be true on future chips.

Cheers,
Ben.
