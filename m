To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bare bones filesytem using Karim's book 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Jun 2003 14:18:36 PDT."
             <995FF289C9D69747A09E4299264459540C109861@penguin.adic.com>
Date: Mon, 02 Jun 2003 23:54:19 +0200
Message-Id: <20030602215424.7BEFCC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Brian,

in message <995FF289C9D69747A09E4299264459540C109861@penguin.adic.com> you wrote:
>
> Any quick thoughts on why this might be happening? To provide a comparison benchmark as I worked through this, I copied the (i) dev files, (ii) inittab and (iii) rc.sysinit from chapter 6 of the book (my "from scratch filesytem") to the ELDK stripped do
> wn target filesystem and this setup still boots. As for my stripped down ELDK, I have stripped it to the point where the following remains:
>
> glibc-ppc_4xx-2.2.5-0.19a
> libtermcap-devel-ppc_4xx-2.0.8-28
> cracklib-dicts-ppc_4xx-2.7-12
> pam-devel-ppc_4xx-0.75-19
> fileutils-ppc_4xx-4.1-4
> mingetty-ppc_4xx-0.9.4-18
> gawk-ppc_4xx-3.1.0-3
> SysVinit-ppc_4xx-2.78-19
> e2fsprogs-devel-ppc_4xx-1.26-1.72
> modutils-ppc_4xx-2.4.13-0.7.1a
> bash-ppc_4xx-2.05-8
> net-tools-ppc_4xx-1.60-3
> portmap-ppc_4xx-4.0-38a
> initscripts-ppc_4xx-6.43-1c
> termcap-ppc_4xx-11.0.1-10
> kernel-headers-ppc_4xx-2.4.4-1
> glibc-common-ppc_4xx-2.2.5-0.19a
> glibc-devel-ppc_4xx-2.2.5-0.19a
> glib-ppc_4xx-1.2.10-5
> libtermcap-ppc_4xx-2.0.8-28
> cracklib-ppc_4xx-2.7-12
> pam-ppc_4xx-0.75-19
> textutils-ppc_4xx-2.0.14-2
> mount-ppc_4xx-2.11g-5a
> setup-ppc_4xx-2.3.4-1b
> sh-utils-ppc_4xx-2.0.11-5
> e2fsprogs-ppc_4xx-1.26-1.72
> logrotate-ppc_4xx-3.5.9-1
> sysklogd-ppc_4xx-1.4.1-4
> util-linux-ppc_4xx-2.11f-17
> busybox-ppc_4xx-0.60.1-17

Oops. You call that "stripped down"? Ummm...

If you want to know what is  needed  for  a  small  filesystem  still
providing  things  like  PAM-based  login  and  xinetd based services
(telnet, ftp) you should have a look at the SELF RPM and  it's  build
script.  It  is  *significantly*  smaller  than your ""stripped down"
system...

> Most of the above were left in as I felt they needed to be there or they were "required" sysVinit or initscripts, which I didn't want to remove...

What makes you think these packages are needed? What exactly  do  YOU
need them for?

For example, why do you think glibc-devel is needed for  your  target
filesystem?

When designing an embedded system you  must  not  try  to  folow  any
package  dependencies  from  some  distribution.  Design  your system
bottom up: just add the components which absolutley  must  go  in  to
perform  services required by your project specification. OK, you may
_then_ end up adding some more "glue"...

> Below is a log of my boot log for the "from scratch" filesystem. The stripped down ELDK filesystem still boots.
...
> The "Freeing unused kernel memory:..." line is where it stops. Any ideas?

There are many, many things you may have done wrong.  Missing  device
nodes,  missing  libraries,  bogus  configuration.  For  example, you
include both SysVinit-ppc_4xx-2.78-19  and  busybox-ppc_4xx-0.60.1-17
in  your  list - both include thier own (and incompatible!!!) version
of an init process.

Which one did you (try to) enable?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The explanation requiring the fewest assumptions is the  most  likely
to be correct.                                    -- William of Occam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
