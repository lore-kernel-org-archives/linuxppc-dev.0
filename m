Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAD2C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:41:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14335218C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14335218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pSNw6jKTzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 01:41:52 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pSKr0b8FzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 01:39:10 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3NFZ9Yi002264
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 11:39:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s240rmyss-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 11:39:07 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Tue, 23 Apr 2019 16:39:05 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Apr 2019 16:39:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3NFd1Yr25624648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2019 15:39:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F0854C044;
 Tue, 23 Apr 2019 15:39:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1021A4C052;
 Tue, 23 Apr 2019 15:39:01 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2019 15:39:00 +0000 (GMT)
Date: Tue, 23 Apr 2019 17:38:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
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
 <20190419153307.4f2911b5@mschwideX1>
 <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042315-0012-0000-0000-00000311DF9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042315-0013-0000-0000-0000214A317E
Message-Id: <20190423173859.42d5ba8b@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-23_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230105
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

On Fri, 19 Apr 2019 10:27:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Apr 19, 2019 at 6:33 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > That problem got stuck in my head and I thought more about it. Why not
> > emulate the static folding sequence in the s390 page table code?  
> 
> So this model seems much closer to what x86 does in its folding, where
> the pattern is basically
> 
> > static inline pX-1d_t *pXd_offset(pXd_t *pXd, unsigned long address)
> > {
> >         if (pXd_folded(pXd)
> >                 return (pX-1d_t *) pXd;
> >         return (pX-1d_t *) pXd_deref(*pXd) + pXd_index(address);
> > }  
> 
> which is really how the code is designed to work (ie the folded entry
> doesn't actually do anything to the page directory pointer, it just
> says "ok, we'll use this exact page directory pointer for the next
> lower level instead".
> 
> And that's very much what allows the generic gup code to load the
> entry once, and use a temporary, and as you walk down the chain, if it
> is folded it just then uses that (previous) temporary value for the
> next level instead. IOW, the lower level page table is hidden inside
> the upper level one, and folding just means "don't do any offsets,
> don't change any values, just use the entry as-is for the next lower
> level".
> 
> So I think that's the right thing to do.

Ok, I added two patches for my s390/linux:features branch

Martin Schwidefsky (2):
      s390/mm: make the pxd_offset functions more robust
      s390/mm: convert to the generic get_user_pages_fast code

All code changes are inside arch/s390, I plan to include these patches with
the next merge window. That gives us a little bit of time to run our tests.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

