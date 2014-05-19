Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A3B31A04BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 23:04:34 +1000 (EST)
Message-ID: <537A015D.8030202@suse.de>
Date: Mon, 19 May 2014 15:04:29 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 8/8] powerpc/powernv: Error injection infrastructure
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-9-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.05.14 06:12, Gavin Shan wrote:
> The patch intends to implement the error injection infrastructure
> for PowerNV platform. The predetermined handlers will be called
> according to the type of injected error (e.g. OpalErrinjctTypeIoaBusError).
> For now, we just support PCI error injection. We need support
> injecting other types of errors in future.

Your token to a VFIO device is the VFIO fd. If you want to inject an 
error into that device, you should do it via that token. That gets you 
all permission problems solved for free.

But I still didn't quite grasp why you need to do this. Why do we need 
to inject an error into a device via OPAL when we want to do EEH inside 
of a guest? Are you trying to emulate guest side error injection?


Alex
