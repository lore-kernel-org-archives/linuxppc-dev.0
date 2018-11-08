Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE93ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:15:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8875820817
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8875820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rZKS0C8bzF3Sx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:15:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rZG91S19zF3TK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 07:12:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA8K9EFY022650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Nov 2018 15:12:47 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nmtrqu8bg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 15:12:46 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 8 Nov 2018 20:12:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 8 Nov 2018 20:12:41 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA8KCeXG1376614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 Nov 2018 20:12:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCD0EA405B;
 Thu,  8 Nov 2018 20:12:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67B58A4054;
 Thu,  8 Nov 2018 20:12:39 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.230.134])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  8 Nov 2018 20:12:39 +0000 (GMT)
Date: Thu, 8 Nov 2018 12:12:31 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18110820-0012-0000-0000-000002C76815
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110820-0013-0000-0000-000020FBB8C9
Message-Id: <20181108201231.GE5481@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-08_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080171
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

On Thu, Nov 08, 2018 at 06:37:41PM +0100, Florian Weimer wrote:
> * Dave Hansen:
>=20
> > On 11/8/18 7:01 AM, Florian Weimer wrote:
> >> Ideally, PKEY_DISABLE_READ | PKEY_DISABLE_WRITE and PKEY_DISABLE_READ |
> >> PKEY_DISABLE_ACCESS would be treated as PKEY_DISABLE_ACCESS both, and a
> >> line PKEY_DISABLE_READ would result in an EINVAL failure.
> >
> > Sounds reasonable to me.
> >
> > I don't see any urgency to do this right now.  It could easily go in
> > alongside the ppc patches when those get merged.
>=20
> POWER support has already been merged, so we need to do something here
> now, before I can complete the userspace side.
>=20
> > The only thing I'd suggest is that we make it something slightly
> > higher than 0x4.  It'll make the code easier to deal with in the
> > kernel if we have the ABI and the hardware mirror each other, and if
> > we pick 0x4 in the ABI for PKEY_DISABLE_READ, it might get messy if
> > the harware choose 0x4 for PKEY_DISABLE_EXECUTE or something.
> >=20
> > So, let's make it 0x80 or something on x86 at least.
>=20
> I don't have a problem with that if that's what it takes.
>=20
> > Also, I'll be happy to review and ack the patch to do this, but I'd
> > expect the ppc guys (hi Ram!) to actually put it together.
>=20
> Ram, do you want to write a patch?


Florian,

	I can. But I am struggling to understand the requirement. Why is
	this needed?  Are we proposing a enhancement to the sys_pkey_alloc(),
	to be able to allocate keys that are initialied to disable-read
	only?

RP

>=20
> I'll promise I finish the glibc support for this. 8-)
>=20
> Thanks,
> Florian

--=20
Ram Pai

