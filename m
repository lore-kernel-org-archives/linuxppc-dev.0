Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 231F81A0817
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:54:27 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 09:54:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9C5CA2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:54:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4JNWuhT6619402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:32:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4JNsKkA026673
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:54:21 +1000
Date: Tue, 20 May 2014 09:54:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/8] powerpc/eeh: Info to trace passed devices
Message-ID: <20140519235420.GA7042@shangw>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <5379FD19.2020100@suse.de> <1400539049.3986.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400539049.3986.71.camel@pasglop>
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

On Tue, May 20, 2014 at 08:37:29AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2014-05-19 at 14:46 +0200, Alexander Graf wrote:
>> I don't see the point of VFIO knowing about guest addresses. They are 
>> not unique across a system and the whole idea that a VFIO device has to 
>> be owned by a guest is also pretty dubious.
>> 
>> I suppose what you really care about here is just a token for a specific 
>> device? But why do you need one where we don't have tokens yet?
>
>I think this is going to be needed when doing in-kernel acceleration
>of some of the RTAS calls, but yes, Gavin, why do we need that now ?
>

Thanks for your comments :-)

For now, the newly introduced IOCTL command (VFIO_EEH_INFO) is handled by
VFIO-Container fd, which can't identify IOMMU group (PE) or VFIO-PCI-dev
naturally because one VFIO-container can have multiple IOMMU groups docked
there. I'm going to let VFIO-PCI-dev fd handle the IOCTL command because
VFIO-PCI-dev fd can identify the device and the corresponding IOMMU group
(PE). With that, the address mapping stuff isn't necessary.

Thanks,
Gavin 
