Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dejan Jovanovic" <dejanj@jaspur.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Booting Linux Kernel on a EST8260
Date: Fri, 23 Aug 2002 06:55:48 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEBMDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <014101c24a16$e8f6cea0$db00000a@dejanj>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> "Warning: real time clock seems stuck!"
> mean?

It means that the RTC is not connected to anything. Look in m8260_setup.c if
you want to use the 8260 counter timer.

> 2) I was hoping that I have configured the bootargs corectly. But
> it seems that
> something is wrong because of the messages
> "
> Looking up port of RPC 100003/2 on 10.0.0.245
> portmap: server 10.0.0.245 not responding, timed out
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/2 on 10.0.0.245
> portmap: server 10.0.0.245 not responding, timed out
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 10.0.0.245 not responding, timed out

One of two things:
1. You do not have your Ethernet clocks etc setup exactly like the driver
wants. Look at 8260_io/fcc_enet.c (assuming that you are using the FCC's)

2. Run tcpdump or some other sniffer and make sure your NFS/Bootp server is
setup correctly.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
