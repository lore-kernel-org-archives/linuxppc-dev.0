To: John.Fisher@nec.com.au
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Aug 2002 11:15:20 +1000."
             <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Date: Thu, 22 Aug 2002 08:56:04 +0200
Message-Id: <20020822065609.6DE7610E00@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,

in message <000501c24979$6348a190$37d34c93@neca.nec.com.au> you wrote:
>
> So what are the issues: How is cygwin significantly different from Linux
> that you would not want to use it?

First, you may run into compatibility issues.  It  is  a  non-trivial
task  to  create  a  set  of  tools  that  will  run on more than one
combination of versions of Cygwin and Windoze: a product  that  works
for Cygwin under Windows 2000 may fail if attempted to run on Windows
NT,  let alone Windows 98. Different versions of Cygwin may even have
different layout of the C header files.

Second, many packages need for their build process a couple  of  UNIX
tools  which  are  not  available  on Cygwin. For example: localedef,
mktemp, rpcgen and others.

Finally, you will probably run into  problems  with  NFS  support  on
Windows  hosts.  I'm not sure that you can really create a filesystem
on a Windows box which preserves all the information required  for  a
LInux  root  filesystem,  so that you can actually export if over NFS
for your targets (think about issues like symbolic  and  hard  links,
owners,  groups,  sticky bit [for /tmp], setuid / setgid bits, device
files, ...).

> Are there useful tools that run under Linux but not under cygwin?

Yes.

> The reason I ask is that my organization currently does its software
> development under windows using proprietary tools. We have to maintain our
> existing products using these tools. We are however contemplating new
> development using linux. If we have to dual boot our PCs or have an extra PC
> running Linux for each developer, that is going to bring its own set of
> nuisances and problems.

There are several solutions.

First, and recommended, you can install one  of  a  couple  of  Linux
servers.  It  is  trivial  to  make these resources available to your
developers on Windoze hosts. You don't have to install a new Linux PC
for every developer. Remember that UNIX has a long tradition in using
dumb clients (like VT100 terminals or X11  clients);  a  windows  box
fits nicely into this ;-)

If you still think this is not an option, you don;t have to dual-boot
to use both environments on the same machine. For example, Lineo uses
(used?) vmware to provide a (hidden) Linux box running under  Windows
to  provide  a Linux development environment on Windows systems - you
can do the same.

> Are there others in this situation and how have they chosen to solve it?

Of course there is also the more radical approach: install  Linux  on
all your Windoze boxen, and save a lot of money on M$ licenses ;-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The price one pays for pursuing any profession,  or  calling,  is  an
intimate knowledge of its ugly side.                  - James Baldwin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
