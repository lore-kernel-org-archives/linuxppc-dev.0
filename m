From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15577.52276.175752.518900@argo.ozlabs.ibm.com>
Date: Thu, 9 May 2002 11:09:08 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>, acurtis@onz.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 and skb implementation
In-Reply-To: <3CD8BCF7.1090102@embeddededge.com>
References: <NCBBIINEHIPFGJPLBEIFGEKKDGAA.acurtis@onz.com>
	<3CD8BCF7.1090102@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> We should make the change to the receive side so this happens.  The
> transmit doesn't copy.  I just copied the code from the 8xx long ago
> and never made the change.  We can't properly do zero copy receive
> on processors that don't have coherent caches due to alignment and
> other information potentially shared in a cache line.

Doing zero-copy receive requires intelligent adaptor firmware/hardware
that can look in the headers and put the packet in different places
depending on what it finds.  Very few adaptors can do this and I
assume the CPM can't.

Cache coherence shouldn't be a problem on transmission generally since
the adaptor is just reading the packet.  On reception we need to make
sure the data area of the skb is cacheline-aligned.  Since the driver
allocates the skbs this should be easy.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
