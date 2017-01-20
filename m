Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4tFf2kyDzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 07:52:54 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0KKmedf006188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 15:52:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 282ybhd2da-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 15:52:51 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 20 Jan 2017 13:52:49 -0700
Subject: Re: powerpc/nvram: Move an assignment for the variable "ret" in
 dev_nvram_write()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org
References: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
 <dcaccc31-99ac-ef90-cbef-79dbf72f0a4d@users.sourceforge.net>
 <52f46c9b-e049-7288-2c53-9c2525cd84c6@linux.vnet.ibm.com>
 <b0958392-8325-4f56-cded-0ff6691893cf@users.sourceforge.net>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Geliang Tang <geliangtang@163.com>, Paul Mackerras <paulus@samba.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 12:52:44 -0800
MIME-Version: 1.0
In-Reply-To: <b0958392-8325-4f56-cded-0ff6691893cf@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <cbd6e372-111e-c73a-713b-62d7abd7ddfd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2017 11:08 PM, SF Markus Elfring wrote:
>> I think you really could have squashed patches 1-3 into a single patch
>> that returns directly after any failure.
> 
> Thanks for your constructive feedback.
> 
> I have got software development concerns around such patch squashing.
> 
> 
>> At this point you might as well remove that label and move the kfree(tmp) call up
>> and return directly after the failure and at the nvram_write() call site
>> doing away completely with the "ret" variable.
> 
> Your idea might look nice at first glance. But I would interpret the previous
> implementation of the discussed function in the way that the memory which was
> dynamically allocated here should always (not only in the failure case) be released
> before returning here.

You are correct. I did muck that part up. However, I do still believe it
is cleaner to squash your three patches together. There is no functional
change here and it is clearer in a single patch that you are modifying
the function to return directly in the simple error cases.

-Tyrel

> 
> Would you really like to change the life time for this “temporary” data item?
> 
> Regards,
> Markus
> 
