Message-Id: <200005220447.GAA13376@denx.local.net>
To: Brent <bimhoff@ns1.planetspork.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX boot problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 21 May 2000 18:28:35 MDT."
             <Pine.GSO.4.05.10005211739380.9894-100000@ns1.planetspork.com>
Date: Mon, 22 May 2000 06:47:14 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.GSO.4.05.10005211739380.9894-100000@ns1.planetspork.com> you wrote:
>
> So I've searched the archives and read the readme's, and it still won't
> boot. :)

Well, let's see...

> At this point, things go bad.  I've tried two things. 1) hitting enter and
> letting things fall as they may.  This didn't work since there seemed to
> be a problem with it dropping the middle digit of the first octet of the
> src/dst IP addresses in the boot args.  2)  explicitly defining the boot
> arguments with appropriate settings.

Graham Stoney commented on # 2, so I'll give a try on # 1 :-)

There  once  was  a   bug   with   the   IP   address   handling   in
arch/ppc/mbxboot/misc.c   ;   if   you   can   find   a  place  where
"nfsaddrs_string" you should be able to figure out how to replace the
existing code with the following snippet:

		...
		dp = nfsaddrs_string;		/* nfsaddrs=x.x.x.x:y.y.y.y	*/
		while (*dp) {
			putc(*cp++ = *dp++);
		}
		/* add IP addresses as <my_ip>:<serv_ip> */
		for (i=0; i<4; ++i, ++byte) {
			unsigned char outbuf[4];	/* 3 digits + '\0' */
			unsigned char *optr = &outbuf[sizeof(outbuf)-1];

			*optr = '\0';

			do {
				*--optr = (*byte % 10) + '0';
				*byte /= 10;
			} while (*byte);

			while (*optr) {
				putc (*cp++ = *optr++);
			}

			if (i<3) {
				putc(*cp++ = '.');
			}
		}
		putc(*cp++ = ':');
		...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Today's robots are very primitive, capable of understanding  only  a
few  simple  instructions  such  as 'go left', 'go right', and 'build
car'."                                                  - John Sladek

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
