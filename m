Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5Fpy3T42zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 19:35:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v928YZRH044677
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Oct 2017 04:35:18 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2db6trp4h6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Oct 2017 04:35:17 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 2 Oct 2017 18:35:15 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v928ZCwp28442848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Oct 2017 19:35:12 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v928ZDtX032325
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Oct 2017 19:35:13 +1100
Subject: Re: [PATCH] powernv: Add OCC driver to mmap sensor area
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Stewart Smith <stewart@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Date: Mon, 02 Oct 2017 10:35:02 +0200
In-Reply-To: <87bmlqutq5.fsf@linux.vnet.ibm.com>
References: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <87bmlqutq5.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506933302.25065.3.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-02 at 14:14 +1100, Stewart Smith wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> > This driver provides interface to mmap the OCC sensor area
> > to userspace to parse and read OCC inband sensors.
> 
> Why?
> 
> Is this for debug? If so, the existing exports interface should be used.
> 
> If there's actual sensors, we already have two ways of exposing sensors
> to Linux: the OPAL_SENSOR API and the IMC API.
> 
> Why this method and not use the existing ones?

More than that, a sensor should be exposed to userspace via hwmon, not
some random direct userspace map.

Ben.
