Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E2B8DE17B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:29:04 +1000 (EST)
Subject: Re: Question about windfarm drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090416105216.27c3f715@hyperion.delvare>
References: <20090416105216.27c3f715@hyperion.delvare>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:28:49 +0200
Message-Id: <1239953329.7443.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 10:52 +0200, Jean Delvare wrote:

> In wf_lm75_release(), i2c_detach_client() is called if and only if
> lm->i2c.adapter is set, which is not the case, and then the data
> structure, including the i2c client, is freed from memory. This means
> that the freed i2c client is still registered with i2c-core, this looks
> wrong.
> 
> Am I missing something? Or is this clean-up path broken and nobody ever
> noticed?

Probably the later :-)

> I am also curious why wf_unregister_sensor() calls wf_put_sensor()
> while wf_register_sensor() doesn't call wf_get_sensor().

It's quite possible that those code path are a bit buggy and not well
exercised. I don't think people ever unload those modules and we tend to
have that stuff built-in ourselves.

Cheers,
Ben.
