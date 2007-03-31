Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A546DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 03:06:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: PPC login puzzle
Date: Sat, 31 Mar 2007 10:06:18 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6D@MERCURY.inside.istor.com>
References: <20070329192932.98FBD353A6C@atlas.denx.de><200703291345.35978.tmaenner@aehr.com><9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com><460DDB1F.7020106@billgatliff.com><9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6C@MERCURY.inside.istor.com>
	<b4b98b690703310920k63a60835s8d3ba6993d72179d@mail.gmail.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Steve Iribarne \(GMail\)" <netstv@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Seems to me thing you can do is find out why the telnet session is being =
rejected.  Have you done an ethernet capture?=20

Do you have any firewalling setup?  In that case you need to make sure =
your rules are setup properly.  The ethernet capture should give you a =
clue.=20

Are you sure the telnetd can be found on your system that doesn't work?  =
What do the logs tell you on the machine that doesn't work?  I think =
xinetd kicks out a log file, what does that tell you?

Have you tried on the 8541,  login to the terminal and then telnet to =
localhost?  If you can do that, then I'd say it's a firewalling problem, =
if not, then it's a telnetd type of problem. =20


Hope that helps.
-stv
--=20
/*
* Steve Iribarne
* Software Engineer
* (aka Grunt)=20
*/
=20
It is interesting that 'telnet localhost' fails in a similar way as =
telnet across the network, and I appreciate your kind hints, especially =
about the log file and /var/log/syslog helps a bit on this problem.
=20
When trying to telnet accross the network, syslog says
=20
in.telnetd[]: connect from x.x.x.x
=20
But entering root doesnt work and the host then says:
sff1 login: root
Login incorrect
=20
There are no further errors on the 8541. When trying to 'telnet =
localhost', syslog says
=20
in.telnetd[]: connect from 127.0.0.1
=20
But neither completes the login, so although there is a clue here, the =
logical path to conclusion is still escaping me a little bit.
=20
I can see that both targets have the same /etc/xinted.d/telnet file and =
it contains:
=20
service telnet
{
 flags  =3D REUSE
 socket_type =3D stream       =20
 protocol =3D tcp
 wait  =3D no
 user  =3D root
 server  =3D /usr/sbin/in.telnetd
 server_args =3D -h
 log_on_failure +=3D USERID
}
=20
which I think is reasonable in this situation. So, this begs the =
question of what other things still bear on this type of problem. Again, =
I appreciate your taking the time to help me understand a bit more of =
how this fits together.
=20
Charles
=20
=20
