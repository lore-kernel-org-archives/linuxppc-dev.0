Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BFF661400CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 09:27:27 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 31 Mar 2014 03:57:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9DA0B125803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 03:59:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2UMRITV3211750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 03:57:18 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2UMRJO5008662
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 03:57:19 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
In-Reply-To: <20140328073344.26823.32931.stgit@bahia.local>
References: <20140328073344.26823.32931.stgit@bahia.local>
Date: Mon, 31 Mar 2014 09:27:16 +1100
Message-ID: <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
>  struct rtas_error_log {
> +#ifdef __BIG_ENDIAN__
> +	/* Byte 0 */
>  	unsigned long version:8;		/* Architectural version */
> +	/* Byte 1 */

I think it would be great if we got rid of the usage of bitfields. As
soon as the mood of the compiler changes, this code is going to break.
