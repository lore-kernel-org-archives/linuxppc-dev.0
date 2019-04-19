Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C4C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 13:36:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C1D222B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C1D222B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lxnq0tjzzDqSS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 23:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=de.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=schwidefsky@de.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=de.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lxkT3htYzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 23:33:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3JDQHYk035691
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 09:33:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rydut3b15-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 09:33:15 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Fri, 19 Apr 2019 14:33:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Apr 2019 14:33:10 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3JDXAFb52429038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2019 13:33:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5304A405B;
 Fri, 19 Apr 2019 13:33:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EA04A4054;
 Fri, 19 Apr 2019 13:33:09 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.155.124])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2019 13:33:09 +0000 (GMT)
Date: Fri, 19 Apr 2019 15:33:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190418204144.16adf2a0@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
 <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1>
 <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1>
 <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041913-0008-0000-0000-000002DBA655
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041913-0009-0000-0000-00002247EB5E
Message-Id: <20190419153307.4f2911b5@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-19_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190102
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 18 Apr 2019 20:41:44 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Thu, 18 Apr 2019 08:49:32 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
> > <schwidefsky@de.ibm.com> wrote:  
> > >
> > > The problematic lines in the generic gup code are these three:
> > >
> > > 1845:   pmdp = pmd_offset(&pud, addr);
> > > 1888:   pudp = pud_offset(&p4d, addr);
> > > 1916:   p4dp = p4d_offset(&pgd, addr);
> > >
> > > Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> > > not work with the page table folding on s390.    
> > 
> > Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.
> > 
> > The folding works with the local copy just the same way it works with
> > the orignal value.  
> 
> The difference is that with the static page table folding pgd_offset()
> does the index calculation of the actual hardware top-level table. With
> dynamic page table folding as s390 is doing it, if the task does not use
> a 5-level page table pgd_offset() will see a pgd_index() of 0, the indexing
> of the actual top-level table is done later with p4d_offset(), pud_offset()
> or pmd_offset(). 
> 
> As an example, with a three level page table we have three indexes x/y/z.
> The common code "thinks" 5 indexing steps, with static folding the index
> sequence is x 0 0 y z. With dynamic folding the sequence is 0 0 x y z.
> By moving the first indexing operation to pgd_offset the static sequence
> does not add an index to a non-dereferenced pointer to a stack variable,
> the dynamic sequence does.

That problem got stuck in my head and I thought more about it. Why not
emulate the static folding sequence in the s390 page table code?

As the table type is encoded in every entry for the region and segment
tables, pgd_offset() can look at the first entry to find the table type
and then do the correct index calculation for the given top-level table.
Like this:

static inline pgd_t *pgd_offset_raw(pgd_t *pgd, unsigned long address)
{
        unsigned long rste;
        unsigned int shift;

        /* Get the first entry of the top level table */
        rste = pgd_val(*pgd);
        /* Pick up the shift from the table type of the first entry */
        shift = ((rste & _REGION_ENTRY_TYPE_MASK) >> 2) * 11 + 20;
        return pgd + ((address >> shift) & (PTRS_PER_PGD - 1));
}

#define pgd_offset(mm, address) pgd_offset_raw((mm)->pgd, address)
#define pgd_offset_k(address) pgd_offset(&init_mm, address)

static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
{
        if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R1)
                return (p4d_t *) pgd;
        return (p4d_t *) pgd_deref(*pgd) + p4d_index(address);
}

static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
{
        if ((p4d_val(*p4d) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R2)
                return (pud_t *) p4d;
        return (pud_t *) p4d_deref(*p4d) + pud_index(address);
}

static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
{
        if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
                return (pmd_t *) pud;
        return (pmd_t *) pud_deref(*pud) + pmd_index(address);
}

This needs more thorough testing but in principle it does work. The kernel
boots and survives a kernel compile. The only things that is slightly off is
that pgd_offset() now has to look at the first table entry to do its job.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

