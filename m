Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31576C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:20:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F77620863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F77620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z3GG5cQ4zDqR0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 11:20:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=benh@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z3DN5jtwzDqNT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 11:18:59 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1C0IttL063742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 19:18:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qkfk4rvs3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 19:18:56 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 12 Feb 2019 00:18:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 12 Feb 2019 00:18:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1C0Iipt58785980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 00:18:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCE6FAE045;
 Tue, 12 Feb 2019 00:18:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C390AE04D;
 Tue, 12 Feb 2019 00:18:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 12 Feb 2019 00:18:44 +0000 (GMT)
Received: from pasglop (unknown [9.102.35.42])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C8917A0115;
 Tue, 12 Feb 2019 11:18:41 +1100 (AEDT)
Subject: Re: [QUESTION] powerpc, libseccomp, and spu
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Tom Hromatka <tom.hromatka@oracle.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Feb 2019 11:18:40 +1100
In-Reply-To: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
References: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
Organization: IBM Australia
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19021200-0020-0000-0000-000003159F48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021200-0021-0000-0000-00002166BA9A
Message-Id: <677aea3c839b214d08b4c6a647b9479fc37c5fbc.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120000
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
Reply-To: benh@au1.ibm.com
Cc: Paul Moore <paul@paul-moore.com>, Dhaval Giani <dhaval.giani@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-11 at 11:54 -0700, Tom Hromatka wrote:
> PowerPC experts,
> 
> Paul Moore and I are working on the v2.4 release of libseccomp,
> and as part of this work I need to update the syscall table for
> each architecture.
> 
> I have incorporated the new ppc syscall.tbl into libseccomp, but
> I am not familiar with the value of "spu" in the ABI column.  For
> example:
> 
> 22	32	umount				sys_oldumount
> 22	64	umount				sys_ni_syscall
> 22	spu	umount				sys_ni_syscall
> 
> In libseccomp, we maintain a 32-bit ppc syscall table and a 64-bit
> ppc syscall table.  Do we also need to add a "spu" ppc syscall
> table?  Some clarification on the syscalls marked "spu" and "nospu"
> would be greatly appreciated.

On the Cell processor, there is a number of little co-processors (SPUs)
that run alongside the main PowerPC core. Userspace can run code on
them, they operate within the user context via their own MMUs. We
provide a facility for them to issue syscalls (via some kind of RPC to
the main core). The "SPU" indication indicates syscalls that can be
called from the SPUs via that mechanism.

Now, the big question is, anybody still using Cell ? :-)

Cheers,
Ben.


