From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8260 HDLC RX length errors
Date: Fri, 19 Mar 2004 19:32:50 +0100
Message-ID: <000c01c40de0$99954af0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <000101c3aaae$e61e4240$5201a8c0@GEG2400>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I work on a custom 8260 board and a 2.4.18 Kernel
with an HDLC driver on SCCs ports.

I want to limit the frame length to 1501,
so I use the mflr register :

volatile scc_hdlc_t *hp     = (scc_hdlc_t *)chan->mem_start;
...
/* set the MTU */
hp->mflr = chan->conf.hdlc_hdl_conf.hdlc_mtu;
...

The driver works fine with all frames lower than 1501.

When the CPM receives a frame of 1502 characters, it
closes the buffer descriptor with a BD_HDLC_RX_LG error.
That's right but all the following frames with a right
length (< 1501) are rejected with the same BD_HDLC_RX_LG error.

The BD flags are correctly erased after each error
and new buffers are provided to the CPM.

The problem is not bound to the frame rate.

Any idea

Thanks
Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
