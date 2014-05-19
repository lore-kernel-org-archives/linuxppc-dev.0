Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67C111A04BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 08:39:00 +1000 (EST)
Message-ID: <1400539128.3986.72.camel@pasglop>
Subject: Re: [PATCH 6/8] powerpc: Extend syscall ppc_rtas()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 20 May 2014 08:38:48 +1000
In-Reply-To: <5379FF4C.7080202@suse.de>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-7-git-send-email-gwshan@linux.vnet.ibm.com>
 <5379FF4C.7080202@suse.de>
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

On Mon, 2014-05-19 at 14:55 +0200, Alexander Graf wrote:
> On 14.05.14 06:12, Gavin Shan wrote:
> > Originally, syscall ppc_rtas() can be used to invoke RTAS call from
> > user space. Utility "errinjct" is using it to inject various errors
> > to the system for testing purpose. The patch intends to extend the
> > syscall to support both pSeries and PowerNV platform. With that,
> > RTAS and OPAL call can be invoked from user space. In turn, utility
> > "errinjct" can be supported on pSeries and PowerNV platform at same
> > time.
> >
> > The original syscall handler ppc_rtas() is renamed to ppc_firmware(),
> > which calls ppc_call_rtas() or ppc_call_opal() depending on the
> > running platform. The data transported between userland and kerenl is
> 
> Please fix your spelling of kernel.
> 
> > by "struct rtas_args". It's platform specific on how to use the data.
> >
> > Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> I think the basic idea to maintain the same interface between PAPR and 
> OPAL to user space is sound, but this is really Ben's call.

Yeah that worries me a bit, RTAS and OPAL are completely different
beasts.

We can keep that error injection separate from the rest of the EEH
enablement for now. I'll look at it when I get a chance.

Cheers,
Ben.
