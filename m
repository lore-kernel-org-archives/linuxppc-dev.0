Message-ID: <3F0B94B2.5090607@earthlink.net>
Date: Tue, 08 Jul 2003 21:06:10 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Solves problems when PHY has no interrupts
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEStream=_0+106105_563697124402_802731020411"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--MIMEStream=_0+106105_563697124402_802731020411
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hello all,


the enclosed patch applies to the Monta Vista 2.4.22-pre3 kernel
or thereabouts.

Our PPC implementations have no PHY IRQ support.  I notice that
the file arch/ppc/8xx_io/fec.c now has a variable HAVE_PHY_INTERRUPT,
which is something like what I originally did.  But, I had to
make another change as well.

Specifically, I had to move some initialization code around for the
Ethernet to work properly after "ifconfig eth0 down ; ifconfig eth0 up".
Without these changes, the Ethernet doesn't come back "up" :(

The changes in this patch are done so that people WITH a PHY interrupt
have things done in the original order (I can't verify my change
against a system WITH PHY interrupts, so I preserved the order).
In short, this fix should be safe for all systems, but maybe
overly paranoid.

Anyone care to inspect and comment on the viability of this patch?


TIA
Dean Matsen


--MIMEStream=_0+106105_563697124402_802731020411
Content-Type: application/x-bzip2; name="fec.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="fec.patch.bz2"

QlpoOTFBWSZTWUfrSxYAAW1fgGgwW//////3/+6/7///UAUZ5hram7gAABwlTQpgInkBqNqA
DQ0YjI0AAANAaZADSUA0BoA0AAAAaBkAANAaAANMoJNDSaNqGg0BkAaAAADQAAABzTEZGTTJ
oBkNGQyZAAADI0yNAwhkCSQE0ARoNEKY0jR6jR6g0ZGj0gPUxBkAxqQAFbnCiC1UAE3hKDjc
Yve8awgBzh8AYpkSSmQiC4pwVn7s33xgrNkggqMjnj9M1hzm96EszwfL2js3wzdnaPpYz+oc
2OBhAdFwqpjy/22xhZbOZqo5mZVBR45BxATAG0DuBL0EK2XPMvO/0716NAzf3s8ekhRU6bn3
6NyWMYxMx8Ni5tTaISxhpj6KUs21uvscLcNVKmNjGMZiLU0Md6fozIIqhJlNyBEMWHfaT3ll
FBeAgMKUyVtioZpJfjLBBMR5E652PkRHrViGQXWJKdOCyOta46aZdYR1iWN156gH2CxpXnOk
Cnbdxk0pAyXCsaVpoqFFwIX4SotScIidXUUcKlORh16ktetOUUkwRILaNfEgPW1ix9atRLMq
VQYCUhFqcdRcV62y146sUNdzVHNTYhnX+RpvcOlX4g8AEmTDGbknjCOUSWpgTH+OeBb2nuyS
Mes1h12Cz6vFrIJX9JmGMWBMwFOWjbZgge2dwu0xTzu97RC3h42GYvYkdE+g757UwY29R1PP
C8QDDQy7FgZQgONreiZTjWiYvlTPL0XwiqEzKhMYbMFI+pBBxHIqBfTDpsSTNFpGnJn3sH7d
pWihcKIILjBy0RBBEpLs/sIKusqJwNylAJxAIGyGIwYPJR/cXy9TIxjCaozUCbUAQd5N54tg
uCoA7EGmsgDg6IA8jzHKoTlStBedqwWAHWWFR5t75AXE/mzQRErKkFF5GKCZv6FsN0CwoZTU
MxTFCoBqymsWwU6tCgqwJohM1IXl8nwc9Jc3x6CvA/gZGY5B953/qHezy4F4fg8+1QUj6DzD
8xioJBWm9dDr3z6y44qE15/cLSyKUSjeMcglFtZMgYMW/j/KsXpJnXkZDDJftIieU1XEJa05
Nd4nPhQ4A4KitjBzh5YbFAiPW5FoplaucOPOw3SA5YYDopWp48YZk2iYMTczP3m4qWsiSLnE
x7iR2D5Gre4pUUrGZjJAxWbCRtJpFbzaxev7VB07YJZK0SwukuFyYooHIMp2Ac1LkUM43g8Q
YhisgZDAzivQpUSklyla6A4jI4vciu4rChQi7kmoxB8B2RvGkmQblo9Q8Ec9EETA9VYEhcDZ
uuK3JZcbGAzW5uUDmjhRwenaNMqgcU2jIePLy9ZcxIZ5ubXv9XExtC0sgm1nUXYGqa5FxhoO
kwSNyqHEhmmJnFhTgRLFrXAtTBtHF5NwMc9WcdUVd6yBKDQFoPHpQTlQmMQUEQEw87jybIMd
ibR4wyxyCo02kCOMweiRqxduOJxkrqtRvLXAsqBwM9FliMsGI67AqdE7ZB3AmVEFa4YLLxwM
xC4g9RLKA5KkDwwiKqAqhVMm3BoojsnsRbnORxrUx0ca7cGZiI8HDJv3gYj+0xt4YA6Vu86Y
ljzNh044xxnIZMtHMhPB5ZUjEfcIcbCSiQUwo04k6B3SAdnsGN/Zn2GGKtwOQML12rFEs1GC
SyGYtSGLFxnBFVygBqVx12x3iUVqiVlgKKFQIYpYn/F3JFOFCQR+tLFg

--MIMEStream=_0+106105_563697124402_802731020411--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
