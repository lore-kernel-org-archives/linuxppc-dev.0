To: linuxppc-dev@lists.linuxppc.org
Subject: ati_drv.o & fonts in XFree86-4.1
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20010624015513C.kohkichi@venus.dti.ne.jp>
Date: Sun, 24 Jun 2001 01:55:13 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

First of all, I'm not a developer.  But I guess someone
might be interested in this problem.  If this is not
appropriate in this list, please ignore.

Anyway, I compiled and installed XFree86-4.1 on my iMac revB
(Mach64, kernel 2.4.6-pre1, gcc-2.95.3 & glibc-2.2).
Actually, I applied XFree86-4.0.99.3-latin2.patch from
Fukui-san's src.rpm.  After the installation, X became much
faster with new ati_drv.o.  x11perf --scroll500 showed
118.0/sec on 24 depth.  In contrast, it had showed 54/sec on
XFree86-4.0.2 (actually, I had used ati_drv.o which Ani
Joshi had hacked for xf-4.0.1 because it's faster than that of
xf-4.0.2).

However, all fonts including Japanese fonts in windows
looked very ugly.  Actually, they were reversed and/or too
condensed, so they could not even be read.  This happened on
almost all software like xterm, Eterm, kterm, XEmacs,
netscape, etc.  However, fonts looked normal when I used
tkdesk to open and read files.  It's very weird.

When I deleted ati module and used fbdev module in
XF86Config, all fonts returned to normal appearance.
However, x11perf --scroll500 demonstrated 11-12/sec.  This
speed is only one-tenth compared with the speed with ati.

I exchaged ati_drv.o of xf-4.1 for ati_drv.o which Ani Joshi
hacked for xf-4.0.1 and deleted fbdev and added ati in
XF86Config.  Then, all fonts in X looked normal.  x11perf
--scroll500 showed 54/sec again.  Therefore, I guess
ati_drv.o of xf-4.1 is the cause of this font weirdness.

Does someone have any idea about working around this
problem?  I really want to use the new ati driver because
it's much faster.

Thanks a lot in advance.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
