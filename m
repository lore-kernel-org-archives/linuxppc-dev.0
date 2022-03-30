Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1150BC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Mar 2022 02:08:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KSqb32Xnwz3c2M
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Mar 2022 13:07:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=srs0=x/co=uj=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KSqZd4nBXz2xgY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2022 13:07:37 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0093261372;
 Wed, 30 Mar 2022 02:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEAAC340ED;
 Wed, 30 Mar 2022 02:07:34 +0000 (UTC)
Date: Tue, 29 Mar 2022 22:07:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] ftrace: Make ftrace_graph_is_dead() a static branch
Message-ID: <20220329220733.682172ec@gandalf.local.home>
In-Reply-To: <8628338322fa74287ca8d432d5c0c1964acd6f2a.1648195329.git.christophe.leroy@csgroup.eu>
References: <8628338322fa74287ca8d432d5c0c1964acd6f2a.1648195329.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 25 Mar 2022 09:03:08 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -10,6 +10,7 @@
>  #include <linux/suspend.h>
>  #include <linux/ftrace.h>
>  #include <linux/slab.h>
> +#include <linux/jump_label.h>
>  

Small nit. Please order the includes in "upside-down x-mas tree" fashion:

#include <linux/jump_label.h>
#include <linux/suspend.h>
#include <linux/ftrace.h>
#include <linux/slab.h>

Thanks,

-- Steve
