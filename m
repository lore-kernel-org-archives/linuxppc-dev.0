From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Armin" <akuster@pacbell.net>,
	"=?iso-8859-15?Q?David_M=FCller_=28ELSOFT_AG=29?=" <d.mueller@elsoft.ch>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Several patches against linuxppc_devel-2.4.18-pre9
Date: Mon, 11 Feb 2002 19:10:42 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJCELKDKAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
In-Reply-To: <3C678EDC.20503@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin and David,

> The ethernet changes look fine.  there was on other change regarding
> resetting the EMAC. The ethernet part can go in as is our we can wait
> until tomorrow when I send in that change + multi emac irq fix.

I checked the EMAC/PHY patch on our board (CPCI-405 with Intel LXT971), and
the driver seems to start without problems without ethernet cable connected,
when the EMAC soft-reset command is removed from the init routine.

With the soft-reset in init still implemented, "fec_enet_mdio_read()"
returns with timeout, waiting for transfer to complete. The next soft-reset
in open leads to the same problem (timeout in mdio_read()), but doesn't lead
to a kernel panik.

So Armin, could you please remove the soft-reset from init (if nobody
objects, of cause).

Best regards,
Stefan Roese


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
