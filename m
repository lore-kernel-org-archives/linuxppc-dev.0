Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC4C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 03:45:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA5B224E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 03:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA5B224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vD6P3gMlzF3Kp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 14:45:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vD442g0bzF3Kg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 14:43:16 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAD3YAj0097369
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:43:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nqmqumn11-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:43:13 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Tue, 13 Nov 2018 03:43:11 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 13 Nov 2018 03:43:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAD3h7Ne45547624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Nov 2018 03:43:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64B094203F;
 Tue, 13 Nov 2018 03:43:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 060A042041;
 Tue, 13 Nov 2018 03:43:06 +0000 (GMT)
Received: from dhcp-9-193-110-205.in.ibm.com (unknown [9.193.110.205])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 13 Nov 2018 03:43:05 +0000 (GMT)
Date: Tue, 13 Nov 2018 09:13:03 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add KVM guest defconfig
References: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
 <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
 <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
 <87efbqa3h3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efbqa3h3.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111303-0020-0000-0000-000002E718AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111303-0021-0000-0000-000021362378
Message-Id: <20181113034303.GA21719@dhcp-9-193-110-205.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-13_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130032
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 11:24:08PM +1100, Michael Ellerman wrote:
> Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:
> 
> > On Thu, Nov 08, 2018 at 04:23:07PM -0200, Breno Leitao wrote:
> >> hi Satheesh,
> >> 
> >> On 11/08/2018 03:08 AM, sathnaga@linux.vnet.ibm.com wrote:
> >> > --- /dev/null
> >> > +++ b/arch/powerpc/configs/guest.config
> >> > @@ -0,0 +1,14 @@
> >> > +CONFIG_VIRTIO_BLK=y
> >> > +CONFIG_VIRTIO_BLK_SCSI=y
> >> > +CONFIG_SCSI_VIRTIO=y
> >> > +CONFIG_VIRTIO_NET=y
> >> > +CONFIG_NET_FAILOVER=y
> >> > +CONFIG_VIRTIO_CONSOLE=y
> >> > +CONFIG_VIRTIO=y
> >> > +CONFIG_VIRTIO_PCI=y
> >> > +CONFIG_KVM_GUEST=y
> >> > +CONFIG_EPAPR_PARAVIRT=y
> >> > +CONFIG_XFS_FS=y
> >> 
> >> Why a guest kernel needs to have XFS integrated in the core image? I am
> >> wondering if it is a requirement from another CONFIG_ option.
> >
> > Idea is to have a working config which would boot guest without initramfs,
> > other FS(like EXT4) is already integrated in the core image, 
> > thought this would be helpful for distributions, which default XFS as root disk.
> 
> Maybe we should switch XFS_FS to Y in ppc64_defconfig ?

Sure, makes sense, will send it for ppc64_defconfig instead. 
Inaddition, Have few more symbols to be enabled for cgroups,
memhotplug,numa balancing.
I guess these symbols can also go to ppc64_defconfig itself?.

i.e,

CONFIG_CGROUP_SCHED=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_NUMA_BALANCING=y

Thanks!
-Satheesh.
> 
> cheers
> 

