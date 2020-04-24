Return-Path: <SRS0=4/q6=6I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDACC54FD0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 18:09:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7B3206B9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 18:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7B3206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4982J02d6dzDrBY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 04:09:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=naveen.n.rao@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4982Fx5909zDr1x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 04:07:49 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03OI3gGM041858; Fri, 24 Apr 2020 14:07:19 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30jtk44fk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2020 14:07:18 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03OI5FTb023505;
 Fri, 24 Apr 2020 18:07:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 30fs65hb2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2020 18:07:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03OI7DmJ54591736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2020 18:07:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5418D4205F;
 Fri, 24 Apr 2020 18:07:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBB2542049;
 Fri, 24 Apr 2020 18:07:12 +0000 (GMT)
Received: from localhost (unknown [9.85.74.26])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2020 18:07:12 +0000 (GMT)
Date: Fri, 24 Apr 2020 23:37:06 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: Properly return error code from
 do_patch_instruction()
To: Christophe Leroy <christophe.leroy@c-s.fr>, Steven Rostedt
 <rostedt@goodmis.org>
References: <cover.1587654213.git.naveen.n.rao@linux.vnet.ibm.com>
 <b1dbbb34a389a6f59eb6c99102d94c0070ddaf98.1587654213.git.naveen.n.rao@linux.vnet.ibm.com>
 <16070946-1185-2aad-62fe-f4ed9cd4eefe@c-s.fr>
 <20200424091552.497dc719@gandalf.local.home>
In-Reply-To: <20200424091552.497dc719@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421 (https://github.com/astroidmail/astroid)
Message-Id: <1587751422.a0nwb9dqfv.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-24_09:2020-04-24,
 2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240138
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

Hi Steve,

Steven Rostedt wrote:
> On Thu, 23 Apr 2020 18:21:14 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>=20
>> Le 23/04/2020 =C3=A0 17:09, Naveen N. Rao a =C3=A9crit=C2=A0:
>> > With STRICT_KERNEL_RWX, we are currently ignoring return value from
>> > __patch_instruction() in do_patch_instruction(), resulting in the erro=
r
>> > not being propagated back. Fix the same. =20
>>=20
>> Good patch.
>>=20
>> Be aware that there is ongoing work which tend to wanting to replace=20
>> error reporting by BUG_ON() . See=20
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D166003
>=20
> Thanks for the reference. I still believe that WARN_ON() should be used i=
n
> 99% of the cases, including here. And only do a BUG_ON() when you know
> there's no recovering from it.

I'm not sure if you meant that we should have a WARN_ON() in=20
patch_instruction(), or if it was about the users of=20
patch_instruction(). As you're well aware, ftrace likes to do its own=20
WARN_ON() if any of its operations fail through ftrace_bug(). That was=20
the reason I didn't add anything here.


- Naveen
