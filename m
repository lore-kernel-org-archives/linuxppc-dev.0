Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AEAC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 13:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76EF2081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 13:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76EF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4390RC0pj4zDqtj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 00:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sebott@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4390Nm0WynzDqtK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 00:45:24 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB5Df6bm065471
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Dec 2018 08:45:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p6fnf8m97-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 08:45:22 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.ibm.com>;
 Wed, 5 Dec 2018 13:45:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 13:45:16 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB5DjFFS58196184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 13:45:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDC624C04A;
 Wed,  5 Dec 2018 13:45:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3CDC4C05E;
 Wed,  5 Dec 2018 13:45:14 +0000 (GMT)
Received: from dyn-9-152-212-222.boeblingen.de.ibm.com (unknown
 [9.152.212.222])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Dec 2018 13:45:14 +0000 (GMT)
Date: Wed, 5 Dec 2018 14:45:14 +0100 (CET)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi.aag-de.ibmmobiledemo.com
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] sriov enablement on s390
In-Reply-To: <20181010162653.GD5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
 <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LFD.2.21.1810101451310.32089@schleppi.aag-de.ibmmobiledemo.com>
 <20181010162653.GD5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18120513-0012-0000-0000-000002D4F095
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120513-0013-0000-0000-0000210A517A
Message-Id: <alpine.LFD.2.21.1812051432580.1828@schleppi.aag-de.ibmmobiledemo.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050125
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Bjorn,

On Wed, 10 Oct 2018, Bjorn Helgaas wrote:
> On Wed, Oct 10, 2018 at 02:55:07PM +0200, Sebastian Ott wrote:
> > On Wed, 12 Sep 2018, Bjorn Helgaas wrote:
> > > On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> > > > On s390 we currently handle SRIOV within firmware. Which means
> > > > that the PF is under firmware control and not visible to operating
> > > > systems. SRIOV enablement happens within firmware and VFs are
> > > > passed through to logical partitions.
> > > > 
> > > > I'm working on a new mode were the PF is under operating system
> > > > control (including SRIOV enablement). However we still need
> > > > firmware support to access the VFs. The way this is supposed
> > > > to work is that when firmware traps the SRIOV enablement it
> > > > will present machine checks to the logical partition that
> > > > triggered the SRIOV enablement and provide the VFs via hotplug
> > > > events.
> > > > 
> > > > The problem I'm faced with is that the VF detection code in
> > > > sriov_enable leads to unusable functions in s390.
> > > 
> > > We're moving away from the weak function implementation style.  Can
> > > you take a look at Arnd's work here, which uses pci_host_bridge
> > > callbacks instead?
> > > 
> > >   https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de
> > 
> > What's the status of Arnd's patches - will they go upstream in the next
> > couple of versions?
> 
> I hope so [1].  IIRC Arnd mentioned doing some minor updates, so I'm
> waiting on that.
> 
> > What about my patches that I rebased on Arnd's branch
> > will they be considered?
> 
> Definitely.  From my point of view they're just lined up behind Arnd's
> patches.
> 
> [1] https://lore.kernel.org/linux-pci/20181002205903.GD120535@bhelgaas-glaptop.roam.corp.google.com

It appears like these patches are not in-line for the next merge window.
Would it be possible to go with my original patches (using __weak
functions)? (This would also make life easier with regards to backports)
I can post patches to convert this to use function pointers once Arnd's
patches make it to the kernel.

Regards,
Sebastian

