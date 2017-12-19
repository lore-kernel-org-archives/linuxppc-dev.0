Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0zBx6Gt7zDrSR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:23:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBJ0JSeH118574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 19:23:02 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exkbfamwx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 19:23:02 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 19 Dec 2017 00:23:00 -0000
Subject: Re: [PATCH 00/13] New driver to support OpenCAPI devices on POWER9
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com, linux-accelerators@lists.ozlabs.org
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 19 Dec 2017 11:22:55 +1100
MIME-Version: 1.0
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <68527540-291e-90cd-6fbd-4aea267d2723@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/17 02:21, Frederic Barrat wrote:
> This series adds support for Open Coherent Accelerator (ocxl) devices
> on POWER9 processor. OpenCAPI is a consortium developing the
> specifications for an interface between processors and accelerators,
> allowing sharing the host memory with the accelerators, using virtual
> addresses.
> 
> The OpenCAPI device can also have its own local memory and provide
> access to the host, though it is not supported by that series.
> 
> The OpenCAPI specification is processor agnostic, but this series adds
> support specifically for powerpc.
> 
> Even though the underlying transport is not PCI, the firmware
> abstracts the hardware like a PCI host bridge and Linux sees the
> OpenCAPI devices as PCI devices. So a lot of existing infrastructure
> and commands can be reused.
> 
> Patches 1-5:  add the platform-specific services needed by the driver
> Patches 6-10: driver code
> Patch 11:     small correction to existing cxl driver
> Patch 12:     documentation
> 
> Current limitations, that will be addressed in later patches:
>   - no capability to trigger a reset of the opencapi adapter
>   - no support for the 'wake_host_thread' command
>   - no support for adapters with a dual-link connection (none exists yet)
>   - no access to the adapter-local memory
> 
> Many people contributed directly or indirectly, from the software,
> hardware and bringup teams. In particular Andrew Donnellan and
> Alastair D'Silva, who are developing the related firmware and library.
> 
> Feedback welcome!

[+ linux-accelerators]

The corresponding patch series for skiboot/OPAL can be found at:

     https://patchwork.ozlabs.org/project/skiboot/list/?series=19043


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
