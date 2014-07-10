Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 236891A0B4A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:33:52 +1000 (EST)
Message-ID: <1404959630.27178.1.camel@concordia>
Subject: Re: [PATCH] powerpc/pseries: dynamically added OF nodes need to
 call of_node_init
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 12:33:50 +1000
In-Reply-To: <1404955205-12847-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1404955205-12847-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: grant.likely@linaro.org, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-09 at 21:20 -0400, Tyrel Datwyler wrote:
> Commit 75b57ecf9 refactored device tree nodes to use kobjects such that they
> can be exposed via /sysfs. A secondary commit 0829f6d1f furthered this rework
> by moving the kobect initialization logic out of of_node_add into its own
> of_node_init function. The inital commit removed the existing kref_init calls
> in the pseries dlpar code with the assumption kobject initialization would
> occur in of_node_add. The second commit had the side effect of triggering a
> BUG_ON as a result of dynamically added nodes being uninitialized.

So does this mean DLPAR is broken since 0829f6d1f (3.15-rc1)?

If so this should have a Cc: stable@kernel.org shouldn't it?

And the latest trend is to also add:

Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")

cheers
