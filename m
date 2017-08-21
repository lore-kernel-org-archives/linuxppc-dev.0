Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbnwC4tfPzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 08:11:39 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7LM8eV7091209
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 18:11:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cg7ct1tsq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 18:11:36 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 16:11:36 -0600
Subject: [PATCH 0/2] Allow scsi_prep_fn to occur for retried commands
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
References: <1502902815.3305.22.camel@abdul.in.ibm.com>
 <1502904072.2421.3.camel@wdc.com>
 <2f686064-3e32-df8d-134f-962b5181da9d@linux.vnet.ibm.com>
 <1502985161.2615.8.camel@wdc.com>
 <71fb9c1b-9f3f-acdc-8bb5-aa1240aea763@linux.vnet.ibm.com>
 <1503092473.2622.17.camel@wdc.com>
 <0f7e2114-eba1-f149-ea80-d32d8b6d212a@linux.vnet.ibm.com>
 <1503094414.2622.21.camel@wdc.com>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 17:11:30 -0500
MIME-Version: 1.0
In-Reply-To: <1503094414.2622.21.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f4ec8576-f4d7-4be3-0f38-c1a9d7ef4251@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following two patches address the hang issue being observed
with Bart's patch on powerpc. The first patch moves the initialization
of jiffies_at_alloc from scsi_init_command to scsi_init_rq, and ensures
we don't zero jiffies_at_alloc in scsi_init_command. The second patch
saves / restores the retry counter in scsi_init_command which lets us
go through scsi_init_command for retries and not forget why we were
there. 

These patches have only been boot tested on my Power machine with ipr
to ensure they fix the issue I was seeing.

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
