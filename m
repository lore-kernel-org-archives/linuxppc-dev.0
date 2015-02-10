Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C614D1A0142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:14:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Feb 2015 12:14:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 05EBB2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:14:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2E3tx47579270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:14:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2DcdX014324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:13:38 +1100
Message-ID: <1423534394.4924.78.camel@au1.ibm.com>
Subject: Re: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:13:14 +1100
In-Reply-To: <20150210013532.GA6326@richard>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423527979.4924.67.camel@au1.ibm.com> <20150210013532.GA6326@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 09:35 +0800, Wei Yang wrote:
> >Don't we want pcibios_sriov_enable() to be able to crop the number
> >of VFs or do we think any resource limits have been applied
> >already ?
> 
> The second parameter "initial" is the number of VFs will be enabled.
> Arch
> dependent function will check the resources for these number of VFs.
> 
> Do I catch your question correctly?

I was wondering if the number of resource that can be enabled is
smaller, should the arch function be able to return that smaller
number and we would still enable that number ?

Ie, have the arch function be able to "update" the value of
"initial" (by passing it by pointer for example).

Cheers,
Ben.
