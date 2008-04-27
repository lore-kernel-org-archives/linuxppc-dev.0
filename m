Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 4B4DCDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 06:23:48 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1157721anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 13:23:46 -0700 (PDT)
Message-ID: <fa686aa40804271323l634674b2y2bb54d9c3d35100c@mail.gmail.com>
Date: Sun, 27 Apr 2008 14:23:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] [PPC] Add strncmp to arch/ppc
In-Reply-To: <1208825427.6654.46.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
	<1208825427.6654.46.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 6:50 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> Commit 0119536cd314ef95553604208c25bc35581f7f0a added an assembly version
>  of strncmp to PowerPC.  However, it changed a common header file between
>  arch/ppc and arch/powerpc without adding strncmp to arch/ppc.  This fixes
>  that omission so that arch/ppc links again.
>
>  Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
>  ---
>   arch/ppc/kernel/ppc_ksyms.c |    1 +
>   arch/ppc/lib/string.S       |   14 ++++++++++++++
>   2 files changed, 15 insertions(+)
>
>  --- linux-2.6.orig/arch/ppc/kernel/ppc_ksyms.c
>  +++ linux-2.6/arch/ppc/kernel/ppc_ksyms.c
>  @@ -89,6 +89,7 @@ EXPORT_SYMBOL(strncpy);
>   EXPORT_SYMBOL(strcat);
>   EXPORT_SYMBOL(strlen);
>   EXPORT_SYMBOL(strcmp);
>  +EXPORT_SYMBOL(strncmp);
>
>   EXPORT_SYMBOL(csum_partial);
>   EXPORT_SYMBOL(csum_partial_copy_generic);
>  --- linux-2.6.orig/arch/ppc/lib/string.S
>  +++ linux-2.6/arch/ppc/lib/string.S
>  @@ -121,6 +121,20 @@ _GLOBAL(strcmp)
>         beq     1b
>         blr
>
>  +_GLOBAL(strncmp)
>  +       PPC_LCMPI r5,0
>  +       beqlr
>  +       mtctr   r5
>  +       addi    r5,r3,-1
>  +       addi    r4,r4,-1
>  +1:     lbzu    r3,1(r5)
>  +       cmpwi   1,r3,0
>  +       lbzu    r0,1(r4)
>  +       subf.   r3,r0,r3
>  +       beqlr   1
>  +       bdnzt   eq,1b
>  +       blr
>  +
>   _GLOBAL(strlen)
>         addi    r4,r3,-1
>   1:     lbzu    r0,1(r4)
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
