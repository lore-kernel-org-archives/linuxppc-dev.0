Date: Tue, 14 May 2002 16:30:09 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] fix ibm ocp ifconfig oops (for real this time)
Message-ID: <Pine.LNX.4.30.0205141628280.29257-101000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="394922409-492577129-1021419009=:29257"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--394922409-492577129-1021419009=:29257
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here is a shorter patch that actually works. Please disregard my last one.

--- drivers/net/ibm_ocp/ibm_ocp_enet.c	Tue May 14 16:24:17 2002
+++ drivers/net/ibm_ocp/ibm_ocp_enet.c	Tue May 14 16:25:58 2002
@@ -244,14 +244,11 @@
 		fep = (struct fec_enet_private *) EMAC_DEV(ocpdev);
 		emacp = (emac_t *) EMAC_DEV(paddr);
 	} else {
-		if ((emac_driver =
-		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
-			return -ENOMEM;
+		emac_driver = ( struct ocp_driver *)dev->priv;
 		strcpy(emac_driver->name, "emac");
 		emac_driver->type = EMAC;
 		/* this returns the next emac number */
 		if ((emac_num = ocp_register(emac_driver)) >= 0) {
-			dev->priv = (void *) emac_driver;
 			emac_driver->priv_index = dev->ifindex;
 			emacp =
 			    (emac_t *) ((struct ocp_driver *) dev->priv)->paddr;
@@ -676,6 +673,10 @@
 		dev->set_multicast_list = &ppc405_enet_set_multicast_list;
 		dev->do_ioctl = &fec_enet_ioctl;
 		emac_dev[curr_emac] = dev;
+
+		if ((dev->priv =
+		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
+			return -ENOMEM;
 	}

 	for (i = 0; i < NMII - 1; i++)

--394922409-492577129-1021419009=:29257
Content-Type: APPLICATION/octet-stream; name="ibm_ocp_enet.c.patch.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0205141630090.29257@hill.cs.ucr.edu>
Content-Description: 
Content-Disposition: attachment; filename="ibm_ocp_enet.c.patch.gz"

H4sICDid4TwCA2libV9vY3BfZW5ldC5jLnBhdGNoAKVSTY/TQAw9J7/C2gPK
NA1NSj9QS6oi6GGlTbkAF4SibOLASPnSZFJtF/HfsSclzYrlAj10Mp737Pds
e54HmZInVO2sQj2T92Vcp83vM0YKvkytjx1ClJwhWECw2swXm2ANc9+f267r
/gN/uVm+7vn7PXjzxWJKD645A9jvbbCsHBsIwWm16lINOaYmVdxQrUQjTAQc
orfv4veHzw7VyfAktkzDMkkNkT9i/QTXJFmmDOwnYNEi/LA9y5I5OD269wEh
R4F/bCApipqe8OS08hHr/K+ShBAQhnD8dHcnOIOlUHeqAu9w/BAdoq3t9uqG
MuDAJRXXuUQngkp5O85p/BAibc5jfd6uSkqcwg3Hbq6uh2d9bpCys23zOJuA
/i5b6PW0dEGo8EEDs6DqynuuO2PotRcUphwsTOE32WpUYw1kdReCL/oOWoNk
NnWqZcZtH8GNjKciGR3LKsMH4hi+zM31iqUxmm+exGicjvNc12DQIOjgQW/N
bq3Wq+kK3NX61TTwL6tloC1NruwKLdOk1XFBFknIi6ZJF/6yn+ufiO3AzupY
1qkumDMsgomM5oGnL2mnVMy3r71N2gLeA9PnUdc49p8b5z6zcbToNtB/Xitw
JCnwtyDhDRyj21vwIKCb6wr7F3WV7ugEBAAA
--394922409-492577129-1021419009=:29257--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
