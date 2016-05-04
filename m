Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y075pkPzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:23 +1000 (AEST)
In-Reply-To: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh+dt@kernel.org, paulus@samba.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, grant.likely@linaro.org,
 frowand.list@gmail.com
Subject: Re: [1/2] drivers/of: Add check for null property in
 of_remove_property()
Message-Id: <3r0Y074wcfz9t4k@ozlabs.org>
Date: Thu,  5 May 2016 08:40:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 05:34:54 UTC, Suraj Jitindar Singh wrote:
> The validity of the property input argument to of_remove_property() is
> never checked within the function and thus it is possible to pass a null
> value. It happens that this will be picked up in __of_remove_property()
> as no matching property of the device node will be found and thus an
> error will be returned, however once again there is no explicit check
> for a null value. By the time this is detected 2 locks have already been
> acquired which is completely unnecessary if the property to remove is
> null.
> 
> Add an explicit check in the function of_remove_property() for a null
> property value and return -ENODEV in this case, this is consistent with
> what the previous return value would have been when the null value was
> not detected and passed to __of_remove_property().
> 
> By moving an explicit check for the property paramenter into the
> of_remove_property() function, this will remove the need to perform this
> check in calling code before invocation of the of_remove_property()
> function.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c173cb23486f540ea08a5050a

cheers
