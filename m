Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNXhQ6mzFzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 12:36:22 +1000 (AEST)
Message-ID: <1472524565.2388.26.camel@kernel.crashing.org>
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when
 removing vPHBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com,
 helgaas@kernel.org, imunsie@au1.ibm.com, felix@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, stable@vger.kernel.org
Date: Tue, 30 Aug 2016 12:36:05 +1000
In-Reply-To: <3049096a-97ea-9549-ee29-ae937708cf45@au1.ibm.com>
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <3049096a-97ea-9549-ee29-ae937708cf45@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-30 at 11:58 +1000, Andrew Donnellan wrote:
> Hi stable team,
> 
> The following patch, which ended up upstream as 
> 6f38a8b9a45833495dc878c335c5431cd98a16ed:
> 
> On 18/08/16 17:35, Andrew Donnellan wrote:
> > 
> > When cxl removes a vPHB, it's possible that the pci_controller may be freed
> > before all references to the devices on the vPHB have been released. This
> > in turn causes an invalid memory access when the devices are eventually
> > released, as pcibios_release_device() attempts to call the phb's
> > release_device hook.
> > 
> > In cxl_pci_vphb_remove(), remove the existing call to
> > pcibios_free_controller(). Instead, use
> > pcibios_free_controller_deferred() to free the pci_controller after all
> > devices have been released. Export pci_set_host_bridge_release() so we can
> > do this.
> > 
> > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > 
> > ---
> > 
> > > > This patch requires http://patchwork.ozlabs.org/patch/658324/. It should go
> > through the powerpc tree.
> 
> This depends on 2dd9c11b9d4dfbd6c070eab7b81197f65e82f1a0 which didn't 
> end up being tagged as cc: stable. It also ended up being applied in the 
> wrong order in the powerpc/fixes tree...

My fault. Best at this point is to also apply 2dd9c11b9d4dfbd6c070eab7b81197f65e82f1a0
to stable.

Cheers,
Ben.
