Return-Path: <michael@ozlabs.org>
In-Reply-To: <1427385887-25403-1-git-send-email-clg@fr.ibm.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,1/3] powerpc/powernv: convert codes returned by OPAL calls
Message-Id: <20150327095936.50A921400A0@ozlabs.org>
Date: Fri, 27 Mar 2015 20:59:36 +1100 (AEDT)
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-26-03 at 16:04:45 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> OPAL has its own list of return codes. The patch provides a translation
> of such codes in errnos for the opal_sensor_read call.
> 
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-sensor.c |   37 ++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
> ===================================================================
> --- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
> +++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
> @@ -26,6 +26,38 @@
  
> +static int convert_opal_code(int ret)
> +{
> +	switch (ret) {
> +	case OPAL_SUCCESS:		return 0;
> +	case OPAL_PARAMETER:		return -EINVAL;
> +	case OPAL_UNSUPPORTED:		return -ENOSYS;
> +	case OPAL_ASYNC_COMPLETION:	return -EAGAIN;
> +	case OPAL_BUSY_EVENT:		return -EBUSY;
> +	case OPAL_NO_MEM:		return -ENOMEM;
> +	case OPAL_HARDWARE:		return -ENOENT;
> +	case OPAL_INTERNAL_ERROR:	return -EIO;
> +	default:			return -EIO;
> +	}
> +}

That looks a bit familiar :)

static int rtas_error_rc(int rtas_rc)
{
	int rc;

	switch (rtas_rc) {
		case -1: 		/* Hardware Error */
			rc = -EIO;
			break;
		case -3:		/* Bad indicator/domain/etc */
			rc = -EINVAL;
			break;
		case -9000:		/* Isolation error */
			rc = -EFAULT;
			break;
		case -9001:		/* Outstanding TCE/PTE */
			rc = -EEXIST;
			break;
		case -9002:		/* No usable slot */
			rc = -ENODEV;
			break;
		default:
			printk(KERN_ERR "%s: unexpected RTAS error %d\n",
					__func__, rtas_rc);
			rc = -ERANGE;
			break;
	}
	return rc;
}


But I guess we still should have it.

Can you put it in opal.h and give it a better name, maybe opal_error_code() ?

>  /*
>   * This will return sensor information to driver based on the requested sensor
>   * handle. A handle is an opaque id for the powernv, read by the driver from the
> @@ -46,8 +78,10 @@ int opal_get_sensor_data(u32 sensor_hndl
>  
>  	mutex_lock(&opal_sensor_mutex);
>  	ret = opal_sensor_read(sensor_hndl, token, &data);
> -	if (ret != OPAL_ASYNC_COMPLETION)
> +	if (ret != OPAL_ASYNC_COMPLETION) {
> +		ret = convert_opal_code(ret);
>  		goto out_token;
> +	}
>  
>  	ret = opal_async_wait_response(token, &msg);
>  	if (ret) {
> @@ -58,6 +92,7 @@ int opal_get_sensor_data(u32 sensor_hndl
>  
>  	*sensor_data = be32_to_cpu(data);
>  	ret = be64_to_cpu(msg.params[1]);
> +	ret = convert_opal_code(ret);

I'd do:
	ret = convert_opal_code(be64_to_cpu(msg.params[1]));

cheers
