Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E9A11A078A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 04:53:41 +1100 (EST)
Date: Tue, 7 Oct 2014 13:52:48 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH V25/5] powerpc/kexec: Use global IND_FLAGS macro
Message-ID: <20141007175248.GG27464@redhat.com>
References: <cover.1412640584.git.geoff@infradead.org>
 <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 07, 2014 at 12:21:30AM +0000, Geoff Levand wrote:
> linux/kexec.h now defines an IND_FLAGS macro.  Remove the local powerpc
> definition and use the generic one.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

I think this patch should be merged in previous patch. I guess after
applying patch4, series might not be compilable as there are two
definitions of IND_FLAGS now.

Thanks
Vivek

> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 879b3aa..75652a32 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -96,8 +96,6 @@ int default_machine_kexec_prepare(struct kimage *image)
>  	return 0;
>  }
>  
> -#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
> -
>  static void copy_segments(unsigned long ind)
>  {
>  	unsigned long entry;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
