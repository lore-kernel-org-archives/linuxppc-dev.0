Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD5F2DDF77
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 12:13:35 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 1D3071E66D1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 22:04:59 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id ZElcM+ctt9LF for <linuxppc-dev@ozlabs.org>;
	Tue,  3 Mar 2009 22:04:55 -0300 (BRT)
Received: from chagas.nectar.ath.cx (189-39-150-98.gru.flash.tv.br
	[189.39.150.98])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 7AF5A1E6759
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 22:04:53 -0300 (BRT)
Date: Tue, 3 Mar 2009 22:04:53 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Tony Breeds <tony@bakeyournoodle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Kumar Gala <galak@kernel.crashing.org>, paulus@samba.org
Subject: Re: Linux 2.6.29-rc6 bombs while compiling a kernel for a
	linkstation/kurobox
Message-ID: <20090304010453.GA18621@ime.usp.br>
References: <20090302094303.GA29819@ime.usp.br>
	<Pine.LNX.4.64.0903040103440.5059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0903040103440.5059@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 04 2009, Guennadi Liakhovetski wrote:
> Yes, linkstation and storcenter have to migrate to the "physmap-flash" 
> platform driver. For now you can define in your .config
> 
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0xffc00000
> CONFIG_MTD_PHYSMAP_LEN=0x400000
> CONFIG_MTD_PHYSMAP_BANKWIDTH=1

I did that already yesterday. Please, see my patch at
http://marc.info/?l=linux-kernel&m=123606933628020&w=4

And the entry at bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=12811

> (I hope the numbers are correct, just found them in my local tree, don't 
> remember any more what exactly they configure, please, double-check.)

Yes, I had them in my tree also. And it is tested already, up and
running and in production for 17 hours.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
rbrito@lutz:~$ uptime
 22:03:16 up 17:06,  1 user,  load average: 0.16, 0.03, 0.01
rbrito@lutz:~$ 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> And yes, it must be fixed in the mainline. I'll see if I find time for
> this, maybe tomorrow (actually, already today.)

Please, Cc me any relevant patches, as I'm not subscribed to all those
lists.


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
