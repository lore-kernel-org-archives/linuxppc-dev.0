To: Dan Malek <dan@embeddededge.com>
Cc: OTAVIO ISAMU SUGENO <otavio.sugeno@siemens.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to configure 2 ethernet devices 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 May 2002 16:36:27 EDT."
             <3CE2C6CB.20402@embeddededge.com>
Date: Wed, 15 May 2002 23:15:33 +0200
Message-Id: <20020515211539.1356D1196A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CE2C6CB.20402@embeddededge.com> Dan Malek wrote:
>
> If you like to use DNS, routing or other networking features you have
> to use some kind of userland configuration to make that happen.

Rigth, for more complicated configurations this is the way to go.

> I think it's kind of amusing when you use "dynamic" configuration to
> get a network configuration to boot a kernel, then have a bunch of
> static configuration files to support the application environment :-)
> If you are always booting from the same server on the same static
> network, why not just boot a ramdisk with some static configuration
> and network set up?  It will boot up faster.

But we don't have a static configuration. We use something like this:

=> setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off

Right,  we  use  PPCBoot  as  firmware  and  get  all  the  "dynamic"
configuration   by  PPCBoot's  feature  to  define,  store,  and  use
variables.

> If you are truly using a dynamic environment where you could plug in
> anywhere and have the application automatically adapt, you need to
> follow through with dynamic userland configuration.

... not when we can pass all the necessary parameters on the  command
line (or in bi_recs :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have made mistakes, but have never made the mistake of  claiming  I
never made one.                                     - James G. Bennet

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
