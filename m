Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48692C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:27:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E0221872
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E0221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lpyJ1NXqzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 04:27:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lpwG5SlXzDqDB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 04:26:06 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0OHGokx086926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 12:26:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q7h2ktf9g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 12:26:03 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Thu, 24 Jan 2019 17:25:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Jan 2019 17:25:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0OHPtLW65732742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Jan 2019 17:25:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFB5DA4054;
 Thu, 24 Jan 2019 17:25:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F10FA405C;
 Thu, 24 Jan 2019 17:25:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.102])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 24 Jan 2019 17:25:55 +0000 (GMT)
Date: Thu, 24 Jan 2019 19:25:53 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 02/12] powerpc/irq: use memblock functions returning
 virtual address
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <1c8e658c094022a15e4b9f5ef5c191caab3c0dff.1548346225.git.christophe.leroy@c-s.fr>
 <20190124165153.GB5531@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124165153.GB5531@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012417-0008-0000-0000-000002B58564
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012417-0009-0000-0000-00002221BAE8
Message-Id: <20190124172553.GE13790@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-24_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240121
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 24, 2019 at 04:51:53PM +0000, Mark Rutland wrote:
> On Thu, Jan 24, 2019 at 04:19:33PM +0000, Christophe Leroy wrote:
> > Since only the virtual address of allocated blocks is used,
> > lets use functions returning directly virtual address.
> > 
> > Those functions have the advantage of also zeroing the block.
> > 
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> [...]
> 
> > +static void *__init alloc_stack(void)
> > +{
> > +	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> > +
> > +	if (!ptr)
> > +		panic("cannot allocate stacks");
> > +
> > +	return ptr;
> > +}
> 
> I believe memblock_alloc() will panic() if it cannot allocate memory,
> since that goes:
> 
>  memblock_alloc()
>  -> memblock_alloc_try_nid()
>     -> panic()
> 
> So you can get rid of the panic() here, or if you want a custom panic
> message, you can use memblock_alloc_nopanic().

As we've already discussed it in [1], I'm working on removing the
_nopanic() versions and dropping the panic() calls from memblock_alloc()
and friends.

I've posted v2 of the patches earlier this week [2].
 
> [...]

[1] https://lore.kernel.org/lkml/20190108143428.GB14063@rapoport-lnx/ 
[2] https://lore.kernel.org/lkml/1548057848-15136-1-git-send-email-rppt@linux.ibm.com/

> >  static void *__init alloc_stack(unsigned long limit, int cpu)
> >  {
> > -	unsigned long pa;
> > +	void *ptr;
> >  
> >  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
> >  
> > -	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> > -					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> > -	if (!pa) {
> > -		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> > -		if (!pa)
> > -			panic("cannot allocate stacks");
> > -	}
> > +	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
> > +				     MEMBLOCK_LOW_LIMIT, limit,
> > +				     early_cpu_to_node(cpu));
> > +	if (!ptr)
> > +		panic("cannot allocate stacks");
> 
> The same applies here -- memblock_alloc_try_nid() will panic itself
> rather than returning NULL.
> 
> Otherwise, this looks like a nice cleanup. With the panics removed (or
> using the _nopanic() allocators), feel free to add:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
> 

-- 
Sincerely yours,
Mike.

