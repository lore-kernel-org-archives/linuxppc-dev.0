Return-Path: <prodyuth@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 0C494DDFB7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 08:37:36 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so211174ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 15:37:34 -0700 (PDT)
Message-ID: <49c0ff980809111537n6ff426f9w6a7629588051ac10@mail.gmail.com>
Date: Thu, 11 Sep 2008 15:37:32 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
In-Reply-To: <1221083587-8091-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>        /*
>         * Create WS1. This is the faulting address (EPN),
>         * page size, and valid flag.
>         */
> -       li      r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
> +       li      r11,PPC44x_TLB_VALID | PPC44x_TLBE_SIZE
>        rlwimi  r10,r11,0,20,31                 /* Insert valid and page size*/
>        tlbwe   r10,r13,PPC44x_TLB_PAGEID       /* Write PAGEID */
>

Change
>        rlwimi  r10,r11,0,20,31                 /* Insert valid and page size*/
to
>        rlwimi  r10,r11,0,PPC44x_PTE_ADD_M1,31                 /* Insert valid and page size*/
