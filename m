Message-Id: <200105062051.WAA00715@piglet.grunz.lu>
Date: Sun, 6 May 2001 22:51:02 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Airport in BenH's kernels (a few tips & tricks)
To: benh@kernel.crashing.org, debian-powerpc@lists.debian.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010506202801.14354@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   6 May, this message from Benjamin Herrenschmidt echoed through cyberspace:
>  - typicall setup sequence:
>
>     modprobe airport
>     ifconfig eth1 <ip_address> netmask <mask> up
>     iwconfig essid <network name>
>     iwconfig enc <WEP key>

Here is my take at integrating the configuration with a Debian system
(most of this is applicable to other systems as well, with slight
modifications):

- Add an entry for eth1 into /etc/network/interfaces, in my case with
  the same config as eth0, and since I mostly use the TiBook at home,
  default to eth1:

-------------------------------
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)

auto lo eth1

# The loopback interface
iface lo inet loopback

# The first network card - this entry was created during the Debian installation
iface eth0 inet static
        address 172.20.8.26
        netmask 255.255.255.0
        network 172.20.8.0
        broadcast 172.20.8.255
        gateway 172.20.8.1

# Airport module
iface eth1 inet static
        address 172.20.8.26
        netmask 255.255.255.0
        network 172.20.8.0
        broadcast 172.20.8.255
        gateway 172.20.8.1
---------------------------

Now, when I'm too far away in the house from the base station, or when
airport doesn't work once again (;-), I can ifdown eth1; ifup eth0 do
switch interfaces.

In order to config wireless stuff, I added this in
/etc/modutils/airport:

----------------------------
# Airport modules config file

alias eth1 airport

post-install airport /etc/network/airport-config
-----------------------------

Run update-modules, and you're in business.

The file /etc/network/airport-config contains the wireless-specific part
of the eth1 config:

-----------------------------
#!/bin/sh

# Cater for wireless tools installed locally
PATH=$PATH:/usr/local/sbin

# Airport interface config commands
# sets up crypto and stuff

ifconfig eth1 up

iwconfig eth1 nick <nick> mode Managed
iwconfig eth1 rate Auto
iwconfig eth1 essid <Network name>
iwconfig eth1 key <Encryption Key>
iwconfig eth1 enc on
iwconfig eth1 enc restricted

# This adds too much delay...
#iwconfig eth1 power on
--------------------------

With this config, everytime the airport module is inserted, all the
relevant wireless parameters are set. With the airport card not being
powered down anymore on ifconfig down, this should be all you need to
do.

Have fun!

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
