Message-ID: <3AB591DD.6ABFCF1B@routefree.com>
Date: Sun, 18 Mar 2001 20:58:06 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM405 gp walnut
References: <3AB4E320.233162CD@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> I am trying to get an es1371. sound module working on an IBM405 walunt
> developement kit.  8 bit sound works ok
> but 16 bit sound sounds like noise.  Will this driver have to be made
> Endian  aware?

Yes and no.  A lot of the player programs are not very endian savy.
Typically what I have seen happen on bigendian ppc is that either the
player asks for AFMT_S16_LE  but really sends  AFMT_S16_BE samples and
you get noise (sox/play does this but I worked on a patch for this with
Chris Bagwell so hopefully it is available now) or it asks for
AFMT_S16_BE samples and the driver doesn't support this and the request
format ioctl defaults to AFMT_U8 instead and the player ends up sending
8 bit samples instead of 16, because it didn't also do a query for
AFMT_S16_LE.  An earlier version of madplay was doing this (I tooked the
easy way out and had our sound driver return AFMT_S16_LE as the default
format to get around this, but the query algorithm in madplay could be
made better).  It looks like the es1371 driver defaults to AFMT_U8.
	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
