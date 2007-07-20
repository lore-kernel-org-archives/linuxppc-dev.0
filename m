Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7C1EDDF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 17:33:50 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0707191932300.3365@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Fri, 20 Jul 2007 09:26:58 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You might want to put vendor names in the "compatible"
>> entries, dunno though, maybe these are "cross-vendor"
>> ICs?
>
> You mean like
>
> 	compatible = "ricoh,rs5c372a"

Yeah, like that.  I'm not sure it is needed for these,
but it won't hurt either.

> +		strncpy(info->driver_name, i2c_devices[i].i2c_driver,  
> KOBJ_NAME_LEN);
> +		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);

Why not just strcpy(), btw?

> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> +			continue;

Give a warning when the addr won't fit in 16 bits?


Segher
