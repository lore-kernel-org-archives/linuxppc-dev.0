Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtQNQ0WHFzDqG3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 03:23:17 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EHJJD2053192
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:23:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cywb82tnn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:23:15 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 13:23:14 -0400
Date: Thu, 14 Sep 2017 10:23:06 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 5/7] powerpc: Swizzle around 4K PTE bits to free up bit 5
 and bit 6
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-6-git-send-email-linuxram@us.ibm.com>
 <20170914114834.62dcc428@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914114834.62dcc428@firefly.ozlabs.ibm.com>
Message-Id: <20170914172306.GE5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 11:48:34AM +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:45 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > We  need  PTE bits  3 ,4, 5, 6 and 57 to support protection-keys,
> > because these are  the bits we want to consolidate on across all
> > configuration to support protection keys.
> > 
> > Bit 3,4,5 and 6 are currently used on 4K-pte kernels.  But bit 9
> > and 10 are available.  Hence  we  use the two available bits and
> > free up bit 5 and 6.  We will still not be able to free up bit 3
> > and 4. In the absence  of  any  other free bits, we will have to
> > stay satisfied  with  what we have :-(.   This means we will not
> > be  able  to support  32  protection  keys, but only 8.  The bit
> > numbers are  big-endian as defined in the  ISA3.0
> >
> 
> Any chance for 4k PTE's we can do slot searching for the PTE?
> I guess thats add additional complexity

Aneesh, i think, is working on moving slot information out of the PTE.
If that happens, we will have leg-space to support more keys.

RP
