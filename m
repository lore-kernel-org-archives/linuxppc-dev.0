Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E4EF2C014A
 for <linuxppc-dev@ozlabs.org>; Tue,  7 May 2013 14:06:11 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bg2so183575pad.39
 for <linuxppc-dev@ozlabs.org>; Mon, 06 May 2013 21:06:09 -0700 (PDT)
Date: Mon, 6 May 2013 21:06:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fix numa distance for form0 device tree
Message-ID: <20130507040614.GA19525@kroah.com>
References: <1367898574-20594-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367898574-20594-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 07, 2013 at 01:49:34PM +1000, Michael Ellerman wrote:
> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> Commit 7122beeee7bc1757682049780179d7c216dd1c83 upstream.
> 
> The following commit breaks numa distance setup for old powerpc
> systems that use form0 encoding in device tree.
> 
> commit 41eab6f88f24124df89e38067b3766b7bef06ddb
> powerpc/numa: Use form 1 affinity to setup node distance
> 
> Device tree node /rtas/ibm,associativity-reference-points would
> index into /cpus/PowerPCxxxx/ibm,associativity based on form0 or
> form1 encoding detected by ibm,architecture-vec-5 property.
> 
> All modern systems use form1 and current kernel code is correct.
> However, on older systems with form0 encoding, the numa distance
> will get hard coded as LOCAL_DISTANCE for all nodes.  This causes
> task scheduling anomaly since scheduler will skip building numa
> level domain (topmost domain with all cpus) if all numa distances
> are same.  (value of 'level' in sched_init_numa() will remain 0)
> 
> Prior to the above commit:
> ((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
> 
> Restoring compatible behavior with this patch for old powerpc systems
> with device tree where numa distance are encoded as form0.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/mm/numa.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What stable tree should this be applied to?

thanks,

greg k-h
