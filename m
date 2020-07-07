Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7B4C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 08:44:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB332053B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 08:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB332053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1GF93w8PzDqmb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 18:43:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1GCH6Yw5zDqXP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 18:42:19 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0678VQlG141009; Tue, 7 Jul 2020 04:42:10 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 324ffdsevf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 04:42:09 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0678fWfv024016;
 Tue, 7 Jul 2020 08:42:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 322hd7smex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 08:42:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0678g5wJ7406056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2020 08:42:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B38F52051;
 Tue,  7 Jul 2020 08:42:05 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D171352063;
 Tue,  7 Jul 2020 08:42:03 +0000 (GMT)
Date: Tue, 7 Jul 2020 14:12:03 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/numa: Restrict possible nodes based on platform
Message-ID: <20200707084203.GC874@linux.vnet.ibm.com>
References: <20200706064002.14848-1-srikar@linux.vnet.ibm.com>
 <87lfjv5352.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfjv5352.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_05:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 impostorscore=0 cotscore=-2147483648 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070062
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Michael Ellerman <mpe@ellerman.id.au> [2020-07-07 15:02:17]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > As per PAPR, there are 2 device tree property
> > ibm,max-associativity-domains (which defines the maximum number of
> > domains that the firmware i.e PowerVM can support) and
> > ibm,current-associativity-domains (which defines the maximum number of
> > domains that the platform can support). Value of
> > ibm,max-associativity-domains property is always greater than or equal
> > to ibm,current-associativity-domains property.
> 
> Where is it documented?
> 
> It's definitely not in LoPAPR.
> 

https://openpowerfoundation.org/wp-content/uploads/2020/07/LoPAR-20200611.pdf
Page number 833.

which says 
ibm,current-associativity-domains”
	property name to define the current number of associativity
	domains for this platform.
	prop-encoded-array: An associativity list such that all values are
	the number of unique values that the current platform supports
	in that location. The associativity list consisting of a number of
	entries integer (N) encoded as with encode-int followed by N
	integers encoded as with encode-int each representing current
	number of unique associativity domains the platform supports at
	that level.

> > Powerpc currently uses ibm,max-associativity-domains  property while
> > setting the possible number of nodes. This is currently set at 32.
> > However the possible number of nodes for a platform may be significantly
> > less. Hence set the possible number of nodes based on
> > ibm,current-associativity-domains property.
> >
> > $ lsprop /proc/device-tree/rtas/ibm,*associ*-domains
> > /proc/device-tree/rtas/ibm,current-associativity-domains
> > 		 00000005 00000001 00000002 00000002 00000002 00000010
> > /proc/device-tree/rtas/ibm,max-associativity-domains
> > 		 00000005 00000001 00000008 00000020 00000020 00000100
> >
> > $ cat /sys/devices/system/node/possible ##Before patch
> > 0-31
> >
> > $ cat /sys/devices/system/node/possible ##After patch
> > 0-1
> >
> > Note the maximum nodes this platform can support is only 2 but the
> > possible nodes is set to 32.
> 
> But what about LPM to a system with more nodes?
> 

I have very less info on LPM, so I checked with Nathan Lynch before posting
and as per Nathan in the current design of LPM, Linux wouldn't use the new
node numbers. 

-- 
Thanks and Regards
Srikar Dronamraju
