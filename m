Content-Type: text/plain;
  charset="iso-8859-1"
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4: PCIBIOS_MIN_MEM correct?
Date: Sun, 4 Feb 2001 13:00:40 -0600
MIME-Version: 1.0
Message-Id: <01020413004001.06077@momiji>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


should PCIBIOS_MIN_MEM be 0x10000000?  I caught this when i noticed it is
used as the minimum address in the pci assign resource function, used in such
situations as the OF/ATY-overlap re-allocate in wallstreets.  My system would
panic with the lcd melting effect as some may recall.

I brute forced in the following lines in
drivers/pci/setup-res.c:pci_assign_resource()
     min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+    if(res->start==0)
+         min = 0x83000000;

resulting in the same mapping used by Michael Schmitz earlier 2.2 patch.
(its the only re-alloc on my system, so it works :)  My kernel isn't
panicing.. yet.

Anyway, looking in /proc/iomem, one might get the idea that PCIBIOS_MIN_MEM
should be defined as 0x80000000.  This might resolve the problem I had in a
less brute way.  I haven't tried it myself yet.  waiting for a second opinion.

The macro appears to be new in 2.4, so its understandable why it looks like
most archs seem to have similar values.

Any one have any insight on this?

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
