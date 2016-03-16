Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ91z4KrgzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 22:56:39 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (unknown [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQ91z37cTz9sD1
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 22:56:39 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 16 Mar 2016 21:46:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3979C3578052
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 22:46:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2GBkDcg44237026
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 22:46:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2GBjnkh017742
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 22:45:49 +1100
Message-ID: <1458128720.3107.66.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix possible unrecoverable exception caused by
 '70fe3d9'
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Cyril Bur <cyrilbur@gmail.com>, mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Date: Wed, 16 Mar 2016 22:45:20 +1100
In-Reply-To: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
References: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-16 at 13:29 +1100, Cyril Bur wrote:
> +#ifdef CONFIG_PPC_BOOK3S
> +       ld      r10,PACAKMSR(r13)
> +       li      r9,MSR_RI
> +       andc    r11,r10,r9 /* Re-clear RI */
> +       mtmsrd  r11,1
> +#endif

Do you need that ? IE, mtmsrd with "1" will only update RI and EE, is
the value of EE in PACAMSR variable ?

Cheers,
Ben.
