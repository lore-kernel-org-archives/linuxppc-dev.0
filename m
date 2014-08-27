Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B3E21A00EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 15:17:56 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 27 Aug 2014 10:47:53 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D614CE0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:50:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7R5IDmu20316318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:48:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7R5HnKK002396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:47:49 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, aik@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Add private HCALL to inform updated RTAS base and entry
In-Reply-To: <20140825130010.1029.65141.stgit@aravindap>
References: <20140825130010.1029.65141.stgit@aravindap>
Date: Wed, 27 Aug 2014 10:47:46 +0530
Message-ID: <87bnr67bph.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

> This patch adds a private HCALL to inform qemu the updated
> rtas-base and rtas-entry address when OS invokes the call
> "instantiate-rtas". This is required as qemu allocates the
> error reporting structure in RTAS space upon a machine check
> exception and hence needs to know the updated RTAS.
>
> Enhancements to qemu to handle the private HCALL, prepare
> error log and invoke machine check notification routine
> are in a separate patch.
>
> Signed-off-by: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Thanks, applied.

> ---
>  board-qemu/slof/rtas.fs   |    6 +++++-
>  lib/libhvcall/hvcall.code |    6 ++++++
>  lib/libhvcall/hvcall.in   |    1 +
>  lib/libhvcall/libhvcall.h |    4 +++-
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/board-qemu/slof/rtas.fs b/board-qemu/slof/rtas.fs
> index 41e30c2..c081b57 100644
> --- a/board-qemu/slof/rtas.fs
> +++ b/board-qemu/slof/rtas.fs
> @@ -174,7 +174,11 @@ rtas-node set-node
>
>  : instantiate-rtas ( adr -- entry )
>      dup rtas-base swap rtas-size move
> -    rtas-entry rtas-base - +
> +    dup rtas-entry rtas-base - +
> +    2dup hv-rtas-update 0 <> IF
> +    ." Failed to update RTAS " cr
> +    THEN
> +    nip   
>  ;
>
>  device-end
> diff --git a/lib/libhvcall/hvcall.code b/lib/libhvcall/hvcall.code
> index 744469f..0ff50f2 100644
> --- a/lib/libhvcall/hvcall.code
> +++ b/lib/libhvcall/hvcall.code
> @@ -111,6 +111,12 @@ PRIM(hv_X2d_cas)
>  	TOS.u = hv_cas(vec, buf, size);
>  MIRP
>
> +PRIM(hv_X2d_rtas_X2d_update)
> +	unsigned long rtas_entry   = TOS.u; POP;
> +	unsigned long rtas_base    = TOS.u;
> +	TOS.u = hv_generic(KVMPPC_H_RTAS_UPDATE, rtas_base, rtas_entry);
> +MIRP
> +
>  PRIM(get_X2d_print_X2d_version)
>  	unsigned long addr = TOS.u; POP;
>  	get_print_banner(addr);
> diff --git a/lib/libhvcall/hvcall.in b/lib/libhvcall/hvcall.in
> index e99d6d1..4437b77 100644
> --- a/lib/libhvcall/hvcall.in
> +++ b/lib/libhvcall/hvcall.in
> @@ -30,4 +30,5 @@ cod(RX!)
>
>  cod(hv-logical-memop)
>  cod(hv-cas)
> +cod(hv-rtas-update)
>  cod(get-print-version)
> diff --git a/lib/libhvcall/libhvcall.h b/lib/libhvcall/libhvcall.h
> index 6356a62..193b738 100644
> --- a/lib/libhvcall/libhvcall.h
> +++ b/lib/libhvcall/libhvcall.h
> @@ -24,7 +24,9 @@
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_H_REPORT_MC_ERR  (KVMPPC_HCALL_BASE + 0x4)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_NMI_MCE
>
>  #ifndef __ASSEMBLY__
