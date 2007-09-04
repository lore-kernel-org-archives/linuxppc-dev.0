Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6A8DDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 11:58:44 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ISNgf-00089Q-6i
	for linuxppc-embedded@ozlabs.org; Mon, 03 Sep 2007 18:58:41 -0700
Message-ID: <12470485.post@talk.nabble.com>
Date: Mon, 3 Sep 2007 18:58:41 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ML403 AC97 ALSA Driver problem
In-Reply-To: <1188852155.5738.21.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <12399427.post@talk.nabble.com>
	<1188852155.5738.21.camel@localhost>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Joachim
Every time aplay wavfile ,there is kernel stack overflow.And the "xsysace"
is a CF card driver .
when i just writing data to codec 0 with a simple program ,it is OK, but if
i read data from CF card=20
and play ,it overflow also.
Maybe there is something conflict with CF card driver and AC97 driver .

Thanks for your note ,i will test it again.

Qin Lin =20

Joachim F=C3=B6rster wrote:
>=20
> Hi Qin Lin,
>=20
> Do you get this overflow everytime you try aplay? Or, do you get it
> sometimes, only?
>=20
> What confuses me is, that in your kernel messages the "TASK =3D ...
> 'xsysace'" is mentioned. Perhaps there is some relation with the sysace
> driver? Or do I miss something, here?
> Did you try play a .wav file from a RAM disk or NFS-mounted location? I
> have to note, that I am not using sysace and I haven't tried it jet -
> especially together with my AC97 driver.
>=20
> As a first step, no matter what, you could compile your kernel with
> CONFIG_SND_DEBUG and additionally replace the line
>=20
> #define PDEBUG_FACILITIES (UNKNOWN | INIT_FAILURE | WORK_FAILURE)
>=20
> in ml403-ac97cr.c with
>=20
> #define PDEBUG_FACILITIES (UNKNOWN | INIT_FAILURE | WORK_FAILURE |
> WORK_INFO | INIT_INFO)
>=20
> This will give you a, well, huge amount of debugging messages
> (KERN_DEBUG). There we should see, how far my driver is getting (to some
> extent).
>=20
>  Joachim
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/ML403-AC97-ALSA-Driver-=
problem-tf4351591.html#a12470485
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
