Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C41@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Thu, 11 Oct 2001 09:54:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Without the syslogd daemon I couldn't have been able to
> discover that the 'etab' file was missing in /var/lib/nfs target's
> directory.
>
> Who does create this file, on the hosts for example?
>  Which command or daemon?

I think that calling
  /usr/sbin/exportfs -r
before starting every daemons related to NFS is the solution.
Well, that is what the NFS control script does on startup...

> > 1) Does it produce a core file?
> What do you mean with 'core file'?

When an application crashes, by receiving either an ABRT signal or a SEGV
signal (segmentation fault), it produces a core dump file. The file name is
'core', and is created in the directory that was current when the
application was started. I don't know all the details, but this core file
saves the state of the application, at the time it crashed. Along with the
executable file, you can load this core file into gdb, and look at the
problem.

> >    mountd --debug all --foreground
> >   This will start mountd in foregroud, turning on debugging
> information.
> >    I hope it will help...
> How should I have debugged then? (I couldn't do it)
> I have seen nothing: should any message have appeared?

You're right. It doesn't look to make any difference. I even had to look
into the source code to know what option to pass to --debug. This was not
described in the man pages. And the --foregroud doesn't print message on
stdout, either. I was hoping that it may help. 'mountd' seems to ignore
these debugging parameters.

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
