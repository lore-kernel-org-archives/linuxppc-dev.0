Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67A521A0895
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:49 +1100 (AEDT)
Message-ID: <1427261800.6468.74.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1]: thermal driver therm_adt746.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Haschka <haschka@gmail.com>
Date: Wed, 25 Mar 2015 16:36:40 +1100
In-Reply-To: <20150226094805.GA1009@gmail.com>
References: <CADAoK=UH4q9x-OMyOpqCmGpNwDo3vey41xajBw-PDdupmEHnAA@mail.gmail.com>
 <1424726318.12891.1.camel@kernel.crashing.org>
 <20150225112457.GA3491@gmail.com>
 <1424898763.12891.77.camel@kernel.crashing.org>
 <20150226094805.GA1009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-26 at 10:48 +0100, Thomas Haschka wrote:
> Hello, 
> 
> I hope I get it correct this time, thanks again.

Thanks. Sorry for the delay, I've been a bit swamped. I looked at your
code a bit more in depth and I would appreciate a couple more changes
if you don't mind:


 .../...

> +static void update_fans_speed_singlefan (struct thermostat *th) {
> +
> +	/* Single Fan Laptops i.e. 12 inch Powerbook, Ibook etc.
> +	 * Necessites the readout of all three thermal sensors
> +	 * in order to avoid the harddisk and other components to overheat
> +	 * in the case of cold CPU. */
> +	
> +	int lastvar = 0; /* last variation, for iBook */
> +	int i = 0;
> +	int var = 0;
> +	int var_sensor[3];
> +	int started = 0;
> +	int fan_number = 0;

So here you hard code fan_number instead of looping accross all fans,
you could just use a constant...

> +	for (i = 0; i < 3; i++) {
> +		var_sensor[i] = th->temps[i] - th->limits[i];
> +	}
> +	var = var_sensor[0];
> +	for (i = 1; i < 3; i++) {
> +		if (var_sensor[i] > var) {
> +			var = var_sensor[i]; 
> +		}
> +	}

Why two loops ?

> +	if (var > -1) {
> +		int step = (255 - fan_speed) / 7;
> +		int new_speed = 0;
> +		/* hysteresis : change fan speed only if variation is
> +		 * more than two degrees */
> +		if (abs(var - th->last_var[fan_number]) > 2) { 
> +
> +			started = 1;
> +			new_speed = fan_speed + ((var-1)*step);
> +
> +			if (new_speed < fan_speed)
> +				new_speed = fan_speed;
> +			if (new_speed > 255)
> +				new_speed = 255;
> +
> +			if (verbose)
> +				printk(KERN_DEBUG "adt746x:"
> +				       " Setting fans speed to %d "
> +				       "(limit exceeded by %d on %s)\n",
> +				       new_speed, var,
> +				       sensor_location[fan_number+1]);
> +			write_both_fan_speed(th, new_speed);
> +			th->last_var[fan_number] = var; 
> +		}
> +	} else if (var < -2) {
> +		/* don't stop fan if sensor2 is cold and sensor1 is not
> +		 * so cold (lastvar >= -1) */
> +		if (i == 2 && lastvar < -1) {
> +			if (th->last_speed[fan_number] != 0)
> +				if (verbose)
> +					printk(KERN_DEBUG "adt746x:"
> +					       " Stopping "
> +					       "fans.\n");
> +			write_both_fan_speed(th, 0);
> +		}
> +	}

This looks identical between the two functions (single/multi fan), can
you factor it out into a single static helper that they both call ?

Cheers,
Ben.
