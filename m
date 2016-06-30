Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgPBS6M8kzDrJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 01:50:08 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UFj8iw087731
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:50:06 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23vvccxkvu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:50:06 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:50:04 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 56AFC1B08067
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:51:17 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UFo1gH8388964
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:50:01 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UFo1N4008058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 09:50:01 -0600
Subject: Re: [PATCH 1/2] cxl: Fix bug where AFU disable operation had no effect
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
 <57752A8A.1020501@linux.vnet.ibm.com>
 <1467298239-sup-4306@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 30 Jun 2016 17:50:00 +0200
MIME-Version: 1.0
In-Reply-To: <1467298239-sup-4306@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57753FA8.1080306@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/06/2016 17:32, Ian Munsie a écrit :
>> For dedicated mode, the CAIA recommends an explicit reset of the AFU
>> >(section 2.1.1).
> True, I had forgotten that procedure was added to the document before it
> was made public - I'll update the comment and resend.
>

Actually, my point was that for dedicated mode, we shouldn't have the 
"if" and always reset. It's only for dedicated mode, so it wouldn't 
impact cx4 and we would stay CAIA-compliant. If one day, there's a xsl 
with a dedicated mode AFU, they are expected to follow the spec.

   Fred
