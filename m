Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 Network Performance update
Date: Wed, 5 Jun 2002 21:55:51 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEDMDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


1. Unidirectional TCP/IP traffic (ftp):   get 180MBfile /dev/null
(Thanks Jean-Denis)

			10T Hub	|	100BT switch
		 -------------------------------------|
	2.4.2  |	839KBps	|	6526KBps	  |
		 --------------------------------------
	2.4.19 |	838KBps	|	9412KBps	  |
		 --------------------------------------

These numbers look good!

2. Here is a description of the original test and some new test results.

		-------------	FTP Put	-------------
		|		|---------------->|		|
		|   Host	|	NFS save	| 8260 PPC	|
		|		|<----------------|		|
		-------------			-------------

Given that the unidirectional transfers look good I assume that the problem
is either resource related (running out of Ethernet buffers) or scheduling
related. The following tests use the 2.4.19pre9 kernel but vary the number
of RX/TX buffers. (symmetric allocation)

			10T Hub	|	100BT switch
		 -------------------------------------|
	16 RTB |	440KBps	|	190KBps	  |
		 --------------------------------------
	32 RTB |	450KBps	|	230KBps	  |
		 --------------------------------------
	64 RTB |	450KBps	|	240KBps	  |
		 --------------------------------------


The above data shows that this is not a raw communication speed issue but
rather a scheduling or resource issue where either FTP or NFS is getting
starved. My guess is that FTP is taking all the receive buffers leaving
nothing for NFS to work with when storing the file.

Does this help to identify the problem and a possible solution? Additional
tests recommendations?

TIA!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
