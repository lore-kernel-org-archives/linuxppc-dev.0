Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BECC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C74A20855
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C74A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s7Ym2dt8zF3Mr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 05:13:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s7V719lqzF3dq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 05:10:06 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA9I8qbn113646
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Nov 2018 13:10:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nned9jk36-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 13:10:03 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 9 Nov 2018 18:09:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 9 Nov 2018 18:09:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA9I9tt89961752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Nov 2018 18:09:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ABD0A405B;
 Fri,  9 Nov 2018 18:09:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE95A4054;
 Fri,  9 Nov 2018 18:09:51 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.146.154])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Nov 2018 18:09:50 +0000 (GMT)
Date: Fri, 9 Nov 2018 10:09:47 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bm6z71yw.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18110918-0028-0000-0000-0000031769F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110918-0029-0000-0000-000023D3C2EB
Message-Id: <20181109180947.GF5481@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-09_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=615 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090165
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 08, 2018 at 09:23:35PM +0100, Florian Weimer wrote:
> * Ram Pai:
> 
> > Florian,
> >
> > 	I can. But I am struggling to understand the requirement. Why is
> > 	this needed?  Are we proposing a enhancement to the sys_pkey_alloc(),
> > 	to be able to allocate keys that are initialied to disable-read
> > 	only?
> 
> Yes, I think that would be a natural consequence.
> 
> However, my immediate need comes from the fact that the AMR register can
> contain a flag combination that is not possible to represent with the
> existing PKEY_DISABLE_WRITE and PKEY_DISABLE_ACCESS flags.  User code
> could write to AMR directly, so I cannot rule out that certain flag
> combinations exist there.
> 
> So I came up with this:
> 
> int
> pkey_get (int key)
> {
>   if (key < 0 || key > PKEY_MAX)
>     {
>       __set_errno (EINVAL);
>       return -1;
>     }
>   unsigned int index = pkey_index (key);
>   unsigned long int amr = pkey_read ();
>   unsigned int bits = (amr >> index) & 3;
> 
>   /* Translate from AMR values.  PKEY_AMR_READ standing alone is not
>      currently representable.  */
>   if (bits & PKEY_AMR_READ)

this should be
   if (bits & (PKEY_AMR_READ|PKEY_AMR_WRITE))


>     return PKEY_DISABLE_ACCESS;


>   else if (bits == PKEY_AMR_WRITE)
>     return PKEY_DISABLE_WRITE;
>   return 0;
> }
> 
> And this is not ideal.  I would prefer something like this instead:
> 
>   switch (bits)
>     {
>       case PKEY_AMR_READ | PKEY_AMR_WRITE:
>         return PKEY_DISABLE_ACCESS;
>       case PKEY_AMR_READ:
>         return PKEY_DISABLE_READ;
>       case PKEY_AMR_WRITE:
>         return PKEY_DISABLE_WRITE;
>       case 0:
>         return 0;
>     }

yes.
 and on x86 it will be something like:
   switch (bits)
     {
       case PKEY_PKRU_ACCESS :
         return PKEY_DISABLE_ACCESS;
       case PKEY_AMR_WRITE:
         return PKEY_DISABLE_WRITE;
       case 0:
         return 0;
     }

But for this to work, why do you need to enhance the sys_pkey_alloc()
interface?  Not that I am against it. Trying to understand if the
enhancement is really needed.

> 
> By the way, is the AMR register 64-bit or 32-bit on 32-bit POWER?

It is 64-bit.

RP

