Return-Path: <haveblue@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38C76679EB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 10:55:29 +1100 (EST)
Received: from e5.ny.us.ibm.com (e5.pok.ibm.com [9.56.232.145])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMFoii009394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:15:50 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMFauA005980
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:15:36 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMFNfG111870
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:15:23 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2VMFMeO004022
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:15:23 -0500
Subject: Re: [PATCH 1/2] Base pSeries PCIe support
From: Dave Hansen <haveblue@us.ibm.com>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <20060331160545.db3fa210.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331160545.db3fa210.moilanen@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 14:15:11 -0800
Message-Id: <1143843311.9731.111.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-03-31 at 16:05 -0600, Jake Moilanen wrote:
> --- 2.6.16.orig/arch/powerpc/kernel/rtas_pci.c  2006-03-31 15:11:20.000000000 -0600
> +++ 2.6.16/arch/powerpc/kernel/rtas_pci.c       2006-03-31 15:15:35.000000000 -0600
> @@ -315,7 +315,8 @@
>         for (node = of_get_next_child(root, NULL);
>              node != NULL;
>              node = of_get_next_child(root, node)) {
> -               if (node->type == NULL || strcmp(node->type, "pci") != 0)
> +
> +               if (node->type == NULL || ((strcmp(node->type, "pci") != 0) && (strcmp(node->type, "pciex") != 0)))
>                         continue; 

That one looks to have gone a wee bit over 80 columns.

-- Dave
