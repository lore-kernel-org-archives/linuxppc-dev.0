From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.45 on B&W G3
Date: Fri, 18 Feb 2000 16:37:44 +1100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0002181639540B.05428@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have fixed the problem that was causing B&W G3s (and other machines with
a PCI-to-PCI bridge) to hang early on in the boot process with the devel
kernels.  The problem was that the pcibios_read/write_config_word calls in
the init_p2pbridge function weren't working (they don't work until the PCI
buses have been scanned now).  I changed those calls to ppc_md.pcibios_*
and it gets a lot further now.

My linux-pmac-devel rsync tree has this fix but is still at 2.3.45 for now.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
