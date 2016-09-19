Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scw3P0WZbzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:50:40 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5hQNs029348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:50:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h2bhy2kc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:50:38 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 01:50:37 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
In-Reply-To: <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
Date: Mon, 19 Sep 2016 11:20:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvj4xwt6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Christophe Leroy <christophe.leroy@c-s.fr> writes:
> +#else
> +static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
> +{
> +	BUG();
> +}
> +
>  #endif


I was expecting that BUG will get removed in the next patch. But I don't
see it in the next patch. Considering

@@ -475,11 +453,10 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
        for (i = 0; i < num_hugepd; i++, hpdp++)
                hpdp->pd = 0;

-#ifdef CONFIG_PPC_FSL_BOOK3E
-	hugepd_free(tlb, hugepte);
-#else
-	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
-#endif
+	if (shift >= pdshift)
+		hugepd_free(tlb, hugepte);
+	else
+		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
 }

What is that I am missing ?

-aneesh
