Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A97767D47
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 01:32:04 +1100 (EST)
Subject: load average ~1 on powermac
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Z6szAB61Hi7cDhOQMUnz"
Date: Thu, 14 Dec 2006 15:27:58 +0100
Message-Id: <1166106478.3161.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Z6szAB61Hi7cDhOQMUnz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After investigating a bit I finally found why the load average stays
around 1 on powermacs... Try this:

  watch --interval 0.1 "ps xa|grep ' D'"

it'll show [kwindfarm] most of the time, with it going away for a while
sometimes.

Now, I thought windfarm wasn't actually doing anything wrong, it's doing
interruptible sleep. Not so!

@@ -115,11 +113,12 @@ static int wf_thread_func(void *data)
                }

                delay =3D next - jiffies;
+               printk(KERN_DEBUG "delay =3D %lu\n", delay);
                if (delay <=3D HZ)
                        schedule_timeout_interruptible(delay);

reveals that in fact it's only sleeping for about 300 milliseconds most
of the time!

Now doing sysrq t a lot of time reveals that it's spending the rest in
wait_for_completion, called from two places.

* windfarm_smu_controls.c: smu_set_fan
* low_i2c.c: smu_i2c_xfer

the latter is called twice for every windfarm tick and takes about 170
milliseconds for each call, the first I haven't measured but it pretty
much has to account for the rest of the second...

I don't quite understand why the fan speed has to be set every tick but
even just reading the i2c stuff is probably bad enough.

I don't think we can solve this easily since all these things may be
called from userspace processes so being interruptible is not
appropriate unless we want to somehow handle that, but that probably
won't be easy.

johannes

--=-Z6szAB61Hi7cDhOQMUnz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFgV9u/ETPhpq3jKURAvmyAJ0cNUs0XuWujuT23WHgcrMzgtNtvgCfb3TB
4oJ/BUAiIoG/H+tvc1TsrQ4=
=3zOo
-----END PGP SIGNATURE-----

--=-Z6szAB61Hi7cDhOQMUnz--
