Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8C8E1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:37:24 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 May 2014 17:37:23 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0E7712CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:37:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4N7FgLm55509190
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:15:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4N7bJnN025915
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:37:20 +1000
Date: Fri, 23 May 2014 17:37:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140523073720.GA5929@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home>
 <20140523043722.GA11572@shangw>
 <76F750C7-EAA1-455F-A64F-BAB826F66281@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <76F750C7-EAA1-455F-A64F-BAB826F66281@suse.de>
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

On Fri, May 23, 2014 at 08:55:15AM +0200, Alexander Graf wrote:
>> Am 23.05.2014 um 06:37 schrieb Gavin Shan <gwshan@linux.vnet.ibm.com>:
>>> On Thu, May 22, 2014 at 09:10:53PM -0600, Alex Williamson wrote:
>>>> On Thu, 2014-05-22 at 18:23 +1000, Gavin Shan wrote:
>>>> The patch adds new IOCTL commands for VFIO PCI device to support
>>>> EEH functionality for PCI devices, which have been passed through
>>>> from host to somebody else via VFIO.

.../...

>>>> +
>>>> +/*
>>>> + * Reset is the major step to recover problematic PE. The following
>>>> + * command helps on that.
>>>> + */
>>>> +struct vfio_eeh_pe_reset {
>>>> +    __u32 argsz;
>>>> +    __u32 option;
>>>> +};
>>>> +
>>>> +#define VFIO_EEH_PE_RESET        _IO(VFIO_TYPE, VFIO_BASE + 24)
>>>> +
>>>> +/*
>>>> + * One of the steps for recovery after PE reset is to configure the
>>>> + * PCI bridges affected by the PE reset.
>>>> + */
>>>> +#define VFIO_EEH_PE_CONFIGURE        _IO(VFIO_TYPE, VFIO_BASE + 25)
>>> 
>>> What can the user do differently by making these separate ioctls?
>> 
>> hrm, I didn't understood as well. Alex.G could have the explaination.
>
>Alex raised the same concern as me: why separate reset and configure? When we want to recover a device, we need a reset call anyway, right?
>

Ok. With current ioctl commands, "reset+configure" is required to do
error recovery. Before the recovery, we also need call "configure"
in order to retrieve error log correctly.

Also, they corresponds to 2 separate RTAS services: "ibm,set-slot-reset"
and "ibm,configure-pe".

Thanks,
Gavin
