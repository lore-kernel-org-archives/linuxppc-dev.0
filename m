Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZGZg19mqzDqJ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:35:39 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v234XeeI053128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 23:35:37 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8dbyby-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 23:35:36 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 3 Mar 2017 14:35:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3CBAD2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:35:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v234ZNrv48759032
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 15:35:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v234YvFT011739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 15:34:58 +1100
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
 <87r32f6ldy.fsf@vajain21.in.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 3 Mar 2017 15:34:33 +1100
MIME-Version: 1.0
In-Reply-To: <87r32f6ldy.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3cb1fd20-028f-3e4e-6052-777236e6ae94@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/17 15:21, Vaibhav Jain wrote:
> Had a short chat discussion with Gavin Shan on this patchset and he
> preffers restoring the freeze_count on the eeh_pe once FRESET is done.
> He expects a the flow to be similar to one below
>
> 1. module caches the value of freeze_count and resets it
> 2. Issue warm reset
> 3. During eeh error-detected callback module restores the freeze_count
> from the cached value.

I'm inclined to think that's unnecessarily complex for relatively 
limited gain - I can't imagine there's that many people reflashing their 
CAPI devices so many times in quick succession that the counter won't 
hit 5 in a real failure case.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
