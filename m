Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89269DDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 09:10:59 +1000 (EST)
In-Reply-To: <20070702224643.GA21539@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<20070702224643.GA21539@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a3d0917402e24efbe6224c544ddd432@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Tue, 3 Jul 2007 01:10:47 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> AFAIK, i2c is not specified by OF standard. So, we are free to chose 
>> any
>> "compatible" fields for our dts. Which we then would need to match 
>> against
>> drivers. So, why not make this a 1-to-1 match? I.e.,
>> [OF]			[I2C]
>> compatible	<->	driver_name
>> model		<->	type
>
> If we do this, then the compatible field should probably be preceded 
> with
> "linux,", which would get stripped by of_register_i2c_devices().  This
> would only be an interim measure until we can figure out some sort of
> name registry via power.org.  Once that happens, non-"linux," 
> compatible
> fields could be looked up in an OF-to-linux table, or there could be a
> way for i2c devices to specify OF matches in addition to driver name.

Why even think of doing this?  Just put the bloody name of
the device in the "compatible" property and match on that.
What is so hard about this?

If the answer is "the Linux I2C stuff is badly structured",
well, you know what to do :-)


Segher
