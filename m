Subject: PATCH: arch/ppc/8xx_io_fec.c
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3245D.AFA72F20"
Date: Tue, 27 May 2003 10:38:49 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C3245D.AFA72F20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I discovered an old bug in the Fast Ethernet driver of the 860T.
In function fec_restart, the FEC is reset with no concern
to pending MDIO requests.

If an MDIO request is being served while the FEC is reset,
it is lost, causing the system to hang if it is waiting for
the answer (MDIO read). It may also lose a register modification
request (MDIO write).

1 - Especially at boot up, in function fec_enet_open, we could hang on:
        while(!fep->sequence_done)
            schedule();
2 - Or, the worst, in function mdio_read called through the ioctl,
    which would hang the calling process.

I encountered only the first problem, hanging at boot up just after =
printing:
  eth0: Phy @ 0x1, type DP83846A (0x20005c23)
The problem was extremely rare, due to a link down/link up sequence
that occurs at every boot up, and probably an MDIO request queued just
before the time of the FEC reset.

Attached is a patch (over 2.4.21-rc3) that adds two functions:
  static void stop_mii_queue(struct net_device *dev)
  static void start_mii_queue(struct net_device *dev)
that are both called by fec_restart.
The tests I performed easily demonstrates that we no longer loose
an MDIO request when fec_restart is called.

I also cleanen up some code around the MDIO management.

1 - In function mii_link_interrupt, I removed the code that juggles with
    the bit ECNTRL[ETHER_EN]. It is completly useless since the MDIO =
will
    work no matter the state of this bit. It can also as bad effects
    to put this bit to 1 without initializing the rest properly.
2 - In function fec_stop, I simplified the code, since there is no need
    to reconfigure all the registers after a graceful transmitter stop.
    Especially, the code that "Clear outstanding MII command =
interrupts."
    should not be there.

I'm waiting for comments.

--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Inc.
 4283 rue Garlock
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

------_=_NextPart_001_01C3245D.AFA72F20
Content-Type: application/x-gzip;
	name="patch_8xx_fec_20030526.diff.gz"
Content-Transfer-Encoding: base64
Content-Description: patch_8xx_fec_20030526.diff.gz
Content-Disposition: attachment;
	filename="patch_8xx_fec_20030526.diff.gz"

H4sIAAuB0j4CA61WbW/aSBD+bH7FtJUqEzAvJkASmihRQu+QEloRot6Hk6yNWcMqxvZ51zSozf32
m9m1gyH02uuVD8Zaz+szM8+s4zjgNg4bbttJ/U4jTsW8yVJ/0UwSv3n0+OiJuBlwv+FbN3EEN2wN
bg/a3ZOOe9LtgttqdSq1Wq1k4ge0+yetzkmrZ7TPz8Fxe269BzX668P5eQWWQnihkMpT1gG9Bynn
g5fHC85me44VE+GgUhORguJHx1LFScJJoQJqjW88AKnSzFewnInYS9GaN2OKwZcKWFm7Bymfrxia
ohj7rT7F2G8d1Y91jBZP4BTe2rYtlkuWeAoOqqObi4/exdXVpOqciaXnJ8uGn3iIQBW9WhQEmkQt
njhneOrRCXmkmGqWCOxSnFU8sVKusjTCZFBdBGCjAHktkq/C6SmM766vqzpmK0kx6Qf79c1oBCya
QRQDib36M3qtI3i2pzPqdhDuWr/brx+ZjCyrgE/7SLTKE/BQcmPfKhznMZRFHfxs/ygc1e380UaB
NSZNQLzaReKXGKd08FFOCRHBTyjTzlHpHeo6947rnZaBxYBmG0nC8YnK1TyA91nkKxFHElQMFGxT
KpYqUAsOKmWRXAop8TvEAYbwV8alQtFFGmfzhRa6uRp9aFRqcADTBV8DSzlgAXk04zMyec8hk/h6
z4MYP1FFWaB4CgzeDy/RpORKqzcrNfSshA+rWMx0KDp9dJlxO2/yiCtvxlfC53CA/4jqFwQ2i6SY
R+gkjKM5BCGbSywCzYxkK+7pA1s/q/m5Hwqb3q1SiQx++jNGpTDaXc0n7OGdIBGq/xeltYpDNBhy
oHpjU/zHkfyZNFuDzaTqETTS9Nud6tKgOmf58Jse/w5OUMZJW4s9fzn7BkR18LEFFSSLNUlR1n61
orubKPDB9HW7e9hG5qq1u/0WNjg19hsRIAdalx/G70e/eXe3Q4/6EdWMH2vHD6aDT08Qg+YiGndO
csg8K6ZQMNA1QEHnjM6IF56r9FwV/YJi++q0pZHXFf9MZbX8y0I6mwahlLkfqZRmmvRMTcyR5v7i
1zzYvOMEXvgPUfw55LM517NJg5imWaIAiTeJcZDvQ96AUQCfOSywaZBdVQ4tMmnbYHucc2nJMNsY
xv5lNL/36w1yccIju9pATGmODc0H1EpYT6J15FWMFJ9o6hM65cQNGB8xAI8YBqW5gvk+l9Kwymhk
5Jv0p9dGjshb0vKGl+Pp5NobTn8fTrzhWC+RVu7K2oUMvp7uU9J8/1RxiEJLHarbsYjeOcPUPcTR
7J5dsaJfUx6K6KE6oIroqSAKJa6bCZmEeGegacikTudXJHSa98fAyv0Rt8YhMhJXSkRzmQOnNwVO
Ce0KfDW7FezX6PEEsog/JtxXCP41Rr/pFrNq9a3GbZtrjev26+22bgu082JAcJeYSYTdSaxRhLdI
Pc/LAkd9ucwi4TPaO4AG4pSqb1aBXgTWDvsTiSKvvMGtIgJ9kUCjnxZYGlwjuR41llzEGYLwmQkc
a7K6EJK6UjflHhBLwH8cjW/u/oCv5bPJ8HY4zYHouMcaiM7hcQHEz5rd9F9ZO0Wekh7DZYxjibV/
bLVb+kc3p39Fd8KdouHWkBBGuF9eIv0M7fbO2sZW3wvK3J1n32vVXZfSP+rm91trq5tAiSWPMwVY
0XnKfB5kYXF/UHqZF/c3cuBQ2JchZymgDnrLY8YrH4VMg/PcjFhAx9LdvMFK8BVHjsyRHg+nHqoO
9Gih4aFmlC1rgYiEXPCS2T1GV9wnPiebo/F0OJncfZw23Sq8ewfu8WBbdsnkwz7/39hHOq5brnRQ
MkH+25OVXtL0TbO+4R9zgKZNfTRu27YLTsEvV0LqzDGql9YLtjmFv+19hJOv9G0zDbjmVNNwrSMv
FUU3Eyl8D5Qdoe+HgS34DydcF6LSDQAA

------_=_NextPart_001_01C3245D.AFA72F20--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
