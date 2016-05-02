Return-Path: <chris@distroguy.com>
Received: from mx-out03.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qypDm5TdNzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 12:30:15 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out03.mykolab.com (Postfix) with ESMTPS id 0FF7D2020D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 04:30:08 +0200 (CEST)
Date: Mon, 2 May 2016 12:30:01 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Add null property check to
 pseries_discover_pic()
Message-ID: <20160502023000.GB31022@distroguy.com>
References: <1461822825-21542-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1461822825-21542-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 28, 2016 at 03:53:45PM +1000, Suraj Jitindar Singh wrote:
>The return value of of_get_property() isn't checked before it is passed
>to the strstr() function, if it happens that the return value is null
>then this will result in a null pointer being dereferenced.
>
>Add a check to see if the return value of of_get_property() is null and
>if it is continue straight on to the next node.
>

Hi Suraj,

Presumably machines have been shipping with a device tree that contains
"compatible" in the interrupt controller section and so we just happen
to have never hit this. Good thing to check.

Confirming that strstr calls strlen on the first argument, which would
dereference a null pointer.

Reviewed-by: Chris Smart <chris@distroguy.com>

>Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>---
> arch/powerpc/platforms/pseries/setup.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>index 6e944fc..fa73494 100644
>--- a/arch/powerpc/platforms/pseries/setup.c
>+++ b/arch/powerpc/platforms/pseries/setup.c
>@@ -235,6 +235,8 @@ static void __init pseries_discover_pic(void)
>
> 	for_each_node_by_name(np, "interrupt-controller") {
> 		typep = of_get_property(np, "compatible", NULL);
>+		if (!typep)
>+			continue;
> 		if (strstr(typep, "open-pic")) {
> 			pSeries_mpic_node = of_node_get(np);
> 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
>-- 
>2.5.0
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
