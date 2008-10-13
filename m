Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0194DE073
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:28:26 +1100 (EST)
In-Reply-To: <Pine.LNX.4.64.0810131959140.9041@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<Pine.LNX.4.64.0810131959140.9041@axis700.grange>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <BAFAB2E9-A9E1-443D-9774-459965AF52C1@ime.usp.br>
From: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: [PATCH] powerpc: compile kernel for linkstations optimized for
	size
Date: Mon, 13 Oct 2008 19:28:02 -0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Guennadi.

On 13/10/2008, at 16:03, Guennadi Liakhovetski wrote:

> On Mon, 13 Oct 2008, Rog=E9rio Brito wrote:
>
>> From: Rog=E9rio Brito <rbrito@ime.usp.br>
>>
>> Since Linkstations and Kuroboxes often have *very* little memory (as
>> they are embedded systems), it is desirable to get their kernels
>> compiled optimized for size.
>>
>> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>>
>> ---
>>
>> I have been using kernels optimized for size on my Kurobox (standard)
>> for many different releases and I have experienced no problem with =20=

>> this
>> option enabled. Thus, this patch.
>
> The comment for this option says: "watch out for broken compilers," if
> this doesn't hold any more, it should be remove, if it still holds, I
> wouldn't turn this on by default, as I don't think we can test all

Pragmatically speaking, -O2 can be broken too (and see the amount of =20
ICEs that you can get with newer kernels even compiling with -O2). =20
Unless you prove that the compiler is correct and keeps all its =20
invariants, then you can rely on this. But, pragmatically speaking =20
again, gcc has bugs.

But leaving the mathematical situation aside (Dijkstra would have =20
spanked all of us here :)), as I mentioned below the signed off line, =20=

I have been using -Os and it is working fine. It's serving me quite =20
well and with a decent uptime:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =20=

- - -
lutz:~# uptime
  19:22:53 up 17 days,  5:56,  1 user,  load average: 0.00, 0.00, 0.00
lutz:~# uname -a
Linux lutz 2.6.27-rc6.try02 #8 Fri Sep 26 11:29:55 BRT 2008 ppc GNU/=20
Linux
lutz:~#
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =20=

- - -

And, despite the 0.00 load, I'm streaming music with it via mt-daapd =20
and serving cifs mounts.

> possible (cross- or native-) compilers users might want to use. In any
> case this is one of options that users can select themselves, if it =20=

> suits
> them.

And that is, not to mention, with a very home-brew and quick'n'dirty =20
cross-compiled kernel (with a vanilla gcc 4.2.0 taken straight from =20
gcc.gnu.org; the same with the kernel: no patches applied).

--=20
Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
