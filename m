Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82BC01A0547
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:46:51 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 24 May 2014 11:46:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E6F473578048
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:46:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4O1P8UH12648780
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:25:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4O1klj8024311
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:46:47 +1000
Date: Sat, 24 May 2014 11:46:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140524014647.GA4900@shangw>
References: <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home>
 <20140523043722.GA11572@shangw>
 <76F750C7-EAA1-455F-A64F-BAB826F66281@suse.de>
 <20140523073720.GA5929@shangw> <537F1BBE.4030503@suse.de>
 <20140523115509.GA4042@shangw> <537F37FA.9090200@suse.de>
 <20140523124326.GA4778@shangw> <537F43C9.1080503@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537F43C9.1080503@suse.de>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 23, 2014 at 02:49:13PM +0200, Alexander Graf wrote:

.../...

>
>VFIO_EEH_RECOVER?
>

Then it should contain VFIO_EEH_PE_RESET, which is part of the
recovery. I don't expect the recovery to be done with one ioctl
command :-)

I personally prefer to keep VFIO_EEH_PE_CONFIUGRE, which means
the PE need configurtion/reconfiguration before error log retrieval
or after PE reset as defined in PAPR spec.

>So what if user space accesses config space while the device is
>broken? What if it accesses an mmap'ed BAR while the device is in
>broken state and BARs haven't been recovered yet?
>

If the "broken" means device can't funtion properly, any config,
IO, DMA traffic would cause "frozen" device (PE).

If the "broken" means "frozen" here. When the device is put into
frozen state, the config or IO access are dropped from hardware or
software level. So those requests can't reach to hardware under the
situation.

Thanks,
Gavin
