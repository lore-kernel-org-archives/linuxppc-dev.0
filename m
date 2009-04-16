Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27D85DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:52:32 +1000 (EST)
Date: Thu, 16 Apr 2009 10:52:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: Question about windfarm drivers
Message-ID: <20090416105216.27c3f715@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben, hi Paul,

As I am converting the windfarm drivers to the new i2c device binding
model, I need to understand how these drivers work currently. There's
one thing I do not understand so I'd appreciate if you could explain it
to me.

I am looking at function wf_lm75_detach() in windfarm_lm75_sensor.c.
This function is called by i2c-core if either i2c-powermac or
windfarm_lm75_sensor is unloaded. It sets lm->i2c.adapter to NULL and
then calls wf_unregister_sensor(), which in turn calls wf_put_sensor(),
which calls wf_sensor_release() is the reference count drops to 0,
which in turns call the driver's .release() method, that is,
wf_lm75_release() in our case.

In wf_lm75_release(), i2c_detach_client() is called if and only if
lm->i2c.adapter is set, which is not the case, and then the data
structure, including the i2c client, is freed from memory. This means
that the freed i2c client is still registered with i2c-core, this looks
wrong.

Am I missing something? Or is this clean-up path broken and nobody ever
noticed?

I am also curious why wf_unregister_sensor() calls wf_put_sensor()
while wf_register_sensor() doesn't call wf_get_sensor().

Thanks,
-- 
Jean Delvare
