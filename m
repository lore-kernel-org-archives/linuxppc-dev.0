Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C98DB1A086B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:23:28 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 20:23:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 90CFD2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:23:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KAN8nc11600336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:23:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KANNXu012377
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:23:23 +1000
Date: Tue, 20 May 2014 20:23:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/8] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Message-ID: <20140520102320.GA10141@shangw>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400538790.3289.305.camel@ul30vt.home>
 <20140520002208.GA11073@shangw>
 <1400546244.3289.341.camel@ul30vt.home>
 <20140520082856.GA16050@shangw> <537B282E.6040107@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537B282E.6040107@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
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

On Tue, May 20, 2014 at 12:02:22PM +0200, Alexander Graf wrote:
>
>On 20.05.14 10:28, Gavin Shan wrote:
>>On Mon, May 19, 2014 at 06:37:24PM -0600, Alex Williamson wrote:
>>>On Tue, 2014-05-20 at 10:22 +1000, Gavin Shan wrote:
>>>>On Mon, May 19, 2014 at 04:33:10PM -0600, Alex Williamson wrote:
>>>>>On Wed, 2014-05-14 at 14:11 +1000, Gavin Shan wrote:
>>>>>>The patch adds new IOCTL command VFIO_EEH_INFO to VFIO container
>>>>>>to support EEH functionality for PCI devices, which have been
>>>>>>passed from host to guest via VFIO.
>
>[...]
>
>>>>diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>index cb9023d..1fd1bfb 100644
>>>>--- a/include/uapi/linux/vfio.h
>>>>+++ b/include/uapi/linux/vfio.h
>>>>@@ -455,6 +455,63 @@ struct vfio_iommu_spapr_tce_info {
>>>>  #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>>>>+/*
>>>>+ * The VFIO EEH info struct provides way to support EEH functionality
>>>>+ * for PCI device that is passed from host to guest via VFIO.
>>>>+ */
>>>>+#define VFIO_EEH_OP_MAP		0
>>>>+#define VFIO_EEH_OP_UNMAP	1
>>>>+#define VFIO_EEH_OP_SET_OPTION	2
>>>>+#define VFIO_EEH_OP_GET_ADDR	3
>>>>+#define VFIO_EEH_OP_GET_STATE	4
>>>>+#define VFIO_EEH_OP_PE_RESET	5
>>>>+#define VFIO_EEH_OP_PE_CONFIG	6
>>>>>Is this really an "info" ioctl?
>>>>>
>>>>Yeah, "VFIO_EEH_INFO" isn't a good name. How about to have "VFIO_EEH_HANDLER" ?
>>>VFIO_EEH_OP perhaps.  Thanks,
>>>
>>Ok. Will rename it to VFIO_EEH_OP in next revision.
>
>Is there any benefit of a multiplexing EEH ioctl over just 7
>individual ioctls?
>

One benefit is pass one data struct to the real handler implemented
in arch/powerpc/platforms/powernv/eeh-vfio.c. With 7 commands, we
either passing "void *arg" + "command" to the handler, or export
7 functions with EXPORT_SYMBOL_GPL().

I just send RFCv4 out. VFIO_EEH_OP_{MAP, UNMAP} is removed there.

Thanks,
Gavin
