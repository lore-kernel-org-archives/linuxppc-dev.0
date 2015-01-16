Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D2691A0D9A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 15:15:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 16 Jan 2015 14:15:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F2A1C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 15:15:31 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0G4FV0R45154438
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 15:15:31 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0G4FUNr003927
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 15:15:31 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
In-reply-to: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 15:15:30 +1100
Message-Id: <1421381208-sup-526@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ryan,

Excerpts from Ryan Grimm's message of 2015-01-16 09:27:15 +1100:
> reset_image_select identifies whether a PERST will cause the image to be

s/reset_image_select/load_image_on_perst/

> +What:           /sys/class/cxl/<card>/load_image_on_perst
> +Date:           December 2014
> +Contact:        linuxppc-dev@lists.ozlabs.org
> +Description:    read/write
> +                Value of "none" means PERST will not cause image to be loaded
> +                to the card.  A power cycle is required to load the image.  

git am spotted some whitespace at the end of this line.


> +int cxl_update_image_control(struct cxl *adapter)

Would you be able to pull this function out into a separate patch (can
be first in the series so everything still compiles after each patch)
along with the change to the image_state defaults from patch 3? It's a
fix that I think would be good to be backported to stable, which will be
simpler if it's in a separate patch.



Otherwise, looks good :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
