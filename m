Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id F1BC2B7B69
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 08:02:55 +1100 (EST)
Date: Wed, 14 Oct 2009 23:02:52 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Tim Shepard <shep@alum.mit.edu>
Subject: Re: i2c-powermac fails
Message-ID: <20091014230252.0d0cba8d@hyperion.delvare>
In-Reply-To: <20091013114948.03608b7f@hyperion.delvare>
References: <20091013112304.74083fd1@hyperion.delvare>
	<1255426348.2192.187.camel@pasglop>
	<20091013114948.03608b7f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On Tue, 13 Oct 2009 11:49:48 +0200, Jean Delvare wrote:
> I2C bus being setup too fast sounds more likely. It might be worth
> adding an arbitrary delay after initialization, just to see if it
> helps. Not sure where though, as I'm not familiar with the Powermac
> initialization steps. Maybe right before i2c_add_adapter() in
> i2c_powermac_probe?

Tim, can you please give a try to this patch? Obviously your machine
will take 5 additional seconds to boot, and this isn't meant as a real
fix, but if it helps, this will be an interesting hint for further
debugging attempts.

--- kernel32.orig/drivers/macintosh/therm_adt746x.c
+++ kernel32/drivers/macintosh/therm_adt746x.c
@@ -380,6 +380,7 @@ static int probe_thermostat(struct i2c_c
 	if (thermostat)
 		return 0;
 
+	msleep(5000);
 	th = kzalloc(sizeof(struct thermostat), GFP_KERNEL);
 	if (!th)
 		return -ENOMEM;


-- 
Jean Delvare
