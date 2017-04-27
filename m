Return-Path: <srs0=3as0=4d=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD47q4y6QzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:43:03 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wD47q48FMz8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:43:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wD47q19WNz9ryT
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:43:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R4djhx034783
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 00:42:58 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a34vxha7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 00:42:58 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 27 Apr 2017 14:42:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R4gi1S2490782
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:42:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R4gJ3Z026785
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:42:19 +1000
Subject: Re: [PATCH v2] cxl: Prevent IRQ storm
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170427013721.2138-1-alastair@au1.ibm.com>
Cc: frederic.barrat@fr.ibm.com, "Alastair D'Silva" <alastair@d-silva.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 27 Apr 2017 14:41:55 +1000
MIME-Version: 1.0
In-Reply-To: <20170427013721.2138-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <19926571-7158-0ad8-4bf4-aa20abf23092@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/04/17 11:37, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm,
> rendering the machine unusable. Since these interrupts are informational
> only, present the interrupt once, then mask it off to prevent it from
> being retriggered until the card is reset.
>
> Changelog:
> v2
> 	Rebase against linux-next

The patch changelog shouldn't be part of the commit message - it should 
go under a "---" line after the sign-off so it doesn't get included in 
the final commit.

Also now that I've taken a second look, I think the summary line of the 
commit message could be more descriptive, something like:

"cxl: mask slice error interrupt after first occurrence"

or something to that effect?


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
