From: David Jander <david.jander@protonic.nl>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM405
Date: Mon, 23 Jun 2003 16:31:31 +0200
References: <f71eqyflvndrtko.230620031257@gda-server>
In-Reply-To: <f71eqyflvndrtko.230620031257@gda-server>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200306231631.31579.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 23 June 2003 09:37, Rakesh jagota wrote:
> Hi all,
>
> We have ported linuc on IBM 405 ppc based board. we have a small query.
> How can we directly run the application after switching-on the board
> (without typing "root" at login prompt.

There are several ways/things you can try:

1.- Start your application from one of the init scripts (search in
/etc/rc.d/... for the right spot)
2.- Replace /sbin/init with your application (dangerous, you'll have to know
what you are doing, and your application needs to start up all other things,
just like init.)
3.- Edit /etc/inittab to change the order in which things are started. For
example if you wanted to start your application in every runlevel, put
something like this into /etc/inittab:
my:12345:respawn:/bin/myapplication
This will keep your application always running, and restart it if it quits.
4.- replace /sbin/login with your app ;-)

There are probably many more options, but I hope this helps for a start.

Sincerely,

--
David Jander
Protonic Holland.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
