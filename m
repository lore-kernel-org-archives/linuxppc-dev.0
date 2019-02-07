Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D0C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:40:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A55D2173B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A55D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wPDh1lTyzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wPBm37jxzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 03:38:23 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x17GZbig048022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2019 11:38:21 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qgp0b86r0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 11:38:18 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 7 Feb 2019 16:38:11 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 7 Feb 2019 16:38:10 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x17Gc9nG14221546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Feb 2019 16:38:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC961AC060;
 Thu,  7 Feb 2019 16:38:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C08AC05B;
 Thu,  7 Feb 2019 16:38:08 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.156.8])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu,  7 Feb 2019 16:38:07 +0000 (GMT)
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
 <d7e1bb36080c83353525c39c7bcff7bb7046bae0.camel@russell.cc>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
In-reply-to: <d7e1bb36080c83353525c39c7bcff7bb7046bae0.camel@russell.cc>
Date: Thu, 07 Feb 2019 14:37:58 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19020716-0068-0000-0000-0000038FA3F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010554; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157671; UDB=6.00603986; IPR=6.00938202; 
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 16:38:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020716-0069-0000-0000-0000476BAA2B
Message-Id: <878syrlfnf.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-07_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=520 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070126
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Russell Currey <ruscur@russell.cc> writes:

> On Thu, 2019-02-07 at 15:08 +1000, Nicholas Piggin wrote:
>> Russell Currey's on February 6, 2019 4:28 pm:
>> > Without restoring the IAMR after idle, execution prevention on
>> > POWER9
>> > with Radix MMU is overwritten and the kernel can freely execute
>> > userspace without
>> > faulting.
>> >
>> > This is necessary when returning from any stop state that modifies
>> > user
>> > state, as well as hypervisor state.
>> >
>> > To test how this fails without this patch, load the lkdtm driver
>> > and
>> > do the following:
>> >
>> >    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>> >
>> > which won't fault, then boot the kernel with powersave=off, where
>> > it
>> > will fault.  Applying this patch will fix this.
>> >
>> > Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of
>> > user
>> > space")
>> > Cc: <stable@vger.kernel.org>
>> > Signed-off-by: Russell Currey <ruscur@russell.cc>
>>
>> Good catch and debugging. This really should be a quirk, we don't
>> want
>> to have to restore this thing on a thread switch.
>>
>> Can we put it under a CONFIG option if we're not using IAMR?
>
> I don't exactly know when we do or don't use the IAMR (since the only
> thing I've used it for is radix).  When wouldn't we care about
> restoring it on hash?

On hash it's used for memory protection keys (code is in
arch/powerpc/mm/pkeys.c). The kernel doesn't use protection keys, but
userspace apps may use it explicitly via specific syscalls
(pkey_alloc(), pkey_mprotect, pkey_free()).

Also, the kernel may use a protection key if the process does an
mmap(PROT_EXEC).

--
Thiago Jung Bauermann
IBM Linux Technology Center

