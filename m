Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2BB41A0A2C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 09:14:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 08:14:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 814892CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 09:14:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3MEN2B36307154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 09:14:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3MENHW014914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 09:14:23 +1100
Date: Thu, 4 Dec 2014 09:14:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: drop useless warning in eeh_init()
Message-ID: <20141203221422.GA4927@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141125222846.GA7662@shangw>
 <20141203152046.5c109d1f@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141203152046.5c109d1f@bahia.local>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2014 at 03:20:46PM +0100, Greg Kurz wrote:
>On Wed, 26 Nov 2014 09:28:47 +1100
>Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> On Tue, Nov 25, 2014 at 05:10:06PM +0100, Greg Kurz wrote:
>> >This is what we get in dmesg when booting a pseries guest and
>> >the hypervisor doesn't provide EEH support.
>> >
>> >[    0.166655] EEH functionality not supported
>> >[    0.166778] eeh_init: Failed to call platform init function (-22)
>> >
>> >Since both powernv_eeh_init() and pseries_eeh_init() already complain when
>> >hitting an error, it is not needed to print more (especially such an
>> >uninformative message).
>> >
>> >Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>> 
>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> 
>> Thanks,
>> Gavin
>> 
>
>Ping ?
>

It's already in Michael's git tree.

shangw@shangw:~/sandbox/linux.ppc$ git remote -v
origin	git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git (fetch)
origin	git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git (push)
shangw@shangw:~/sandbox/linux.ppc$ git branch 
  master
* next
shangw@shangw:~/sandbox/linux.ppc$ git log --author="Greg Kurz" --oneline
      1 221195f powerpc: Drop useless warning in eeh_init()

Thanks,
Gavin

>> >---
>> > arch/powerpc/kernel/eeh.c |    5 +----
>> > 1 file changed, 1 insertion(+), 4 deletions(-)
>> >
>> >diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> >index 2248a19..7d62018 100644
>> >--- a/arch/powerpc/kernel/eeh.c
>> >+++ b/arch/powerpc/kernel/eeh.c
>> >@@ -920,11 +920,8 @@ int eeh_init(void)
>> > 		pr_warn("%s: Platform EEH operation not found\n",
>> > 			__func__);
>> > 		return -EEXIST;
>> >-	} else if ((ret = eeh_ops->init())) {
>> >-		pr_warn("%s: Failed to call platform init function (%d)\n",
>> >-			__func__, ret);
>> >+	} else if ((ret = eeh_ops->init()))
>> > 		return ret;
>> >-	}
>> > 
>> > 	/* Initialize EEH event */
>> > 	ret = eeh_event_init();
>> >
>> >_______________________________________________
>> >Linuxppc-dev mailing list
>> >Linuxppc-dev@lists.ozlabs.org
>> >https://lists.ozlabs.org/listinfo/linuxppc-dev
>> 
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
