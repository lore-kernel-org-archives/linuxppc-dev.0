Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 610ED1A058E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:12:09 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 May 2014 18:12:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8AF372BB0062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:11:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4M8BeYW57475158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:11:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4M8BsEl021000
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:11:55 +1000
Date: Thu, 22 May 2014 18:11:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 3/4] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140522081145.GA28112@shangw>
References: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400648623-9127-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537CA50E.9090404@suse.de> <1400709391.29150.24.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400709391.29150.24.camel@pasglop>
Cc: aik@ozlabs.ru, Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 22, 2014 at 07:56:31AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-05-21 at 15:07 +0200, Alexander Graf wrote:
>
>> > +#ifdef CONFIG_VFIO_PCI_EEH
>> > +int eeh_vfio_open(struct pci_dev *pdev)
>> 
>> Why vfio? Also that config option will not be set if vfio is compiled as 
>> a module.
>> 
>> > +{
>> > +	struct eeh_dev *edev;
>> > +
>> > +	/* No PCI device ? */
>> > +	if (!pdev)
>> > +		return -ENODEV;
>> > +
>> > +	/* No EEH device ? */
>> > +	edev = pci_dev_to_eeh_dev(pdev);
>> > +	if (!edev || !edev->pe)
>> > +		return -ENODEV;
>> > +
>> > +	eeh_dev_set_passed(edev, true);
>> > +	eeh_pe_set_passed(edev->pe, true);
>> > +
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(eeh_vfio_open);
>
>Additionally, shouldn't we have some locking here ? (and in release too)
>
>I don't like relying on the caller locking (if it does it at all).
>

Ok. I'll add one mutex for open() and release() in next revision.
Thanks for the comment.

>> > +	/* Device existing ? */
>> > +	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
>> > +	if (ret) {
>> > +		pr_debug("%s: Cannot find device %s\n",
>> > +			__func__, pdev ? pci_name(pdev) : "NULL");
>> > +		*retval = -7;
>> 
>> What are these? Please use proper kernel internal return values for 
>> errors. I don't want to see anything even remotely tied to RTAS in any 
>> of these patches.
>
>Hint: -ENODEV
>

In next revision, Those exported functions will have return value as:

>= 0:	carrried information to caller.
<  0:   error number.

Thanks,
Gavin
