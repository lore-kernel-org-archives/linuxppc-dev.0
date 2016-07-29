Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s16F82wn4zDrPs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 21:38:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com, julia.lawall@lip6.fr,
 imunsie@au1.ibm.com, elfring@users.sourceforge.net
Subject: Re: [PATCH] cxl: replace loop with for_each_child_of_node(),
 remove unneeded of_node_put()
In-Reply-To: <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <601fb58c-7aee-91ce-2a3d-7a29787968fc@au1.ibm.com>
 <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Jul 2016 21:38:48 +1000
Message-ID: <87fuqsllmf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Rewrite the cxl_guest_init_afu() loop in cxl_of_probe() to use
> for_each_child_of_node() rather than a hand-coded for loop.
>
> Remove the useless of_node_put(afu_np) call after the loop, where it's
> guaranteed that afu_np == NULL.
>
> Reported-by: SF Markus Elfring <elfring@users.sourceforge.net>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> Checked the of_node_put() with Fred, he thinks it was probably just left
> over from an earlier private version of the code and we can just get rid of
> it.

But who does keep a reference on the device_node? I can't see it anywhere. Which
means in theory the device_node can be freed out from under you.

You have a reference for afu_np as part of for_each_child_of_node(), but it's
dropped as soon as you go around the loop.

The typical pattern would be that cxl_guest_init_afu() takes an additional
reference once it's done all its setup and can't fail.

That way at the end of the loop when the loop construct has dropped all
references, the nodes you actually init'ed have their reference count
incremented by 1.

cheers
