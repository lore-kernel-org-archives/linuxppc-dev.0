Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Wed, 23 Dec 1998 04:37:17 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] offb.c fix
Message-Id: <19981223043717.005394@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed is a small patch to offb.c that fixes a problem with some ATI
displays in 16 
(and potentially 32) bpp. The kluge used for accessing the colormap
should be used only for 8 bits, it broke 16 bits on my PowerBook G3 Series.

Geert, could you explain me briefly where I should put the static
colormap that bootx gives me ? I mean, in 8 bits, especially for non-ATI
display (without the hack), the colormap is fixed and currently set to
the logo colors. I plan to set more useful colors but currently offb
makes no use of the colormap provided by bootx. Implementing this would
allow userland stuffs to know which colors were set by bootx.

I'm not sure of what I should do with this cmap, where I should store it
in the fb device structures...

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="offb.patch.gz"; x-mac-creator="477a6970"; x-mac-type="477a6970"
Message-Id: <19981223043726.027646>
Date: Wed, 23 Dec 1998 04:37:26 +0100
Content-Transfer-Encoding: base64

H4sICGt+gDYAA29mZmIucGF0Y2gApVNrb9owFP1MfsVVK23QEEgCpRTWjkfpWpUN
VGCjmqbISRywCDZywqPq+t9349COPjR1m79cP865vr7n2DAMCBlfbgpCsknRl2xF
ZVRcMZ+KoggCt+BlPgsOZ9QDqwx2qVY+rNlHYB0fVzVd17dkn65e536jvuLaJTAr
Nduulaspt9EA49C281YF9CTaFjQaGiQjYBvjNL5dUDiB85YzvOl3nH6zfdU5c/qX
4053UH+Gc8hyg1gT9zUjUzyA8XgMs3DpTygEQgKJGRwUNSMhsQCyUSy5N19kOZnT
POw1hzf5vTyUc3CCSXJwh0mWPGITjsWHgk/AJVFSDPF9SaMI3oG5CQJTjVG3jnDG
A2GcenOycIgvEcqEpLjKKqaO+CNFyOPMwphTe55nPiP7JCYJ+2k6Hax6Wv29Zmj6
6y/UdEjHVbpNOXFDfIDg4a3CVMFlcVSDNQVJSYi7vuDvY1gTHkMsYEq8GcRTChMy
n5PHdOsp5QkHwc4WTEBpDKniBWiGkQAWgyvFjKZnJyJQF69ZPIWWEPH4MSG6KRJz
Cs3hJXiCB2yylFi/4BFk+2JNJcJnEXwqqarpppADNGmL8os0BSoJD0r6dIH5UbZq
DhupDLFi0ZKEL5v4MfHS18vBqNl1+oPO6KzX7nV712nOOwyZt7pDz/ydPRD/H/54
yv6DQfSMMogK/9QJyOBQra3tIAZDFKq9C6ynPbtPZaBhRJH69Mbf9OH1qLNlgfr0
VbOcPwK9ah7nLVP9+UyELvGmkE3qtDELkYXEqs6CSmfBNjRMug77LPBpgKnbvS/O
RXPgtM9bVkVTuoGX9NGq1NAFmW2awEV3OcmrC17gWpXvkk64+IHVZdUMPnwACzv9
c2d9iMuk4xKlVTgfTk+hlFOaWoFSYyIp/gg8TScvzt1wmbghq+KL07cU5++Ull7y
UJqSCEVS6HqydPEvz3C2T7nPAu0XbxZgy9AFAAA=

--==_Boundary-1_==--



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
