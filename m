Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C6BB1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 18:21:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 17:21:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A43623578072
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 18:21:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB47LKVl35127514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 18:21:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB47LKWP023700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 18:21:20 +1100
Date: Thu, 4 Dec 2014 15:21:18 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pci: remove pci device on a bus in reverse order
Message-ID: <20141204072117.GA9978@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1417663477-9124-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141204054035.C3DAC1400E9@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141204054035.C3DAC1400E9@ozlabs.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 04, 2014 at 04:40:35PM +1100, Michael Ellerman wrote:
>On Thu, 2014-04-12 at 03:24:37 UTC, Wei Yang wrote:
>> As in commit ac205b7b (PCI: make sriov work with hotplug remove) indicates,
>> when removing pci devices on a bus which has VFs, we need to remove them in
>> the reverse order.
>> 
>> This patch applies this pattern on the hotplug remove path on powerpc arch.
>
>So is this is a bug fix?

It hasn't trigger a bug yet. I found this issue during the code reading. When
VFs are enabled and try to remove a bus with VFs, it will face a problem. So I
port the change in commit ac205b7b here.

>
>Where/how have you tested this?

I have tested after change on Power8, the EEH hotplug path works fine for PFs
now. Will test this when EEH for VFs are ready.

Suggest me to keep it untill EEH for VFs are ready?

>
>cheers

-- 
Richard Yang
Help you, Help me
