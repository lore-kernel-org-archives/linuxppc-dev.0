Subject: Re: 8260 Network Performance update
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: acurtis@onz.com
Cc: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEDMDIAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFOEDMDIAA.acurtis@onz.com>
Content-Type: text/plain
Date: 06 Jun 2002 14:31:05 +0200
Message-Id: <1023366665.24574.51.camel@groo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if this has any relation to what you do but I have had
serious problems with nfs and 2.4.19-pre versions on X86.
Some combination of kernels have even resulted in a complete nfs failure
for the mount point.

Version 2.4.18 works and 2.4.19_pre10 works also (same version on server
and client) others have gone from lockup to 20-30 kB transfer speed when
going from nfs to nfs. One way transfers usually works ok.

I have not seen any problems with tcp traffic so it probably is
something different.

Hmm are you storing the ftp transfers in nfs ?? try mounting tmpfs and
run from that.

On Thu, 2002-06-06 at 07:00, Allen Curtis wrote:
>
> 1. Unidirectional TCP/IP traffic (ftp):   get 180MBfile /dev/null
> (Thanks Jean-Denis)
>
> 			10T Hub	|	100BT switch
> 		 -------------------------------------|
> 	2.4.2  |	839KBps	|	6526KBps	  |
> 		 --------------------------------------
> 	2.4.19 |	838KBps	|	9412KBps	  |
> 		 --------------------------------------
>
> These numbers look good!
>
> 2. Here is a description of the original test and some new test results.
>
> 		-------------	FTP Put	-------------
> 		|		|---------------->|		|
> 		|   Host	|	NFS save	| 8260 PPC	|
> 		|		|<----------------|		|
> 		-------------			-------------
>
> Given that the unidirectional transfers look good I assume that the problem
> is either resource related (running out of Ethernet buffers) or scheduling
> related. The following tests use the 2.4.19pre9 kernel but vary the number
> of RX/TX buffers. (symmetric allocation)
>
> 			10T Hub	|	100BT switch
> 		 -------------------------------------|
> 	16 RTB |	440KBps	|	190KBps	  |
> 		 --------------------------------------
> 	32 RTB |	450KBps	|	230KBps	  |
> 		 --------------------------------------
> 	64 RTB |	450KBps	|	240KBps	  |
> 		 --------------------------------------
>
>
> The above data shows that this is not a raw communication speed issue but
> rather a scheduling or resource issue where either FTP or NFS is getting
> starved. My guess is that FTP is taking all the receive buffers leaving
> nothing for NFS to work with when storing the file.
>
> Does this help to identify the problem and a possible solution? Additional
> tests recommendations?
>
> TIA!
>
>
>
--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
