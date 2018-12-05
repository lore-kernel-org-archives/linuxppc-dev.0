Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B4C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:38:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AC720850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AC720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4399YL1pT2zDq5v
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:38:30 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4399W42HSdzDqVl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 07:36:31 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB5KTUhP062724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Dec 2018 15:36:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p6mr2jt90-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 15:36:28 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 5 Dec 2018 20:36:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 20:36:23 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB5KaMJu61472886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 20:36:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99EA611C05E;
 Wed,  5 Dec 2018 20:36:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2005E11C05B;
 Wed,  5 Dec 2018 20:36:21 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.161.222])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Dec 2018 20:36:20 +0000 (GMT)
Date: Wed, 5 Dec 2018 12:36:17 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
 <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
 <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com>
 <87va4g5d3o.fsf@oldenburg.str.redhat.com>
 <20181203040249.GA11930@ram.oc3035372033.ibm.com>
 <CALCETrXeSQ8T9nvK7WpgPpkraLfg70FoDWvPZeLS3KiDaqXwtw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrXeSQ8T9nvK7WpgPpkraLfg70FoDWvPZeLS3KiDaqXwtw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18120520-0016-0000-0000-000002329664
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120520-0017-0000-0000-0000328AA9A8
Message-Id: <20181205203617.GF11930@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-05_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=319 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050180
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
Cc: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
 Linux API <linux-api@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 08:21:02AM -0800, Andy Lutomirski wrote:
> > On Dec 2, 2018, at 8:02 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> >
> >> On Thu, Nov 29, 2018 at 12:37:15PM +0100, Florian Weimer wrote:
> >> * Dave Hansen:
> >>
> >>>> On 11/27/18 3:57 AM, Florian Weimer wrote:
> >>>> I would have expected something that translates PKEY_DISABLE_WRITE |
> >>>> PKEY_DISABLE_READ into PKEY_DISABLE_ACCESS, and also accepts
> >>>> PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ, for consistency with POWER.
> >>>>
> >>>> (My understanding is that PKEY_DISABLE_ACCESS does not disable all
> >>>> access, but produces execute-only memory.)
> >>>
> >>> Correct, it disables all data access, but not execution.
> >>
> >> So I would expect something like this (completely untested, I did not
> >> even compile this):
> >
> >
> > Ok. I re-read through the entire email thread to understand the problem and
> > the proposed solution. Let me summarize it below. Lets see if we are on the same
> > plate.
> >
> > So the problem is as follows:
> >
> > Currently the kernel supports  'disable-write'  and 'disable-access'.
> >
> > On x86, cpu supports 'disable-write' and 'disable-access'. This
> > matches with what the kernel supports. All good.
> >
> > However on power, cpu supports 'disable-read' too. Since userspace can
> > program the cpu directly, userspace has the ability to set
> > 'disable-read' too.  This can lead to inconsistency between the kernel
> > and the userspace.
> >
> > We want the kernel to match userspace on all architectures.
> >
> > Proposed Solution:
> >
> > Enhance the kernel to understand 'disable-read', and facilitate architectures
> > that understand 'disable-read' to allow it.
> >
> > Also explicitly define the semantics of disable-access  as
> > 'disable-read and disable-write'
> >
> > Did I get this right?  Assuming I did, the implementation has to do
> > the following --
> >
> >    On power, sys_pkey_alloc() should succeed if the init_val
> >    is PKEY_DISABLE_READ, PKEY_DISABLE_WRITE, PKEY_DISABLE_ACCESS
> >    or any combination of the three.
> >
> >    On x86, sys_pkey_alloc() should succeed if the init_val is
> >    PKEY_DISABLE_WRITE or PKEY_DISABLE_ACCESS or PKEY_DISABLE_READ
> >    or any combination of the three, except  PKEY_DISABLE_READ
> >          specified all by itself.
> >
> >    On all other arches, none of the flags are supported.
> 
> I don’t really love having a situation where you can use different
> flag combinations to refer to the same mode.

true. But it is a side-effect of x86 cpu implicitly defining
'disable-access' as a combination of 'disable-read' and 'disable_write'.
In other words, if you disable-access on a pte on x86, you are
automatically disabling read and disabling write on that page.
The software/kernel just happens to explicitly capture that implicit
behavior.

> 
> Also, we should document the effect these flags have on execute permission.

Actually none of the above flags, interact with execute permission. They
operate independently; both on x86 and on POWER.  But yes, this
statement needs to be documented somewhere.

RP

