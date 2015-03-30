Return-Path: <mpe@ellerman.id.au>
Message-ID: <1427681112.4218.6.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/powernv: convert codes returned by OPAL
 calls
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Date: Mon, 30 Mar 2015 13:05:12 +1100
In-Reply-To: <1427474362-3903-1-git-send-email-clg@fr.ibm.com>
References: <20150327095936.50A921400A0@ozlabs.org>
 <1427474362-3903-1-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-27 at 17:39 +0100, Cédric Le Goater wrote:
> OPAL has its own list of return codes. The patch provides a translation
> of such codes in errnos for the opal_sensor_read call, and possibly 
> others if needed.
> 
> Index: linux.git/arch/powerpc/platforms/powernv/opal.c
> ===================================================================
> --- linux.git.orig/arch/powerpc/platforms/powernv/opal.c
> +++ linux.git/arch/powerpc/platforms/powernv/opal.c
> @@ -894,6 +894,23 @@ void opal_free_sg_list(struct opal_sg_li
>  	}
>  }
>  
> +int opal_error_code(int rc)
> +{
> +	switch (rc) {
> +	case OPAL_SUCCESS:		return 0;

Obviously correct.

> +	case OPAL_PARAMETER:		return -EINVAL;

Yep.

> +	case OPAL_UNSUPPORTED:		return -ENOSYS;

You shouldn't use ENOSYS here, that should only ever mean "no such syscall",
otherwise you get very confusing results like read() returning ENOSYS.

> +	case OPAL_ASYNC_COMPLETION:	return -EAGAIN;

EAGAIN means "try what you did again", I don't think that's what
ASYNC_COMPLETION means, is it? It looks like it means, "don't try again, but
you need to wait for the result to be ready".

I'm not sure it maps well to any of the Linux codes, maybe EINPROGRESS ?

> +	case OPAL_BUSY_EVENT:		return -EBUSY;

Yep.

> +	case OPAL_NO_MEM:		return -ENOMEM;

Yep.

> +	case OPAL_HARDWARE:		return -ENOENT;

This is another one which I think you shouldn't use as it can lead to confusing
results at user level. eg:

  $ cat /sysfs/some/file
  Error: No such file or directory

Huh?

Looking at the skiboot code this looks like EIO is a good match.

> +	case OPAL_INTERNAL_ERROR:	return -EIO;

Yeah as good as anything I guess.

> +	default:
> +		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
> +		return -ERANGE;

I'm not sure about this one honestly, it means "Math result not representable".

I suspect the reason RTAS chose it was just that it's not EINVAL.

This should probably also just be EIO.


cheers
