Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DFDC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:42:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717832054F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717832054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tv1x3cj0zDqf3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 21:42:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TtzM1tp8zDqf3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 21:40:15 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w99Ae3i1070140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Oct 2018 06:40:13 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n0qan8tcr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 06:40:12 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 06:40:11 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Oct 2018 06:40:07 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w99Ae6OB37027848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Oct 2018 10:40:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53A65112061;
 Tue,  9 Oct 2018 06:39:28 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 523BF11206E;
 Tue,  9 Oct 2018 06:39:26 -0400 (EDT)
Received: from [9.122.211.201] (unknown [9.122.211.201])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  9 Oct 2018 06:39:26 -0400 (EDT)
Subject: Re: [linux-next][bisected e3fbcc7c] build error at
 drivers/pci/pcie/aer_inject.c:444:6: error: =?UTF-8?Q?=E2=80=98struct?=
 =?UTF-8?Q?_pt=5Fregs=E2=80=99?= has no member named =?UTF-8?Q?=E2=80=98ip?=
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 09 Oct 2018 16:10:03 +0530
In-Reply-To: <87woqr1mfr.fsf@concordia.ellerman.id.au>
References: <1539069292.17569.7.camel@abdul.in.ibm.com>
 <87woqr1mfr.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100910-0040-0000-0000-0000047DAFB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009846; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01100095; UDB=6.00569146; IPR=6.00880143; 
 MB=3.00023676; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 10:40:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100910-0041-0000-0000-00000885BF88
Message-Id: <1539081603.17569.10.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-09_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090110
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, keith.busch@intel.com,
 linux-next <linux-next@vger.kernel.org>, bhelgaas@google.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-09 at 20:47 +1100, Michael Ellerman wrote:
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > Greeting's
> >
> > Today's linux-next fails to build on ppc with below error
> >
> > drivers/pci/pcie/aer_inject.c: In function ‘aer_inject_ftrace_thunk’:
> > drivers/pci/pcie/aer_inject.c:444:6: error: ‘struct pt_regs’ has no
> > member named ‘ip’
> >   regs->ip = (unsigned long) hook->function;
> >       ^
> > make[3]: *** [drivers/pci/pcie/aer_inject.o] Error 1
> > make[2]: *** [drivers/pci/pcie] Error 2
> > make[1]: *** [drivers/pci] Error 2
> >
> > Machine: Power 9
> > kernel version: 4.19.0-rc7-next-20181008
> > gcc version: 4.8.5 20150623
> > config attached
> >
> > Recent code changes from these commits:
> >
> > c79ad38b36dd4967d67f83fc48bade37ee041a47 PCI/AER: Abstract AER interrupt handling
> > 7b23285f930a8dedcbf749661cd0f2cc27f79be6 PCI/AER: Reuse existing pcie_port_find_device() interface
> > e3fbcc7c4b130f81ea586183db561fa3ce9c6447 PCI/AER: Covertly inject errors with ftrace hooks
> 
> I don't see this commit in today's linux next (20181009) so presumably
> someone else has noticed and dropped the commit?

Yes, the commit is dropped from next-20181009, and now build is fine.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



