Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F46D1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 21:55:23 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 May 2014 17:25:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3FF8D394005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:25:15 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4NBtg1P45547698
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:25:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4NBtDx5014710
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 17:25:13 +0530
Date: Fri, 23 May 2014 21:55:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140523115509.GA4042@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home>
 <20140523043722.GA11572@shangw>
 <76F750C7-EAA1-455F-A64F-BAB826F66281@suse.de>
 <20140523073720.GA5929@shangw> <537F1BBE.4030503@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537F1BBE.4030503@suse.de>
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

On Fri, May 23, 2014 at 11:58:22AM +0200, Alexander Graf wrote:
>
>On 23.05.14 09:37, Gavin Shan wrote:
>>On Fri, May 23, 2014 at 08:55:15AM +0200, Alexander Graf wrote:
>>>>Am 23.05.2014 um 06:37 schrieb Gavin Shan <gwshan@linux.vnet.ibm.com>:
>>>>>On Thu, May 22, 2014 at 09:10:53PM -0600, Alex Williamson wrote:
>>>>>>On Thu, 2014-05-22 at 18:23 +1000, Gavin Shan wrote:
>>>>>>The patch adds new IOCTL commands for VFIO PCI device to support
>>>>>>EEH functionality for PCI devices, which have been passed through
>>>>>>from host to somebody else via VFIO.
>>.../...
>>
>>>>>>+
>>>>>>+/*
>>>>>>+ * Reset is the major step to recover problematic PE. The following
>>>>>>+ * command helps on that.
>>>>>>+ */
>>>>>>+struct vfio_eeh_pe_reset {
>>>>>>+    __u32 argsz;
>>>>>>+    __u32 option;
>>>>>>+};
>>>>>>+
>>>>>>+#define VFIO_EEH_PE_RESET        _IO(VFIO_TYPE, VFIO_BASE + 24)
>>>>>>+
>>>>>>+/*
>>>>>>+ * One of the steps for recovery after PE reset is to configure the
>>>>>>+ * PCI bridges affected by the PE reset.
>>>>>>+ */
>>>>>>+#define VFIO_EEH_PE_CONFIGURE        _IO(VFIO_TYPE, VFIO_BASE + 25)
>>>>>What can the user do differently by making these separate ioctls?
>>>>hrm, I didn't understood as well. Alex.G could have the explaination.
>>>Alex raised the same concern as me: why separate reset and configure? When we want to recover a device, we need a reset call anyway, right?
>>>
>>Ok. With current ioctl commands, "reset+configure" is required to do
>>error recovery. Before the recovery, we also need call "configure"
>>in order to retrieve error log correctly.
>
>Well, the "configure" ioctl (which is a really bad name for what it
>does btw) currently only restores the BARs which doesn't sound like
>error log retrieval to me.
>

Could you please suggest a better name? I had VFIO_EEH_PE_CONFIGURE because
it's for RTAS call "ibm,configure-pe".

>>Also, they corresponds to 2 separate RTAS services: "ibm,set-slot-reset"
>>and "ibm,configure-pe".
>
>Does a guest always issue both? What's the order it calls them in?
>

For one error, the following RTAS calls was called in general:

< stop device drivers, no PCI traffic expected during recovery >
ibm,set-eeh-option
ibm,configure-pe
< error log retrival >
ibm,set-slot-reset
ibm,read-slot-reset-state2
ibm,configure-pe
< resume device drivers >

We have other scenario. For example, PE reset failure and collect
the permanent log. Prior to that, "ibm,configure-pe" should be called.

Thanks,
Gavin


>
>Alex
>
