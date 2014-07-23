Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 666741A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 23:07:32 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 08:17:01 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B98EB6E805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 08:15:09 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6NCFJQN60686482
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:15:19 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6NCFJEn027400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 08:15:19 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/powernv: Change BUG_ON to WARN_ON in elog code
In-Reply-To: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
References: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
Date: Wed, 23 Jul 2014 22:15:06 +1000
Message-ID: <m3fvhsi851.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> We can continue to read the error log (up to MAX size) even if
> we get the elog size more than MAX size. Hence change BUG_ON to
> WARN_ON.
>
> Also updated error message.
>
> Reported-by: Gopesh Kumar Chaudhary <gopchaud@in.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

So, it turns out the BUG_ON actually caught an FSP bug, at the very
least in their documentation.

The WARN_ON is probably the best thing we can do, along with the
OPAL/skiboot side fixes that I've mentioned separately.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
