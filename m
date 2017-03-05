Return-Path: <srs0=bjsa=2o=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbzF24DymzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:11:18 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vbzF23YhMz8tBy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:11:18 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vbzF20nRpz9s78
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 10:11:17 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25N8U0I011710
 for <linuxppc-dev@ozlabs.org>; Sun, 5 Mar 2017 18:11:08 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm40a4p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Mar 2017 18:11:08 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 09:11:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E7462CE8046
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 10:11:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25NAu3e45809730
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Mar 2017 10:11:04 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25NAVv3008034
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Mar 2017 10:10:32 +1100
Subject: Re: [PATCH v3] powerpc/xics: Work around limitations of OPAL XICS
 priority handling
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, bsingharora@gmail.com
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 06 Mar 2017 10:10:02 +1100
In-Reply-To: <1488629006-17180-1-git-send-email-mpe@ellerman.id.au>
References: <1488629006-17180-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488755402.2870.118.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-03-04 at 23:03 +1100, Michael Ellerman wrote:
> +
> +       /* Allow "sufficient" time to drop any inflight IRQ's */
> +       mdelay(1);
> +

According to the HW guys, that should be 5ms in case the powerbus is
really really busy.

Cheers,
Ben.
