Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C24@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Tue, 2 Oct 2001 10:32:11 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I can see that portmap is suspended:
Do you mean that it is sleeping instead of suspended?
In the STAT column of ps, a 'S' means 'sleeping'.
Look at the 'ps' man pages.

> I guess it is correctly waiting for
> RPC calls and for other daemons (such as mountd and nfsd) to register.
I think you are right.

> But if I try to run mountd or nfsd (# ./mountd,  for example)
> I get the same
> errors as portmap wouldn't be running at all.
Be sure that the file '/etc/services' in the target includes the following
entries:
  sunrpc   111/tcp   portmapper   # RPC 4.0 portmapper TCP
  sunrpc   111/udp   portmapper   # RPC 4.0 portmapper UDP

Also, be sure you have the file '/etc/rpc' present in the target.

> Can you explain me how?
> Should I cross-compile it for my PowerPC platform, load it on
> the target and then run it?
This is a script, so it does not need to be compiled.
The only thing you need is the interpreter (first line in the script).
That script invokes the Bourne Shell (usually accomplished by bash).
The script should be invoked at the command line, giving it a parameters.
Valid parameters are: start, stop, restart, reload and status.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
