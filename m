Date: Fri, 23 Aug 2002 17:19:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: ocp emac phy wierdness
Message-ID: <20020823071911.GF18818@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There seems to be a whole lot of stuff related to phy handling with no
clear purpose to it.  The table phy_cmd_config appears to be unused,
as are the functions mii_queue_config, mii_display_config.

Furthermore process_mii_queue() is dispatched through schedule_task(),
from mii_queue_schedule().  But the only place that is called is in
ppc405_enet_open(), which immediately calls schedule() to wait for the
job to be completed.  So what the hell is the point of the
schedule_task() rigmarole?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
