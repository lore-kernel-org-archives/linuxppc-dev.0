Date: Wed, 21 Feb 2001 12:10:27 -0600 (CST)
From: Grant Erickson <erick205@UMN.EDU>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SysVInit, /etc/TIMEZONE, getty_ps, telnet, and rsh
In-Reply-To: <20010219231450.A23090@cistron.nl>
Message-Id: <Pine.SOL.4.20.0102211206530.17275-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Feb 2001, Miquel van Smoorenburg wrote:
> According to Grant Erickson:
> > The problem I am having, which may be due to inappropriate hacking of
> > sysvinit, is that sometimes processes of which 'init' is a parent do not
> > inherit the environment variables exported:
>
> They probably do inherit the environment, but simply reset the
> environment internally ignoring whatever was set by the parent.
>
> > Has anyone else modified sysvinit in this way? Any success? Did I miss
> > something key in my patch?
>
> I think you need to study the source code of those misbehaving programs.

Thanks, that was a worthy exercise. Neither 'getty_ps' nor 'in.rlogind'
pass the "-p" flag to the 'login' program resulting in the behavior
environment-clearing behavior I had seen. Unfortunately, adding the "-p"
flag will have some other side effects such as HOME, PATH, and HIST not
being set correctly under 'getty_ps', so this requires a bigger fix than
I'd hoped.

> BTW, you could have achieved the same by using /etc/initscript. Could
> be a shell script, but could be a small compiled executable too that
> sets TZ.

Thanks. I need to address the above issue first and then will look at that
as an alternative to my original patch.

Thanks again!

Regards,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
