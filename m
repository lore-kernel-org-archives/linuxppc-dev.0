MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ml300 system init very slow
Date: Tue, 2 Mar 2004 06:22:24 -0700
Message-ID: <8039970AF146314597457D3B51A68B388F36B2@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just in case nobody answered yet (I didn't see an answer), the problem 99.9999% certainty is that your serial interrupts are not interrupting so the kernel is polling for serial I/O.  This is a fallback operation with REALLY LONG timeouts.  The symptoms are REALLY SLOW console interaction == your symptoms.  Your follow-up message indicates the problem is in your serial driver module.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Lou
> Rickard
> Sent: Monday, March 01, 2004 7:08 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: ml300 system init very slow
>
>
>
> Thanks to people on the list, I finally got the ml300
> booting on it's own filesystem.  Thank you.
>
> And of course, another question.  After kernel boot is
> done, the system begins intialization, but it goes
> REALLY slow.
>
> It gets to the:
> "Freeing unused kernel memory: 64k init"
> line just fine, but from that point, it takes about
> five minutes to finish coming up and  providing a
> login prompt.
>
> From the following lines:
> "INIT: version 2.78 booting
> INIT: Entering runlevel: 3
> Entering non-interactive startup"
> and on it's just super slow.
>
> At a certain point it starts inetd and telnet
> services, so I can acually telnet into the box and
> everything in that session seems nice an perky, just
> like normal, but everything over the serial line is
> slower than molasses.  This is both over the NFS mount
> and using the flash file system.
>
> Any ideas?
>
> Thanks,
>
> ~lr
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
