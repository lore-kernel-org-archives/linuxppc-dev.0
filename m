From: Brian Waite <waite@skycomputers.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: RFC: gt64260 descriptor struct
Date: Thu, 27 Feb 2003 10:31:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200302271031.27317.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know this was very briefly discussed in the past but I am in need of doing
this right so lets start up the discussion again.

The gt64260 code relies on many defines and/or fw values when it should not.
For example the MPSC and eth both pull from a define or bi_struct for certain
information. We all agree this is not good. In house I now have 2 new
drivers, i2c and timer 4, that also would like some of this info.

What we need is a global structure for gt code that will describe the features
of the gt and export that to drivers that need it. What I see right now for
required elements are:

typdef struct gt64260_features {
	unsigned long mem_size;
	unsigned long bus_speed /* in Hz */
	unsigned char eth1addr[6];
	unsigned char eth2addr[6];
	unsigned char eth3addr[6];
	unsigned long baudrate;
} gt64260_features_t;


I really would like to hear from other gt developers and anyone else about
this being a good or bad idea. I am not sure we even need all of these
elements in the struct, ie gt64260_base, but I was looking for places we
conditionally look at the bd_t. Any thoughts?

Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
