Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ECA41A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:15:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Feb 2015 18:15:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DA9C62BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:15:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A8FeiF47382776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:15:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A8FFUK006992
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:15:15 +1100
Message-ID: <1423556085.4924.91.camel@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 19:14:45 +1100
In-Reply-To: <20150210062544.GB31098@richard>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com> <20150210015123.GC6326@richard>
 <1423534451.4924.79.camel@au1.ibm.com> <20150210062544.GB31098@richard>
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

On Tue, 2015-02-10 at 14:25 +0800, Wei Yang wrote:
> PF's resource will be assigned first, including normal BARs and IOV
> BARs.
> 
> Then PF's driver will create VFs, in virtfn_add(). In this function,
> VF's
> resources is calculated from its PF's IOV BAR.
> 
> If you reset VF's resource as PFs, no one will try to assign it again.

So the problem is that the flag indicating VF is lost ? IE. We should
still mark them unset, but preserve that flag ?

Cheers,
Ben.
