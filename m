Message-Id: <200110121858.f9CIwnY14960@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X 
In-Reply-To: Your message of "Fri, 12 Oct 2001 14:13:58 EDT."
             <20011012181138.FUFA17332.tomts11-srv.bellnexxia.net@there>
Date: Fri, 12 Oct 2001 12:58:49 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Okay I used tag_info as you directed and set the Quantum Fireball drive to
>use a maximum tag depth of 8 (like the old driver used) and everything
>seems to work fine.
>
>So can you point me to where in your driver code the depth of the tagged
>queueing is dynamically determined?  I would like to play around a bit
>with the driver code to see if I can tell if the Quantum Fireball is
>simply spitting back bogus info or and if so what?

I can already tell you what is happening.  We send a bunch of commands
to the drive expecting it to respond with QUEUE FULL status should we
send too many, but the drive instead accepts them for future completion
but never actually responds to the commands.  This is why we time out.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
