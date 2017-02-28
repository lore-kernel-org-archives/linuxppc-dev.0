Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXrlg6cb5zDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 08:08:31 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1SL3pA2037835
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 16:08:29 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wgrtg8r0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 16:08:29 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 16:08:28 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 955CA38C804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 16:08:26 -0500 (EST)
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <1488276702-14646-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1488276702-14646-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 08:08:19 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h93ec9bw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
> Added check for OPAL_WRONG_STATE error code returned from OPAL.
> Currently Linux flashes "unexpected error" over console for this
> error. This will avoid throwing such message and return I/O error
> for such OPAL failures.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
> Changes in v2:
>  - Added log message indicating sleeping/offline core
>    for OPAL_WRONG_STATE
>
>  arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 86d9fde..8af230e 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -869,8 +869,11 @@ int opal_error_code(int rc)
>  	case OPAL_UNSUPPORTED:		return -EIO;
>  	case OPAL_HARDWARE:		return -EIO;
>  	case OPAL_INTERNAL_ERROR:	return -EIO;
> +	case OPAL_WRONG_STATE:
> +		pr_notice("%s: Core sleeping/offline\n", __func__);
> +		return -EIO;

Since this is part of opal_error_code() though, this will be printed for
any OPAL call that returns that.

Why not have the sensor code do this:

rc = opal_sensor_read(foo)
if (rc == OPAL_WRONG_STATE)
   return -EIO;
else
   return oal_error_code(rc);

?

>  	default:
> -		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
> +		pr_err("%s: Unexpected OPAL error %d\n", __func__, rc);

Do we need this?

-- 
Stewart Smith
OPAL Architect, IBM.
