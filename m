Message-ID: <20011023033704.44473.qmail@web13104.mail.yahoo.com>
Date: Mon, 22 Oct 2001 20:37:04 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: Re: Sound on G4 tower, almost 
To: linuxppc-dev@lists.linuxppc.org
Cc: dpates@dsdk12.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, my /dev/mixer devices seem okay:

> cd /dev; ls -l mix*
lrwxrwxrwx    1 root     root            6 Feb 26
2001 mixer -> mixer0
crw-rw-rw-    1 root     17        14,   0 Oct  4
2000 mixer0
crw-rw-rw-    1 root     17        14,  16 Oct  4
2000 mixer1
crw-rw-rw-    1 root     17        14,  32 Oct  4
2000 mixer2
crw-rw-rw-    1 root     17        14,  48 Oct  4
2000 mixer3

The syslog messages that I posted previously do show
some errors when loading dmasound_pmac. I'm wondering
if those errors are related to the symptoms. Any help
appreciated.

-Dave



Derrik Pates <dpates@dsdk12.net> wrote:

> > Oct 19 20:54:38 garuda modprobe: modprobe: Can't
> > locate module sound-slot-1
> > Oct 19 20:54:38 garuda modprobe: modprobe: Can't
> > locate module sound-service-1-0
>
> seem to indicate something is trying to open
/dev/mixer1 instead of /dev/mixer0 (which /dev/mixer
should either be a symlink pointing to, or a dev node
with the same major/minor numbers). What does your
/dev/mixer look like? It shuld be major 14, minor 0.
Check /usr/src/linux/Documentation/devices.txt for all
the major/minor numbers for devices (including sound
devices).
>
> In other words, the Texas chip is probably
functioning fine - you have to tell it to do something
now, though...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
