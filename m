Message-ID: <37D0F88E70D96C428C19EEB865701A38010EC833@buda902a.siemens.hu>
From: =?iso-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 FEC ? error
Date: Wed, 4 Sep 2002 12:41:40 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody similar experience ?

On a MPC8260ADS board works the 2.4.18 kernel. In the ethernet connections I
have found a special error :

The kernel succesfully starts with NFS root, but only BASH as INIT.

Any writing to NFS filesystem fails if it wants write more than 36 byte. The
system hangs, the last message is "nfs: server (IP addr of the server) not
responding, still trying"

For example

echo (string shorter than 36 char) (filename)
		is OK, but
echo (string longer than 35 char) (filename)
		fails.

cp (srcfile with same sizes as above) (destfile)
		gives the same results.

Obviously boot with normal INIT fails, it wants to write anything longer
than this limit.

On the server TCPDUMP shows the traffic as regular, up to (but not included)
the last write. The board
  1. doesn't send the last (data writing) packet, or
  2. sends it but erroneously.

Any help?
		Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
