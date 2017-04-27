Return-Path: <srs0=6oba=4d=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD4GW0276zDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:48:51 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wD4GV6gxRz8sWc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:48:50 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wD4GV3DRJz9s3T
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:48:50 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R4mlBG051076
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 00:48:49 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a34vxhfdw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 00:48:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 27 Apr 2017 14:48:44 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R4mW6258065044
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:48:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R4m7fB002329
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 14:48:07 +1000
Subject: Re: [PATCH v2] cxl: Prevent IRQ storm
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: frederic.barrat@fr.ibm.com
Date: Thu, 27 Apr 2017 14:47:43 +1000
In-Reply-To: <19926571-7158-0ad8-4bf4-aa20abf23092@au1.ibm.com>
References: <20170427013721.2138-1-alastair@au1.ibm.com>
 <19926571-7158-0ad8-4bf4-aa20abf23092@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1493268463.3426.23.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-27 at 14:41 +1000, Andrew Donnellan wrote:
On 27/04/17 11:37, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > In some situations, a faulty AFU slice may create an interrupt
> > storm,
> > rendering the machine unusable. Since these interrupts are
> > informational
> > only, present the interrupt once, then mask it off to prevent it
> > from
> > being retriggered until the card is reset.
> > 
> > Changelog:
> > v2
> > 	Rebase against linux-next
> 
> The patch changelog shouldn't be part of the commit message - it
> should 
> go under a "---" line after the sign-off so it doesn't get included
> in 
> the final commit.
> 
> Also now that I've taken a second look, I think the summary line of
> the 
> commit message could be more descriptive, something like:
> 
> "cxl: mask slice error interrupt after first occurrence"
> 
> or something to that effect?
> 

Ok

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
