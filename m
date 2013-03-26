Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD78E2C0231
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 23:11:36 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 08:11:27 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 525616E803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 08:11:19 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QCBLs4203296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 08:11:21 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QCBKmw027254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 06:11:21 -0600
Date: Tue, 26 Mar 2013 17:36:26 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 2/4] uprobes: refuse uprobe on trap variants
Message-ID: <20130326120626.GB20399@linux.vnet.ibm.com>
References: <20130322151627.GB20010@in.ibm.com>
 <20130322151758.GC20010@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130322151758.GC20010@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Ananth N Mavinakayanahalli <ananth@in.ibm.com> [2013-03-22 20:47:58]:

> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Refuse to place a uprobe if a trap variant already exists in the
> file copy at the address.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  kernel/events/uprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-3.9-rc3/kernel/events/uprobes.c
> ===================================================================
> --- linux-3.9-rc3.orig/kernel/events/uprobes.c
> +++ linux-3.9-rc3/kernel/events/uprobes.c
> @@ -573,7 +573,7 @@ static int prepare_uprobe(struct uprobe
>  		goto out;
> 
>  	ret = -ENOTSUPP;
> -	if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
> +	if (is_trap_insn((uprobe_opcode_t *)uprobe->arch.insn))
>  		goto out;
> 
>  	ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, vaddr);

-- 
Thanks and Regards
Srikar Dronamraju
