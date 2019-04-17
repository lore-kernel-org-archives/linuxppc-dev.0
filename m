Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69198C10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 08:04:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC558206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC558206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kZWl55WhzDqBg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:04:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kZV75ZcMzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 18:02:55 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3H7uHWT097251
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 04:02:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx01frrch-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 04:02:52 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Wed, 17 Apr 2019 09:02:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 09:02:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3H82k9J49807494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 08:02:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47A6842054;
 Wed, 17 Apr 2019 08:02:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1026042064;
 Wed, 17 Apr 2019 08:02:46 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.37.72])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 08:02:45 +0000 (GMT)
Date: Wed, 17 Apr 2019 10:02:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190417094637.51ad4c67@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
 <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041708-0028-0000-0000-00000361BC9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041708-0029-0000-0000-00002420F79A
Message-Id: <20190417100244.42e29736@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=641 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170054
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

On Wed, 17 Apr 2019 09:46:37 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Tue, 16 Apr 2019 09:49:46 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:  
> > >
> > > We actually already *have* this function.
> > >
> > > It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> > > the proper address range. Exactly like s390 needs..
> > >
> > > Could you please use that instead?    
> > 
> > IOW, something like the attached.
> > 
> > Obviously untested. And maybe 'current' isn't declared in
> > <asm/pgtable.h>, in which case you'd need to modify it to instead make
> > the inline function be "s390_gup_fast_permitted()" that takes a
> > pointer to the mm, and do something like
> > 
> >   #define gup_fast_permitted(start, pages) \
> >          s390_gup_fast_permitted(current->mm, start, pages)
> > 
> > instead.
> > 
> > But I think you get the idea..  
> 
> Nice, I did not realize that gup_fast_permitted is a platform
> override-able function. So that part is doable in arch/s390. But I
> spoke to soon, I got my first crash and realized that the common gup code
> is not usable as it is. The reason is this e.g. this sequence:
> 
> 	pgdp = pgd_offset(current->mm, addr);
> 	pgd_t pgd = READ_ONCE(*pgdp);
> 	/* some checking on pgd */
> 	gup_p4d_range(pgd, addr, next, write, pages, nr);
> 
> 	p4dp = p4d_offset(&pgd, addr);
> 	p4d_t p4d = READ_ONCE(*p4dp);
> 	/* some checking on p4d */
> 	gup_pud_range(p4d, addr, next, write, pages, nr);
> 
> 	pudp = pud_offset(&p4d, addr);
> 	pud_t pud = READ_ONCE(*pudp);
> 	/* some checking on pud */
> 	gup_pmd_range(pud, addr, next, write, pages, nr;
> 
> Each step along the way will read the page table entry and pass the
> table entry to the next function. This clashes with the page table
> folding on s390. The s390 gup code looks more like this:
> 
> 	pgdp = pgd_offset(current->mm, addr);
> 	/* some checking on pgd */
> 	pgd_t pgd = READ_ONCE(*pgdp);
> 	gup_p4d_range(pgdp, pgd, addr, next, write, pages, &nr);
> 
> 	p4dp = p4d_offset(pgdp, addr);
> 	p4d_t p4d = READ_ONCE(*p4dp);
> 	/* some checking on p4d */
> 	gup_pud_range(p4dp, p4d, addr, next, write, pages, nr);
> 
> 	pudp = pud_offset(p4dp, addr);
> 	pud_t pud = READ_ONCE(*pudp);
> 	/* some checking on pud */
> 	gup_pmd_range(pudp, pud, addr, next, write, pages, nr;
> 
> There are magic dereferences in the s390 versions of p4d_offset,
> pud_offset and pmd_offset functions. To make this work the pointer
> passed to these functions may not be the local copy of the already
> dereferenced table entry. I'll cook up a patch for the common code.

Grumpf, that does *not* work. For gup the table entries may be read only
once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
in arch/s390/mm/gup.c, to avoid to read the table entries twice.
It will be hard to use the common gup code after all.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

