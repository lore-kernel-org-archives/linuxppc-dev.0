Message-ID: <3CA9F79A.99F5D00B@mvista.com>
Date: Tue, 02 Apr 2002 10:25:30 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: question regarding a call stack from an oops message
References: <3CA9BF54.EAA3CEBD@lvl7.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Horman wrote:
>
> Hello all!
>         If anyone has a moment, I've got a question regarding the attached oops
> message.  On the platform we are debugging we get this occasional oops message
> (attached).  It doesn't start in any one point from the application code, but
> the lower half of it (from sys_read down) is always identiacal. Specifically I'm
> interested in the following snippet:
> >Trace; c00202d4 <handle_mm_fault+6c/100>
> >Trace; c0009e3c <Letext+190/3cc>
> >Trace; c00029a8 <ret_from_except+0/34>
> >Trace; c02e6e94 <END_OF_CODE+19a49c/???
> >Trace; c002397c <do_generic_file_read+260/48c>


> Questions:
> 1) Can anyone think of any other theories that might cause this END_OF_CODE
> stack frame behavior?
> 2) Regarding the Letext stack frame: I see this often as well, and I'm a little
> puzzled.  Is its appearance to be expected.  I expected to see after a
> ret_from_except stack frame a link to one of the memory management handler
> routines (do_page_fault, etc), but I don't.  For my own education, what is that
> Letext line?

If you look in System.map you should see that each address for which an Letext
entry also has another entry with a valid name.

You can get better symbols in your stack trace if you do something like:

  mv System.map System.map.OLD
  grep -v Letext System.map.OLD >System.map


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
