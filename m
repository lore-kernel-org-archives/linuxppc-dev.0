Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70979ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:34:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26A920870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26A920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42khWc4R6LzF1RD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 17:34:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42khTQ0D7YzDsDx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 17:32:09 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9U6TO8J000931
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 02:32:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nedvv8d32-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 02:32:06 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 30 Oct 2018 06:32:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 30 Oct 2018 06:32:03 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9U6W1uU53084412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Oct 2018 06:32:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 800FA4C046;
 Tue, 30 Oct 2018 06:32:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D14494C058;
 Tue, 30 Oct 2018 06:31:58 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.178.19])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Oct 2018 06:31:58 +0000 (GMT)
Date: Mon, 29 Oct 2018 23:31:55 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [RFC PATCH v1 1/4] kvmppc: HMM backend driver to manage pages of
 secure guest
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-2-bharata@linux.ibm.com>
 <20181030050300.GA11072@blackberry>
MIME-Version: 1.0
In-Reply-To: <20181030050300.GA11072@blackberry>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18103006-0012-0000-0000-000002C02384
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103006-0013-0000-0000-000020F44843
Message-Id: <20181030063155.GB5494@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-30_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300056
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
Cc: kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 benh@linux.ibm.com, linux-mm@kvack.org, jglisse@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, paulus@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 04:03:00PM +1100, Paul Mackerras wrote:
> On Mon, Oct 22, 2018 at 10:48:34AM +0530, Bharata B Rao wrote:
> > HMM driver for KVM PPC to manage page transitions of
> > secure guest via H_SVM_PAGE_IN and H_SVM_PAGE_OUT hcalls.
> > 
> > H_SVM_PAGE_IN: Move the content of a normal page to secure page
> > H_SVM_PAGE_OUT: Move the content of a secure page to normal page
> 
> Comments below...
> 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  /* pSeries hypervisor opcodes */
....
> >  #define H_REMOVE		0x04
> >  #define H_ENTER			0x08
> > @@ -295,7 +298,9 @@
> >  #define H_INT_ESB               0x3C8
> >  #define H_INT_SYNC              0x3CC
> >  #define H_INT_RESET             0x3D0
> > -#define MAX_HCALL_OPCODE	H_INT_RESET
> > +#define H_SVM_PAGE_IN		0x3D4
> > +#define H_SVM_PAGE_OUT		0x3D8
> > +#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
> 
> We should define hcall numbers in the implementation-specific range.
> We can't use numbers in this range without first getting them
> standardized in PAPR.  Since these hcalls are not actually used by
> the guest but are just a private interface between KVM and the
> ultravisor, it's probably not worth putting them in PAPR.  We should
> pick a range somewhere in the 0xf000 - 0xfffc area and use that.

We are using that range for Ucalls.  For hcalls we were told to reserve
a range between 1024(0x400) to  2047(0x7FF). Have to reserve them in the
appropriate database.


RP

