Message-ID: <39F438F3.FEC7F99@snmc.com>
Date: Mon, 23 Oct 2000 08:11:15 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Julia Elbert <jelbert@enerdyne.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HDLC/PPP Driver
References: <67505026E29DD311A9AA00508B7315F350A569@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Julia,

I've not tested the HDLC/PPP driver on SCC2, so there could be a bug
lurking there.  Check the table named "SCC_Params" in the hdlcppp.c
file.  Also check to make sure that the constants in that table are
defined correctly in the associated .h files.

Other than that I can't figure out how the kernel would confuse the
network device "hdlcppp2" for "enet".  The hdlcppp.c file registers each
device using the "register_netdev()" function, and this relies on the
device name.

If it had been the receive function that was called by mistake then I
would suggest that the hdlc/ppp driver was overwriting the IRQ vector
table incorrectly.  But the transmit function,
hdlc_ppp_hard_start_xmit(), is called directly from the network stack
(sorry about the bogus comment in that function header).

Daris


Julia Elbert wrote:
>
> Hello,
> Thank you for the white paper.
> My problem is my hdlcppp is confused with enet. It appears my enet is
> calling the xmit in hdlcppp after the enet open is called. Weird. How could
> this happen? My enet is on SCC1 and hdlcppp is SCC2. Could some parameter in
> hdlcppp have priority even when enet is loaded?
> Thank you for your help. I hope this is not to elementary.
> --Julia
>
> http://qslinux.org/docs/snmc/hdlc/index.html
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
