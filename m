Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C39@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Tue, 9 Oct 2001 11:57:29 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I send you in attach the 'rpc' and 'services' files I loaded
> on the target (I hand-wrote them first, unsuccessfully:
> I copied then these ones from the host).

This is a good approach. The files seem to be correct.
(BTW, I think the rpc file comes with the glibc distribution).


> (Note that I type the 'mountd' command, but it doesn't
> appear in the ps -aux output list!)

I guess it died, even after successfully registered with the portmapper.
Here are some ideas I have to verify everything.

1) Does it produce a core file?

2) You may start mountd with the following options:
     mountd --debug all --foreground
   This will start mountd in foregroud, turning on debugging information.
   I hope it will help...

3) You may also start the syslog daemon, to be sure you don't miss important
information.

4) Also, is the file /etc/exports present?

5) I see that the nfs startup script performs a 'exportfs -r' before
starting the daemons.
   Could it help?


> While if I type the same command for the host the
> mountd uses a different port number...

This is correct, since the port number is assigned randomly, unless you use
the command line option '-p' to force mountd to bind to a specific port. The
rpc port number should be identical, and correspond to what is in /etc/rpc.


> while, exactly meantime, the following message appears
> on the target's console:
>
> svc: unknown program 100005 (me 100021)

The mountd process (rpc port 100005) is not in the process table, because it
unexpectedly died, even if the registration still appears in the portmap...
as if you kill mountd with a SIGKILL (9) :-(

Good luck!
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
