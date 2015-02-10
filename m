Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51CDC1A0292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:27:21 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Feb 2015 10:27:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 81B632BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:27:16 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A0R8YW33292350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:27:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A0Qgg8024136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:26:43 +1100
Message-ID: <1423527979.4924.67.camel@au1.ibm.com>
Subject: Re: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 11:26:19 +1100
In-Reply-To: <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
> +       if ((retval = pcibios_sriov_enable(dev, initial))) {
> +               dev_err(&dev->dev, "Failure %d from
> pcibios_sriov_setup()\n",
> +                       retval);
> +               return retval;
> +       }
> +

Don't we want pcibios_sriov_enable() to be able to crop the number
of VFs or do we think any resource limits have been applied
already ?

Ben.
