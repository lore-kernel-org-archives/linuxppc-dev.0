To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging kernel modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Aug 2002 18:06:52 PDT."
             <20020809010652.6470.qmail@web40201.mail.yahoo.com>
Date: Fri, 09 Aug 2002 09:15:05 +0200
Message-Id: <20020809071510.5B29E10DE1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020809010652.6470.qmail@web40201.mail.yahoo.com> you wrote:
>
> With GDB-5.2, after adding symbols, GDB can't find
> line numbers for my module source code.  However
> 'powerpc-linux-objdump -S -l fs/fat/fat.o' shows line
> numbers just fine.  Wolfgang, on your page you used
> GDB-5.1.1.  Ever see this problem?

We saw, and fixed, this, and other problems.

The GDB that comes with our ELDK contains a couple of bug  fixes  and
extensions:

- module debugging: there were some issues, including the problem you
  mentioned

- thread support: you can use our GDB / gdbserver to debug
  multi-threaded applications

- gdbserver with "remote shell" extension: you  can  use  our  GDB  /
  gdbserver  to  execute commands on the target, for example in cases
  where you don;t have a login or other shell running

- gdbserver in "server mode": you can start our gdbserver as a "real"
  server, i. e. without a process to debug, and use it later to
  attach to _any_ running process(es) onthe target

  For example, on a couple of systems we start a gdbserver  from  the
  inittab,  and  if we suspect a process goes haywire we use "rsh ps"
  to run the "ps" command on the  target  to  get  the  PIDs  of  the
  running  processes, and then we use "attach <pid>" to attach to the
  suspect process



Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you can, help others. If you can't, at least don't hurt  others."
- the Dalai Lama

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
