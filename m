Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcF2v4VSHzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 20:33:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powernv/sensor: Handle OPAL_WRONG_STATE error return
In-Reply-To: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Mon, 06 Mar 2017 20:33:26 +1100
Message-ID: <87lgsipx5l.fsf@concordia.ellerman.id.au>
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

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:

> OPAL returns OPAL_WRONG_STATE upon failing to provide
> sensor data due to core sleeping/offline. Added check
> for OPAL_WRONG_STATE rerurn code with sensor read failure.
> Also added a log message indicating sensor data being
> queried for sleeping/offline core.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
> Changes in v3:
>  - Added a new case for OPAL_WRONG_STATE in sensor read
>    along with a log message indicating sleeping/offline core
>    causing read fail.
>
>  arch/powerpc/platforms/powernv/opal-sensor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
> index 308efd1..fb6d6bb 100644
> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
> @@ -64,6 +64,12 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
>  		*sensor_data = be32_to_cpu(data);
>  		break;
>  
> +	case OPAL_WRONG_STATE:
> +		pr_notice("%s: Sensor data read failure due to "
> +				"core sleeping/offline\n", __func__);

I don't think it should print.

It's not the users fault, or anything they can prevent. It's a
mis-feature (aka. bug) in the driver that it queries sensors for offline
CPUs. At least it should be ratelimited.

I thought the entire motivation for the patch in the first place was
that we were spamming the console with messages?

cheers
