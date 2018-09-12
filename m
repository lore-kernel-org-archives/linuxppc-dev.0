Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429JGC4jW9zF31W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 20:40:35 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CAeA2h010742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 06:40:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mexa5ypt2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 06:40:31 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 12 Sep 2018 11:40:09 +0100
Subject: Re: [PATCH v2 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing
 to rescan
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, Sam Bobroff
 <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Date: Wed, 12 Sep 2018 12:39:57 +0200
In-Reply-To: <61e8e5b9-0ed2-1848-d676-64bcbd3b9cbc@yadro.com>
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-6-s.miroshnichenko@yadro.com>
 <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
 <61e8e5b9-0ed2-1848-d676-64bcbd3b9cbc@yadro.com>
Mime-Version: 1.0
Message-Id: <baf90fe99f3644b33d50966b5721991a84369a7d.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-10 at 19:00 +0300, Sergey Miroshnichenko wrote:
> 
> Yes, missing a real EEH event is possible, unfortunately, and it is
> indeed worth mentioning.
> 
> To reduce this probability the next patchset I'll post in a few days
> among other things puts all the affected device drivers to pause during
> rescan, mainly because of moving BARs and bridge windows, but it will
> also help here a bit.

How do you deal with moving BARs etc... within the segmenting
restrictions of EEH ?

It's a horrible mess right now and I don't know if the current code can
even work properly to be honest.

Cheers,
Ben.
