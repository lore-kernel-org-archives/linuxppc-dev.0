MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Hang in send() to a socket
Date: Fri, 23 Jul 2004 11:55:03 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF50227A4@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi. I'm testing a program to send files thru a TCP socket on an MPC5200. The program itself is quite simple: reads block from file, adds headers for a custom protocol, and sends the packet to the socket.
This works without problems on x86 architecture, but in PPC, the programs stops forever in one of the writings to the socket after having sent a random number of packets. Strace says that it stops on a send(), and netstat shows that the connection is stablished, and stays this way:
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0  63903 160.100.100.169:12700   160.100.100.189:41097   ESTABLISHED
Until the kernel destroys the socket. The program isn't hanged, and it detects when the socket closes (Connection timed out) if you wait enough, and exits properly. It just stops in send().

Is there any know problem with this on the MPC5200?
The platform is a Lite5200, and kernel linuxppc_2_4_devel from Denx CVS.
Thanks

Iñigo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
