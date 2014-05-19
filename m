Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2EB51A007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 08:40:11 +1000 (EST)
Message-ID: <1400539200.3986.73.camel@pasglop>
Subject: Re: [PATCH 8/8] powerpc/powernv: Error injection infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 20 May 2014 08:40:00 +1000
In-Reply-To: <537A015D.8030202@suse.de>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-9-git-send-email-gwshan@linux.vnet.ibm.com>
 <537A015D.8030202@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-19 at 15:04 +0200, Alexander Graf wrote:
> On 14.05.14 06:12, Gavin Shan wrote:
> > The patch intends to implement the error injection infrastructure
> > for PowerNV platform. The predetermined handlers will be called
> > according to the type of injected error (e.g. OpalErrinjctTypeIoaBusError).
> > For now, we just support PCI error injection. We need support
> > injecting other types of errors in future.
> 
> Your token to a VFIO device is the VFIO fd. If you want to inject an 
> error into that device, you should do it via that token. That gets you 
> all permission problems solved for free.
> 
> But I still didn't quite grasp why you need to do this. Why do we need 
> to inject an error into a device via OPAL when we want to do EEH inside 
> of a guest? Are you trying to emulate guest side error injection?

Yes, that's what he's trying to do but let's keep that separate from
the core EEH. I'd like the latter to be reviewed /fixed and upstream
first, then we can look at guest side injection.

Cheers,
Ben.
