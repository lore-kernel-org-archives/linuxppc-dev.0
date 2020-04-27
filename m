Return-Path: <SRS0=vPFq=6L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD22C54FCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 17:20:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2299220728
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 17:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2299220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 499s3f6zNczDqHK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 03:20:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=naveen.n.rao@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 499rxb1vwYzDqbr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 03:14:58 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03RH5vQC066227; Mon, 27 Apr 2020 13:14:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mg162wcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 13:14:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03RHArim023928;
 Mon, 27 Apr 2020 17:14:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 30mcu6v9hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 17:14:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 03RHEMOv52953582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2020 17:14:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31AFB11C050;
 Mon, 27 Apr 2020 17:14:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAD0711C05B;
 Mon, 27 Apr 2020 17:14:20 +0000 (GMT)
Received: from localhost (unknown [9.85.118.151])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2020 17:14:20 +0000 (GMT)
Date: Mon, 27 Apr 2020 22:44:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: Properly return error code from
 do_patch_instruction()
To: Christophe Leroy <christophe.leroy@c-s.fr>, "Christopher M. Riedl"
 <cmr@informatik.wtf>, Steven Rostedt <rostedt@goodmis.org>
References: <C29ONNE5PMZ3.2R5TT1FV2RFHC@geist>
In-Reply-To: <C29ONNE5PMZ3.2R5TT1FV2RFHC@geist>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421 (https://github.com/astroidmail/astroid)
Message-Id: <1588007590.t29ey2qypb.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-27_12:2020-04-27,
 2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270135
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christopher M. Riedl wrote:
> On Fri Apr 24, 2020 at 9:15 AM, Steven Rostedt wrote:
>> On Thu, 23 Apr 2020 18:21:14 +0200
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>=20
>> > Le 23/04/2020 =C3=A0 17:09, Naveen N. Rao a =C3=A9crit=C2=A0:
>> > > With STRICT_KERNEL_RWX, we are currently ignoring return value from
>> > > __patch_instruction() in do_patch_instruction(), resulting in the er=
ror
>> > > not being propagated back. Fix the same. =20
>> >=20
>> > Good patch.
>> >=20
>> > Be aware that there is ongoing work which tend to wanting to replace=20
>> > error reporting by BUG_ON() . See=20
>> > https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D16600=
3
>>
>>=20
>> Thanks for the reference. I still believe that WARN_ON() should be used
>> in
>> 99% of the cases, including here. And only do a BUG_ON() when you know
>> there's no recovering from it.
>>
>>=20
>> In fact, there's still BUG_ON()s in my code that I need to convert to
>> WARN_ON() (it was written when BUG_ON() was still acceptable ;-)
>>
> Figured I'd chime in since I am working on that other series :) The
> BUG_ON()s are _only_ in the init code to set things up to allow a
> temporary mapping for patching a STRICT_RWX kernel later. There's no
> ongoing work to "replace error reporting by BUG_ON()". If that initial
> setup fails we cannot patch under STRICT_KERNEL_RWX at all which imo
> warrants a BUG_ON(). I am still working on v2 of my RFC which does
> return any __patch_instruction() error back to the caller of
> patch_instruction() similar to this patch.

Ok, that's good to know. I will drop this patch from my series, since=20
this can be done independently of the other changes.

- Naveen

