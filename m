Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Conn Clark" <clark@esteem.com>
Cc: "May Ling List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Poor 8260 FCC Ethernet performance
Date: Fri, 31 May 2002 20:09:49 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEPEDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CF79C16.4B547602@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Could it be an analog problem? Have you looked at the signals
> comming in on
> a scope?
>

Looking at the signal with a scope is probably a good idea. Here is an
update from today's fun.

1. These is an error in the fcc_enet.c file which causes NO and CRC errors
when running in full-duplex mode. fcc_restart() should be updated to include
FCC_PSMR_LPB when configuring full-duplex mode. (cleared when not)

2. Some relative performance measurements (HHL 2.4.2 vs. 2.4.19pre9)
			10T Hub	|	100BT switch
		 -------------------------------------|
	2.4.2	 |	410KBps	|	750KBps	  |
		 -------------------------------------|
	2.4.19 |	440KBps	|	190KBps	  |
		 --------------------------------------

	RedHat 2.4.18-3 (x86)	3900KBps

3. TOP shows as much as 48% system utilization during a single FTP transfer.
With the fix mentioned in #1, there are 0 errors reported by ifconfig.

I may be missing something but I believe that these numbers are going the
wrong way. There is still the question of performance decrease when using a
100BT switch. Signal intregety can not be the only suspect considering the
performance did increase using an older version of the kernel. (although
nothing like the Workstation performance)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
