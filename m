Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFXTv49t8zDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 03:02:59 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7IGxFjo081459
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 13:02:57 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vky53u7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 13:02:56 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 11:02:55 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing
 vPHBs
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Thu, 18 Aug 2016 12:02:42 -0500
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, mauricfo@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
 ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 felix@linux.vnet.ibm.com
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <0170D6B7-1005-47B5-9DC7-EC55846D2DA2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Aug 18, 2016, at 2:35 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> When cxl removes a vPHB, it's possible that the pci_controller may be =
freed
> before all references to the devices on the vPHB have been released. =
This
> in turn causes an invalid memory access when the devices are =
eventually
> released, as pcibios_release_device() attempts to call the phb's
> release_device hook.
>=20
> In cxl_pci_vphb_remove(), remove the existing call to
> pcibios_free_controller(). Instead, use
> pcibios_free_controller_deferred() to free the pci_controller after =
all
> devices have been released. Export pci_set_host_bridge_release() so we =
can
> do this.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
