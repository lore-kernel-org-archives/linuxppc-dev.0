Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ACAB1A1DDA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:03:32 +1000 (AEST)
In-Reply-To: <1439532199-12099-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc/eeh: Probe after unbalanced kref check
Message-Id: <20150817080331.ED70D1402B6@ozlabs.org>
Date: Mon, 17 Aug 2015 18:03:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-14-08 at 06:03:19 UTC, Daniel Axtens wrote:
> In the complete hotplug case, EEH PEs are supposed to be released
> and set to NULL. Normally, this is done by eeh_remove_device(),
> which is called from pcibios_release_device().
> 
> However, if something is holding a kref to the device, it will not
> be released, and the PE will remain. eeh_add_device_late() has
> a check for this which will explictly destroy the PE in this case.
> 
> This check in eeh_add_device_late() occurs after a call to
> eeh_ops->probe(). On PowerNV, probe is a pointer to pnv_eeh_probe(),
> which will exit without probing if there is an existing PE.
> 
> This means that on PowerNV, devices with outstanding krefs will not
> be rediscovered by EEH correctly after a complete hotplug. This is
> affecting CXL (CAPI) devices in the field.
> 
> Put the probe after the kref check so that the PE is destroyed
> and affected devices are correctly rediscovered by EEH.
> 
> Fixes: d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
> Cc: stable@vger.kernel.org
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e642d11bdbfe8eb10116

cheers
