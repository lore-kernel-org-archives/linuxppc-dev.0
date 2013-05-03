Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 987672C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:04:16 +1000 (EST)
Message-ID: <1367622108.4389.129.camel@pasglop>
Subject: Re: [PATCHv5 0/2] Speed Cap fixes for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Date: Sat, 04 May 2013 09:01:48 +1000
In-Reply-To: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Brian King <brking@linux.vnet.ibm.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 19:43 -0300, Kleber Sacilotto de Souza wrote:

> This patch series does:
>   1. max_bus_speed is used to set the device to gen2 speeds
>   2. on power there's no longer a conflict between the pseries call and other
> architectures, because the overwrite is done via a ppc_md hook
>   3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask
> for gen2 capability detection
> 
> The first patch consists of some architecture changes, such as adding a hook on
> powerpc for pci_root_bridge_prepare, so that pseries will initialize it to a
> function, while all other architectures get a NULL pointer. So that whenever
> pci_create_root_bus is called, we'll get max_bus_speed properly setup from
> OpenFirmware.
> 
> The second patch consists of simple radeon changes not to call
> drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines,
> the max_bus_speed property will be properly set already.

So I'm ok with the approach now and I might even put the powerpc patch
in for 3.10 since arguably we are fixing a nasty bug (uninitialized
max_bus_speed).

David, what's your feeling about the radeon change ? It would be nice if
that could go in soon for various distro targets :-) On the other hand
I'm not going to be pushy if you are not comfortable with it.

Cheers,
Ben.
