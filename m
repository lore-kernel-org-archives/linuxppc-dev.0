Message-ID: <20000427003918.14494.qmail@wwcst271.netaddress.usa.net>
Date: 26 Apr 00 19:39:18 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Fix for Linuxcare pre20
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is a missing fi in driver/net/Config.in that breaks menuconfig and
causes problems in xconfig too. I also had problems selecting NFS server in
the network filesystems section until I fixed this.

Starting at line 47:
  if [ "$CONFIG_PPC" = "y" ]; then
    tristate 'MACE (Power Mac ethernet) support' CONFIG_MACE
    if [ "$CONFIG_MACE" != "n" ]; then
      bool 'Use AAUI port instead of TP by default' CONFIG_MACE_AAUI_PORT
    tristate 'BMAC (G3 ethernet) support' CONFIG_BMAC
    tristate 'GMAC (G4/iBook ethernet) support' CONFIG_GMAC
    tristate 'Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
  fi

There should be an fi after the new AAUI line. This causes menuconfig to crash
and xconfig will not allo you to select BMAC/GMAC is you do not select MACE.
Corrected section should look like this:

 if [ "$CONFIG_PPC" = "y" ]; then
    tristate 'MACE (Power Mac ethernet) support' CONFIG_MACE
    if [ "$CONFIG_MACE" != "n" ]; then
      bool 'Use AAUI port instead of TP by default' CONFIG_MACE_AAUI_PORT
    fi
    tristate 'BMAC (G3 ethernet) support' CONFIG_BMAC
    tristate 'GMAC (G4/iBook ethernet) support' CONFIG_GMAC
    tristate 'Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
 fi

I did not think this one line really deserved an attached diff file. :)

-Jeramy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
