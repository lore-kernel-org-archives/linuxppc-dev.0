Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8CdP6s3rzDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:06:33 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q74EsD138825
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 02:06:31 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286xbs5fcv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 02:06:30 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 26 Jan 2017 17:06:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 46FC82BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:06:27 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0Q76JsW12714064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:06:27 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0Q75s8R014313
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 18:05:54 +1100
Subject: Re: [bug] stack protector panics on v4.10-rc1+
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Artem Savkov <asavkov@redhat.com>, Herton
 Krzesinski <hkrzesin@redhat.com>, Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Jan 2017 18:05:26 +1100
In-Reply-To: <20170125035453.GA12855@localhost.localdomain>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
 <20170124010421.GI30284@gate.crashing.org>
 <8737g9azuj.fsf@concordia.ellerman.id.au>
 <87ziih9jzv.fsf@concordia.ellerman.id.au>
 <20170125035453.GA12855@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1485414326.2980.60.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-25 at 09:24 +0530, Balbir Singh wrote:
> That makes sense. We then wait for the right gcc version? I guess we
> also
> push for per-task gaurd value as opposed to a global one?

I'm thinking per-cpu will be easier as r13 is readily available as
PACA.

Cheers,
Ben.
