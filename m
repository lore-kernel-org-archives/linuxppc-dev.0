Date: Tue, 6 Feb 2001 12:14:15 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: pmac netdevice driver probing bugs
Message-ID: <20010206121414.A7877@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the current device probing code for mace,bmac and gmac returns always 0
and the module can be loaded even if the required hardware is not
present.

cherry:~ # modprobe pcnet32
/lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: insmod
/lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o failed
/lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: insmod pcnet32
failed
cherry:~ #  modprobe bmac
cherry:~ # lsmod
Module                  Size  Used by
bmac                   12512   0  (unused)
nfsd                   75888   4  (autoclean)
autofs4                11920   4  (autoclean)
ipv6                  151488  -1  (autoclean)
gmac                   15248   1  (autoclean)



Can we change that behaviour?
de4x5 and pcnet32 return -EIO as example and the module is not loaded.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
