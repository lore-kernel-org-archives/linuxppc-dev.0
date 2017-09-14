Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0460bF3zDrSK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 10:37:41 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8E0b28T134552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 20:37:40 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy9gmab2c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 20:37:39 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Sep 2017 10:37:37 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8E0bYlN40304698
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 10:37:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8E0bYWv023696
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 10:37:34 +1000
Subject: Re: Regression for Power PC in 4.14-rc0 - bisected to commit
 31bfdb036f12
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <201709140009.v8E08n9S024108@mx0a-001b2d01.pphosted.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 14 Sep 2017 10:37:24 +1000
MIME-Version: 1.0
In-Reply-To: <201709140009.v8E08n9S024108@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <77fb14dd-26d5-a647-bed1-142d56d26374@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/09/17 10:07, Larry Finger wrote:
> When booting my PowerBook Aluminum G4, I get a pop-up screen that says 
> "The system is running in low-graphics  mode. Your screen, graphics 
> card, and input device settings could not be detected correctly. You 
> will need to configure these yourself." This is a big-endian 74xx CPU. 
> The lscpu command says it is a PowerBook5,6 model.
> 
> This problem has been bisected to commit 31bfdb036f12 ("powerpc: Use 
> instruction emulation infrastructure to handle alignment faults"). I am 
> confident of the accuracy of the bisection.
> 
> Attached is the configuration.

Try with https://patchwork.ozlabs.org/patch/813153/

(A selftest for the instruction emulation will make its way upstream 
eventually...)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
