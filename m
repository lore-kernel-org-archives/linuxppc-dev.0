Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s55tN51J7zDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 09:36:28 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74NTFn8029408
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 19:36:25 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkahmmvh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 19:36:24 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 5 Aug 2016 09:36:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 22A632CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 09:36:20 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74NaJgx25624714
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 09:36:19 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74NaI2H003713
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 09:36:19 +1000
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
To: York Sun <york.sun@nxp.com>, linux-edac@vger.kernel.org
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
Cc: morbidrsa@gmail.com, oss@buserror.net, stuart.yoder@nxp.com, bp@alien8.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Kevin Hao <haokexin@gmail.com>,
 Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 5 Aug 2016 09:36:15 +1000
MIME-Version: 1.0
In-Reply-To: <1470351518-22404-2-git-send-email-york.sun@nxp.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8a1cbb34-1e5a-a7ee-1fc6-e6bd5db34aa1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/16 08:58, York Sun wrote:
> Two symbols are missing if mpc85xx_edac driver is compiled as module.
>
> Signed-off-by: York Sun <york.sun@nxp.com>

Good catch! One comment below.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

>  /*
>   * Reads the interrupt pin to determine if interrupt is use by card.
> @@ -1585,6 +1586,7 @@ int early_find_capability(struct pci_controller *hose, int bus, int devfn,
>  {
>  	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
>  }
> +EXPORT_SYMBOL(early_find_capability);

It'd be nicer for this to be renamed as "pci_early_find_capability" or 
something like that with a "namespace", I think.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
