Subject: RE: This question may be simple for you, but it doesn't let me sleeping.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 13 Aug 2003 14:05:09 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED70303CA@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: <zjzhou@newrocktech.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have linux2.4.1 from Lineo runing on ppc8250, IMMR =
> 0xF0000000, in my driver function, I can directly access
> 0xF00xxxxx( internal memory area on PPC's chip), why?

A BAT is configured to map this region with addressing virtual == physical.
See function m8260_map_io in arch/ppc/kernel/m8260_setup.c

> When passing a logical address pointer to BD's address
> pointer that allocated by function kmalloc().

Memory should probably be uncached (as the IMMR is).
Use function m8260_cpm_hostalloc instead of kmalloc, then use __pa.
See for example arch/ppc/8260_io/fcc_enet.c

Regards,
--------------------------------------------
 Jean-Denis Boyer, Eng.
 Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
