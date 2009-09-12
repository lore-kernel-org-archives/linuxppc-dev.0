Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7FA1BB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 00:01:58 +1000 (EST)
Received: from mail-pz0-f200.google.com (mail-pz0-f200.google.com
	[209.85.222.200]) by ozlabs.org (Postfix) with ESMTP id EA5A8DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Sep 2009 00:01:56 +1000 (EST)
Received: by pzk38 with SMTP id 38so1521998pzk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 07:01:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1252758988.3310.0@antares>
References: <1252758988.3310.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 12 Sep 2009 08:01:35 -0600
Message-ID: <fa686aa40909120701k4c4faa8ev78ac556f0b1f88ed@mail.gmail.com>
Subject: Re: MPC5200/BestComm functions question
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 12, 2009 at 6:36 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi all,
>
> I have a MPC5200B based system with a 16-bit peripheral attached to the
> Local Bus, and I am looking into possibilities to use BestComm for the da=
ta
> transfer.
>
> I found Grant Likely's cool 'mpc5200-localplus-test.c' driver which
> demonstrates this using the 'gen_bd' driver, and which is apparently a gr=
eat
> starting point.

I've actually got a better driver which exports an API for doing local
plus bus FIFO transfers.  It's been posted to the mailing list a
couple of times.  I'll cc: you the next time I post it (real soon
now).

> However, I also have to (a) 32-bit endianess-swap the data and (b) calcul=
ate
> a 32-bit crc on it. =A0Of course, this is possible with the buffers using=
 the
> cpu, but I saw some remarks that the Bestcomm engine also includes functi=
ons
> which can perform swapping and crc calculation. =A0I believe it would unl=
oad
> the cpu if the BestComm engine could perform these tasks, but I cannot fi=
nd
> a good documentation/example for that. =A0Does anyone know any pointers f=
or
> that? =A0Or maybe even a tool to create the bestcomm tasks from a 'readab=
le'
> source?

Bestcomm can do that, but Freescale has not publically released the
bestcomm documentation, and they do not support writing custom
bestcomm tasks.  From what I understand there are a number of hidden
bugs in the bestcomm engine which you could run into if you deviate
from the provided tasks.  You're very much on your own if you go down
that route.  :-(

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
