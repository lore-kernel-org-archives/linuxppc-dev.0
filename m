Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8CfV2Gg3zDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:07:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q74D3x055578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 02:07:27 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28777k94a6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 02:07:27 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 26 Jan 2017 17:07:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC1013578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:07:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0Q77D1E30474484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:07:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0Q76nw3002236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:06:49 +1100
Subject: Re: [bug] stack protector panics on v4.10-rc1+
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Artem Savkov <asavkov@redhat.com>, Herton
 Krzesinski <hkrzesin@redhat.com>, Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Jan 2017 18:06:22 +1100
In-Reply-To: <1485414326.2980.60.camel@au1.ibm.com>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
 <20170124010421.GI30284@gate.crashing.org>
 <8737g9azuj.fsf@concordia.ellerman.id.au>
 <87ziih9jzv.fsf@concordia.ellerman.id.au>
 <20170125035453.GA12855@localhost.localdomain>
 <1485414326.2980.60.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1485414382.2980.61.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-26 at 18:05 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2017-01-25 at 09:24 +0530, Balbir Singh wrote:
> > That makes sense. We then wait for the right gcc version? I guess
> > we
> > also
> > push for per-task gaurd value as opposed to a global one?
> 
> I'm thinking per-cpu will be easier as r13 is readily available as
> PACA.

Actually it has to be per-task ... so we'll have to put it in the PACA
and context switch the value in there.

Cheers,
Ben.
