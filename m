Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 56F5ADDFC5
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 03:33:20 +1100 (EST)
Date: Wed, 5 Mar 2008 17:33:21 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: Long boot delay with agpgart
Message-ID: <20080305163320.GA3961@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

System: Debian unstable .. many packages very fresh.

Patched 2.6.25-rc3

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld

I'm not sure this is something that should be reported to
linuxppc-dev@ozlabs.org, but as I'm using a fresh patched git kernel
(please see
http://patchwork.ozlabs.org/linuxppc/patch?order=state&id=17107 
for more on that) that I even uploaded for others to use, I thought it
might be a sane idea to post it here also.

Also the problem reported here only happened once: but this whole
thing was looking so ugly I thought it might be better to ask people
knowing more than I do .. 

Here's what happened:

After upgrading quite a few packages today, I rebooted the machine:

The boot process began being stuck the moment some agpgart init
routine started:

Excerpt from kern.log that moment:

[    6.882357] usbcore: registered new device driver usb
[   36.732011] uninorth_agp: gave up waiting for init of module agpgart.
[   36.733009] uninorth_agp: Unknown symbol agp_bridge
[   66.734008] uninorth_agp: gave up waiting for init of module agpgart.
[   66.735011] uninorth_agp: Unknown symbol agp_find_bridge
[   96.736009] uninorth_agp: gave up waiting for init of module agpgart.
[   96.737010] uninorth_agp: Unknown symbol agp_device_command

The whole log for that time, and a successful reboot some time later,
is here: 
http://geocities.com/wolfgangpfeiffer/kern.log.txt

The boot routine got stuck for maybe 4 or 7 minutes with that agpgart
problem.

In the end the system/machine seemed to be booting cleanly. I then
rebooted again with a different kernel (some 2.6.18, IIRC) - just to
check what's up, with no problems I were aware of. I then repeatedly
rebooted the machine with 2.6.25-rc3 where the first boot blocking
happened, again with no problems.

The kernel this happened with is a patched git version: 2.6.25-rc3 -
please see the patchwork.ozlabs.org URL above for more on that.

My question:

*** 1:
Does this smell like some hardware bug?

*** 2:
Is it harmless?  - I don't remember a problem like that has happened
to me over the last years ... or at least not over the last 2 years,
or so ..

*** 3:
Your guesses?

And following a list of the packages I upgraded today (for those not
being familiar with Debian: just ignore the ".list" suffix at the end
at the end of the package names, please ...) 

 Mar  5 13:13 transcode-doc.list
 Mar  5 13:13 sendmail-doc.list
 Mar  5 13:13 sendmail.list
 Mar  5 13:13 sensible-mda.list
 Mar  5 13:13 sendmail-base.list
 Mar  5 13:13 sendmail-cf.list
 Mar  5 13:13 rt2500-source.list
 Mar  5 13:12 nmap.list
 Mar  5 13:12 pvm.list
 Mar  5 13:12 mplayer-doc.list
 Mar  5 13:12 lsb-release.list
 Mar  5 13:12 hddtemp.list
 Mar  5 13:12 libconfig-inifiles-perl.list
 Mar  5 13:12 libpvm3.list
 Mar  5 13:12 lm-sensors.list
 Mar  5 13:12 bluez-hcidump.list
 Mar  5 13:12 dcraw.list
 Mar  5 13:12 gs-esp.list
 Mar  5 13:12 gs-gpl.list
 Mar  5 13:12 ytalk.list
 Mar  5 13:12 ktalkd.list
 Mar  5 13:12 xorg.list
 Mar  5 13:12 xserver-xorg-dev.list
 Mar  5 13:12 xlibs-data.list
 Mar  5 13:12 xterm.list
 Mar  5 13:12 xchm.list
 Mar  5 13:12 xli.list
 Mar  5 13:12 x-ttcidfont-conf.list
 Mar  5 13:12 xutils.list
 Mar  5 13:12 ttf-opensymbol.list
 Mar  5 13:12 type-handling.list
 Mar  5 13:12 unrar-free.list
 Mar  5 13:12 unrar.list
 Mar  5 13:12 ttf-dejavu-core.list
 Mar  5 13:12 ttf-dejavu-extra.list
 Mar  5 13:12 ttf-dejavu.list
 Mar  5 13:12 ttf-bengali-fonts.list
 Mar  5 13:12 ttf-tamil-fonts.list
 Mar  5 13:12 ttf-telugu-fonts.list
 Mar  5 13:12 ttf-kannada-fonts.list
 Mar  5 13:12 ttf-malayalam-fonts.list
 Mar  5 13:12 ttf-oriya-fonts.list
 Mar  5 13:12 ttf-punjabi-fonts.list
 Mar  5 13:12 ttf-devanagari-fonts.list
 Mar  5 13:12 ttf-gujarati-fonts.list
 Mar  5 13:12 ttf-baekmuk.list
 Mar  5 13:12 ttf-indic-fonts.list
 Mar  5 13:12 tcpdump.list
 Mar  5 13:12 tk8.4.list
 Mar  5 13:12 tcl8.4.list
 Mar  5 13:12 sudo.list
 Mar  5 13:12 t1utils.list
 Mar  5 13:12 streamripper.list
 Mar  5 13:12 sbcl.list
 Mar  5 13:12 smartmontools.list
 Mar  5 13:12 ssl-cert.list
 Mar  5 13:12 rsync.list
 Mar  5 13:12 sane-utils.list
 Mar  5 13:12 python-gnome2.list
 Mar  5 13:12 python-libxml2.list
 Mar  5 13:12 rcs.list
 Mar  5 13:12 python-gtk2.list
 Mar  5 13:12 python-glade2.list
 Mar  5 13:12 python-numeric.list
 Mar  5 13:12 python-gobject.list
 Mar  5 13:12 python-cairo.list
 Mar  5 13:12 psfontmgr.list
 Mar  5 13:12 privoxy.list
 Mar  5 13:12 powernowd.list
 Mar  5 13:12 po-debconf.list
 Mar  5 13:12 powermgmt-base.list
 Mar  5 13:12 perl-tk.list
 Mar  5 13:12 pmount.list
 Mar  5 13:12 p7zip-full.list
 Mar  5 13:12 openoffice.org-thesaurus-en-us.list
 Mar  5 13:12 openoffice.org-filter-mobiledev.list
 Mar  5 13:12 openoffice.org-java-common.list
 Mar  5 13:12 ntpdate.list
 Mar  5 13:12 ocrad.list
 Mar  5 13:12 noatun-plugins.list
 Mar  5 13:12 noatun.list
 Mar  5 13:11 netpbm.list
 Mar  5 13:11 networkstatus.list
 Mar  5 13:11 nfs-kernel-server.list
 Mar  5 13:11 myspell-en-us.list
 Mar  5 13:11 ncompress.list
 Mar  5 13:11 mpeg2dec.list
 Mar  5 13:11 mpeg4ip-utils.list
 Mar  5 13:11 myspell-de-de.list
 Mar  5 13:11 mesa-utils.list
 Mar  5 13:11 mjpegtools.list
 Mar  5 13:11 module-assistant.list
 Mar  5 13:11 menu.list
 Mar  5 13:11 mc.list
 Mar  5 13:11 manpages-dev.list
 Mar  5 13:11 lisa.list
 Mar  5 13:11 locate.list
 Mar  5 13:11 libxmuu-dev.list
 Mar  5 13:11 libxmuu1.list
 Mar  5 13:11 libxosd2.list
 Mar  5 13:11 libxalan2-java.list
 Mar  5 13:11 libxfont1.list
 Mar  5 13:11 libxmlsec1-openssl.list
 Mar  5 13:11 libxmlsec1.list
 Mar  5 13:11 libwpg-0.1-1.list
 Mar  5 13:11 libwps-0.1-1.list
 Mar  5 13:11 libxerces2-java.list
 Mar  5 13:11 libvlc0.list
 Mar  5 13:11 libwnck-common.list
 Mar  5 13:11 libwnck22.list
 Mar  5 13:11 libwpd8c2a.list
 Mar  5 13:11 libt1-5.list
 Mar  5 13:11 libtextwrap1.list
 Mar  5 13:11 libtool.list
 Mar  5 13:11 libswscalecvs0.list
 Mar  5 13:11 libsensors4.list
 Mar  5 13:11 libservlet2.4-java.list
 Mar  5 13:11 libsox0.list
 Mar  5 13:11 libpulse-browse0.list
 Mar  5 13:11 libpulse0.list
 Mar  5 13:11 libsdl-mixer1.2.list
 Mar  5 13:11 libpcsclite1.list
 Mar  5 13:11 libpoppler-glib2.list
 Mar  5 13:11 libpostproccvs51.list
 Mar  5 13:11 libpulse-dev.list
 Mar  5 13:11 libpulse-mainloop-glib0.list
 Mar  5 13:11 pcscd.list
 Mar  5 13:11 libccid.list
 Mar  5 13:11 libopensync0.list
 Mar  5 13:11 libpam-gnome-keyring.list
 Mar  5 13:11 libnspr4-0d.list
 Mar  5 13:11 libnss-db.list
 Mar  5 13:11 libsqlite3-0.list
 Mar  5 13:11 libmpeg4ip-0.list
 Mar  5 13:11 libmx4j-java.list
 Mar  5 13:11 libnetpbm10.list
 Mar  5 13:11 libmpeg2-4.list
 Mar  5 13:11 libmjpegtools0.list
 Mar  5 13:11 libmp4v2-0.list
 Mar  5 13:11 libmailtools-perl.list
 Mar  5 13:11 ocaml-base-nox.list
 Mar  5 13:11 liblog4j1.2-java-gcj.list
 Mar  5 13:11 liblogfile-rotate-perl.list
 Mar  5 13:11 libltdl3.list
 Mar  5 13:11 libmad-ocaml.list
 Mar  5 13:11 libk3b3.list
 Mar  5 13:11 libkdcraw2.list
 Mar  5 13:11 liblog4j1.2-java.list
 Mar  5 13:11 libintl-perl.list
 Mar  5 13:11 libio-compress-base-perl.list
 Mar  5 13:11 libiso9660-5.list
 Mar  5 13:11 libjline-java.list
 Mar  5 13:11 libical0.list
 Mar  5 13:11 libieee1284-3.list
 Mar  5 13:11 libgutenprintui2-1.list
 Mar  5 13:11 libgtk2-perl.list
 Mar  5 13:11 libgtkspell0.list
 Mar  5 13:11 libgnomevfs2-common.list
 Mar  5 13:11 shared-mime-info.list
 Mar  5 13:11 libglu1-xorg-dev.list
 Mar  5 13:11 libglu1-xorg.list
 Mar  5 13:11 libgmp3c2.list
 Mar  5 13:11 libglib2.0-data.list
 Mar  5 13:11 libgksu2-0.list
 Mar  5 13:11 libgtop2-7.list
 Mar  5 13:11 libgtop2-common.list
 Mar  5 13:11 xbase-clients.list
 Mar  5 13:11 libgcj8-jar.list
 Mar  5 13:11 libgimp2.0.list
 Mar  5 13:11 libgcj7-jar.list
 Mar  5 13:11 libexif12.list
 Mar  5 13:11 libexif-dev.list
 Mar  5 13:11 libevent-rpc-perl.list
 Mar  5 13:11 libecj-java.list
 Mar  5 13:11 libenchant1c2a.list
 Mar  5 13:11 libevent-perl.list
 Mar  5 13:11 libglib-perl.list
 Mar  5 13:11 libcurses-ui-perl.list
 Mar  5 13:11 libdb4.6++.list
 Mar  5 13:11 libdvdread-dev.list
 Mar  5 13:11 libdvdread3.list
 Mar  5 13:10 libcommons-cli-java.list
 Mar  5 13:10 libcompress-raw-zlib-perl.list
 Mar  5 13:10 libconfig-file-perl.list
 Mar  5 13:10 libcurses-perl.list
 Mar  5 13:10 libchm1.list
 Mar  5 13:10 libcommons-lang-java.list
 Mar  5 13:10 libcdio7.list
 Mar  5 13:10 libcairo-perl.list
 Mar  5 13:10 libcucul-dev.list
 Mar  5 13:10 libcaca-dev.list
 Mar  5 13:10 libcaca0.list
 Mar  5 13:10 libbonoboui2-0.list
 Mar  5 13:10 libbonoboui2-common.list
 Mar  5 13:10 libcucul0.list
 Mar  5 13:10 libbonobo2-common.list
 Mar  5 13:10 libbonobo2-0.list
 Mar  5 13:10 libarts1-xine.list
 Mar  5 13:10 libavahi-glib1.list
 Mar  5 13:10 libavutilcvs49.list
 Mar  5 13:10 libarts1-mpeglib.list
 Mar  5 13:10 mpeglib.list
 Mar  5 13:10 libaa1-dev.list
 Mar  5 13:10 libarts1-akode.list
 Mar  5 13:10 libarts1-audiofile.list
 Mar  5 13:10 ktip.list
 Mar  5 13:10 libaa1.list
 Mar  5 13:10 ksysguard.list
 Mar  5 13:10 ksysguardd.list
 Mar  5 13:10 libavahi-compat-libdnssd1.list
 Mar  5 13:10 libsensors3.list
 Mar  5 13:10 ksvg.list
 Mar  5 13:10 liblcms1-dev.list
 Mar  5 13:10 liblcms1.list
 Mar  5 13:10 ksplash.list
 Mar  5 13:10 ksnapshot.list
 Mar  5 13:10 kscreensaver-xsavers.list
 Mar  5 13:10 ksig.list
 Mar  5 13:10 krec.list
 Mar  5 13:10 kscd.list
 Mar  5 13:10 kpdf.list
 Mar  5 13:10 kpersonalizer.list
 Mar  5 13:10 kpager.list
 Mar  5 13:10 kooka.list
 Mar  5 13:10 libkscan1.list
 Mar  5 13:10 konq-plugins.list
 Mar  5 13:10 konsole.list
 Mar  5 13:10 knewsticker-scripts.list
 Mar  5 13:10 knotes.list
 Mar  5 13:10 libfinance-quote-perl.list
 Mar  5 13:10 kmix.list
 Mar  5 13:10 libhtml-tableextract-perl.list
 Mar  5 13:10 libwww-perl.list
 Mar  5 13:10 kmenuedit.list
 Mar  5 13:10 kmid.list
 Mar  5 13:10 kmailcvt.list
 Mar  5 13:10 kmail.list
 Mar  5 13:10 libksieve0.list
 Mar  5 13:10 libmimelib1c2a.list
 Mar  5 13:10 klipper.list
 Mar  5 13:10 libkmime2.list
 Mar  5 13:10 libkpimidentities1.list
 Mar  5 13:10 khelpcenter.list
 Mar  5 13:10 kicker-applets.list
 Mar  5 13:10 gs.list
 Mar  5 13:10 kdeprint.list
 Mar  5 13:10 kghostview.list
 Mar  5 13:10 kdepasswd.list
 Mar  5 13:10 libkonq4.list
 Mar  5 13:10 kdenetwork-filesharing.list
 Mar  5 13:10 kdenetwork.list
 Mar  5 13:10 kwifimanager.list
 Mar  5 13:10 ksirc.list
 Mar  5 13:10 krdc.list
 Mar  5 13:10 krfb.list
 Mar  5 13:10 libslp1.list
 Mar  5 13:10 kpf.list
 Mar  5 13:10 kppp.list
 Mar  5 13:10 kopete.list
 Mar  5 13:10 kdict.list
 Mar  5 13:10 kdnssd.list
 Mar  5 13:10 kget.list
 Mar  5 13:10 knewsticker.list
 Mar  5 13:10 kdemultimedia-kfile-plugins.list
 Mar  5 13:10 kdenetwork-kfile-plugins.list
 Mar  5 13:10 kdemultimedia-kappfinder-data.list
 Mar  5 13:10 libtheora-dev.list
 Mar  5 13:10 libtheora0.list
 Mar  5 13:10 kdemultimedia-doc-html.list
 Mar  5 13:10 kdebluetooth.list
 Mar  5 13:10 kdegraphics-kfile-plugins.list
 Mar  5 13:10 libpoppler-qt2.list
 Mar  5 13:10 libpoppler2.list
 Mar  5 13:10 python-dbus.list
 Mar  5 13:10 python-qt4-dbus.list
 Mar  5 13:10 python-qt4.list
 Mar  5 13:09 python2.4-minimal.list
 Mar  5 13:09 python2.4.list
 Mar  5 13:09 python-qt4-common.list
 Mar  5 13:09 python-sip4.list
 Mar  5 13:09 libqt4-core.list
 Mar  5 13:09 libqt4-gui.list
 Mar  5 13:09 kdeartwork.list
 Mar  5 13:09 kdebase-bin-kde3.list
 Mar  5 13:09 kscreensaver.list
 Mar  5 13:09 libkbluetooth0.list
 Mar  5 13:09 kdeartwork-theme-window.list
 Mar  5 13:09 kdewallpapers.list
 Mar  5 13:09 ksmserver.list
 Mar  5 13:09 kwin.list
 Mar  5 13:09 kdeartwork-theme-icon.list
 Mar  5 13:09 kdeartwork-misc.list
 Mar  5 13:09 kdeartwork-style.list
 Mar  5 13:09 kdeaddons-kfile-plugins.list
 Mar  5 13:09 kdeartwork-emoticons.list
 Mar  5 13:09 kdemultimedia-kio-plugins.list
 Mar  5 13:09 kaudiocreator.list
 Mar  5 13:09 libkcddb1.list
 Mar  5 13:09 kate-plugins.list
 Mar  5 13:09 libtidy-0.99-0.list
 Mar  5 13:09 tidy.list
 Mar  5 13:09 kappfinder.list
 Mar  5 13:09 kate.list
 Mar  5 13:09 kaddressbook-plugins.list
 Mar  5 13:09 kamera.list
 Mar  5 13:09 kaddressbook.list
 Mar  5 13:09 libkleopatra1.list
 Mar  5 13:09 kaboodle.list
 Mar  5 13:09 libgpgme11.list
 Mar  5 13:09 libpth20.list
 Mar  5 13:09 john.list
 Mar  5 13:09 juk.list
 Mar  5 13:09 libakode2.list
 Mar  5 13:09 initramfs-tools.list
 Mar  5 13:09 installation-report.list
 Mar  5 13:09 java-package.list
 Mar  5 13:09 httping.list
 Mar  5 13:09 klibc-utils.list
 Mar  5 13:09 libklibc.list
 Mar  5 13:09 htdig.list
 Mar  5 13:09 hal.list
 Mar  5 13:09 hdparm.list
 Mar  5 13:09 hspell.list
 Mar  5 13:09 lockfile-progs.list
 Mar  5 13:09 usbutils.list
 Mar  5 13:09 gutenprint-doc.list
 Mar  5 13:09 gutenprint-locales.list
 Mar  5 13:09 gstreamer0.10-alsa.list
 Mar  5 13:09 gtkpbbuttons-common.list
 Mar  5 13:09 gtkpbbuttons.list
 Mar  5 13:09 gpm.list
 Mar  5 13:09 libgstreamer-plugins-base0.10-0.list
 Mar  5 13:09 libgstreamer0.10-0.list
 Mar  5 13:09 gnome-keyring.list
 Mar  5 13:09 libhal-storage1.list
 Mar  5 13:09 git-doc.list
 Mar  5 13:09 libgnome-keyring0.list
 Mar  5 13:09 gimp-help-common.list
 Mar  5 13:09 gimp-help-en.list
 Mar  5 13:08 ghostscript.list
 Mar  5 13:08 gsfonts.list
 Mar  5 13:08 ghostscript-x.list
 Mar  5 13:08 gv.list
 Mar  5 13:08 gettext.list
 Mar  5 13:08 gdb.list
 Mar  5 13:08 gcj-4.2-base.list
 Mar  5 13:08 libgcj8-1.list
 Mar  5 13:08 gij-4.2.list
 Mar  5 13:08 libgcj8-1-awt.list
 Mar  5 13:08 g++.list
 Mar  5 13:08 gaim-data.list
 Mar  5 13:08 gaim.list
 Mar  5 13:08 gcc.list
 Mar  5 13:08 fvwm.list
 Mar  5 13:08 librsvg2-2.list
 Mar  5 13:08 fping.list
 Mar  5 13:08 libfribidi-dev.list
 Mar  5 13:08 libfribidi0.list
 Mar  5 13:08 librsvg2-common.list
 Mar  5 13:08 fortune-mod.list
 Mar  5 13:08 fortunes-off.list
 Mar  5 13:08 fortunes.list
 Mar  5 13:08 fam.list
 Mar  5 13:08 fetchmail.list
 Mar  5 13:08 fortunes-min.list
 Mar  5 13:08 faad.list
 Mar  5 13:08 fakeroot.list
 Mar  5 13:08 libfaad-dev.list
 Mar  5 13:08 libfaad0.list
 Mar  5 13:08 escputil.list
 Mar  5 13:08 emacs21-common.list
 Mar  5 13:07 emacs21-bin-common.list
 Mar  5 13:07 emacs21.list
 Mar  5 13:07 dselect.list
 Mar  5 13:07 dvd+rw-tools.list
 Mar  5 13:07 em8300-headers.list
 Mar  5 13:07 docbook-xsl.list
 Mar  5 13:07 dpatch.list
 Mar  5 13:07 doc-base.list
 Mar  5 13:07 scrollkeeper.list
 Mar  5 13:07 discover1.list
 Mar  5 13:07 libscrollkeeper0.list
 Mar  5 13:07 discover1-data.list
 Mar  5 13:07 libdiscover1.list
 Mar  5 13:07 dcoprss.list
 Mar  5 13:07 dict.list
 Mar  5 13:07 librss1.list
 Mar  5 13:07 cvs.list
 Mar  5 13:07 dbus-x11.list
 Mar  5 13:07 cupsys-driver-gutenprint.list
 Mar  5 13:07 cupsys-bsd.list
 Mar  5 13:07 cupsys-client.list
 Mar  5 13:07 libgutenprint2.list
 Mar  5 13:07 cupsys-common.list
 Mar  5 13:07 cpufrequtils.list
 Mar  5 13:07 libcpufreq0.list
 Mar  5 13:07 libsysfs-dev.list
 Mar  5 13:07 libsysfs2.list
 Mar  5 13:07 cpp-4.1.list
 Mar  5 13:07 gcc-4.1-base.list
 Mar  5 13:07 gcc-4.1.list
 Mar  5 13:07 libstdc++6-4.1-dev.list
 Mar  5 13:07 clamav-base.list
 Mar  5 13:07 g++-4.1.list
 Mar  5 13:07 libmudflap0-dev.list
 Mar  5 13:07 cl-binary-types.list
 Mar  5 13:07 cl-kmrcl.list
 Mar  5 13:07 cl-rt.list
 Mar  5 13:07 cl-asdf.list
 Mar  5 13:07 common-lisp-controller.list
 Mar  5 13:07 cjk-latex.list
 Mar  5 13:07 latex-cjk-common.list
 Mar  5 13:07 realpath.list
 Mar  5 13:07 cdrdao.list
 Mar  5 13:07 cdparanoia.list
 Mar  5 13:07 libao2.list
 Mar  5 13:07 libcdparanoia0-dev.list
 Mar  5 13:07 libcdparanoia0.list
 Mar  5 13:07 ca-certificates.list
 Mar  5 13:07 ccache.list
 Mar  5 13:07 openssl.list
 Mar  5 13:07 bluez-gnome.list
 Mar  5 13:07 libidl0.list
 Mar  5 13:07 liborbit2.list
 Mar  5 13:07 gconf2.list
 Mar  5 13:07 libhal1.list
 Mar  5 13:07 psmisc.list
 Mar  5 13:07 gconf2-common.list
 Mar  5 13:07 bluetooth.list
 Mar  5 13:07 bluez-utils.list
 Mar  5 13:07 libbluetooth2.list
 Mar  5 13:07 binutils.list
 Mar  5 13:07 bash-doc.list
 Mar  5 13:07 bcm43xx-fwcutter.list
 Mar  5 13:07 avahi-daemon.list
 Mar  5 13:07 avahi-utils.list
 Mar  5 13:07 libavahi-core5.list
 Mar  5 13:07 libdaemon0.list
 Mar  5 13:07 dbus.list
 Mar  5 13:07 autoconf.list
 Mar  5 13:07 autotools-dev.list
 Mar  5 13:07 audacity.list
 Mar  5 13:07 libwxgtk2.6-0.list
 Mar  5 13:07 libflac++6.list
 Mar  5 13:07 libwxbase2.6-0.list
 Mar  5 13:06 ascii.list
 Mar  5 13:06 aspell-de.list
 Mar  5 13:06 atlantikdesigner.list
 Mar  5 13:06 artsbuilder.list
 Mar  5 13:06 armagetron.list
 Mar  5 13:06 armagetronad-common.list
 Mar  5 13:06 libsdl-image1.2.list
 Mar  5 13:06 aptitude-doc-en.list
 Mar  5 13:06 arj.list
 Mar  5 13:06 armagetronad.list
 Mar  5 13:06 apt-listchanges.conffiles
 Mar  5 13:06 apt-listchanges.config
 Mar  5 13:06 apt-listchanges.list
 Mar  5 13:06 apt-listchanges.md5sums
 Mar  5 13:06 apt-listchanges.postinst
 Mar  5 13:06 apt-listchanges.postrm
 Mar  5 13:06 apt-listchanges.preinst
 Mar  5 13:06 apt-listchanges.prerm
 Mar  5 13:06 apt-listchanges.templates
 Mar  5 13:06 apt-spy.list
 Mar  5 13:06 apt-listbugs.conffiles
 Mar  5 13:06 apt-listbugs.list
 Mar  5 13:06 apt-listbugs.md5sums
 Mar  5 13:06 apt-listbugs.postinst
 Mar  5 13:06 apt-listbugs.postrm
 Mar  5 13:06 apt-listbugs.preinst
 Mar  5 13:06 liblocale-ruby1.8.list
 Mar  5 13:06 libxml-parser-ruby1.8.list
 Mar  5 13:06 ruby.list
 Mar  5 13:06 ruby1.8.list
 Mar  5 13:06 libruby1.8.list
 Mar  5 13:06 apt-doc.list
 Mar  5 13:06 antlr.list
 Mar  5 13:06 libgcj7-1.list
 Mar  5 13:06 libgcj-common.list
 Mar  5 13:06 libgcj7-1-awt.list
 Mar  5 13:06 gcj-4.1-base.list
 Mar  5 13:06 gij-4.1.list
 Mar  5 13:06 alsaplayer-common.list
 Mar  5 13:06 libflac8.list
 Mar  5 13:06 alsaplayer-gtk.list
 Mar  5 13:06 libpango1.0-0.list
 Mar  5 13:06 libthai-data.list
 Mar  5 13:06 libthai0.list
 Mar  5 13:06 libpango1.0-common.list
 Mar  5 13:06 defoma.list
 Mar  5 13:06 libdatrie0.list
 Mar  5 13:06 libpango1.0-dev.list
 Mar  5 13:06 alsaplayer-alsa.list
 Mar  5 13:06 libcairo2-dev.list
 Mar  5 13:06 libcairo2.list
 Mar  5 13:06 alsa-utils.list
 Mar  5 13:06 akregator.list
 Mar  5 13:06 alsa-base.list
 Mar  5 13:06 linux-sound-base.list
 Mar  5 13:06 libkcal2b.list
 Mar  5 13:06 libkdepim1a.list
 Mar  5 13:06 kdelibs-data.list
 Mar  5 13:06 libktnef1.list
 Mar  5 13:06 kdelibs4c2a.list
 Mar  5 13:06 kdelibs4-dev.list
 Mar  5 13:06 libavahi-qt3-1.list
 Mar  5 13:06 libavahi-qt3-dev.list
 Mar  5 13:06 libfam-dev.list
 Mar  5 13:06 libfam0.list
 Mar  5 13:06 libxml2-utils.list
 Mar  5 13:06 libavahi-client-dev.list
 Mar  5 13:06 libavahi-client3.list
 Mar  5 13:06 libdbus-1-3.list
 Mar  5 13:06 libdbus-1-dev.list
 Mar  5 13:06 libavahi-common-data.list
 Mar  5 13:06 libavahi-common-dev.list
 Mar  5 13:06 libavahi-common3.list
 Mar  5 13:06 aspell.list
 Mar  5 13:06 libaspell-dev.list
 Mar  5 13:06 libaspell15.list
 Mar  5 13:06 libarts1c2a.list
 Mar  5 13:06 libjack0.100.0-dev.list
 Mar  5 13:06 libvorbis0a.list
 Mar  5 13:06 libogg0.list
 Mar  5 13:06 libvorbis-dev.list
 Mar  5 13:06 libvorbisenc2.list
 Mar  5 13:06 libvorbisfile3.list
 Mar  5 13:06 libogg-dev.list
 Mar  5 13:06 libqt3-mt.list
 Mar  5 13:06 qt3-dev-tools.list
 Mar  5 13:06 libqt3-headers.list
 Mar  5 13:06 libxmu-dev.list
 Mar  5 13:06 libxmu6.list
 Mar  5 13:06 libglu1-mesa-dev.list
 Mar  5 13:06 libglu1-mesa.list
 Mar  5 13:06 libqt3-compat-headers.list
 Mar  5 13:06 libqt3-mt-dev.list
 Mar  5 13:05 libgl1-mesa-dev.list
 Mar  5 13:05 libgl1-mesa-dri.list
 Mar  5 13:05 libgl1-mesa-glx.list
 Mar  5 13:05 mesa-common-dev.list
 Mar  5 13:05 libaudio-dev.list
 Mar  5 13:05 libfreebob0.list
 Mar  5 13:05 libraw1394-8.list
 Mar  5 13:05 libraw1394-dev.list
 Mar  5 13:05 jackd.list
 Mar  5 13:05 libjack0.list
 Mar  5 13:05 libjack-dev.list
 Mar  5 13:05 libasound2-dev.list
 Mar  5 13:05 libasound2.list
 Mar  5 13:05 libaudio2.list
 Mar  5 13:05 libarts1-dev.list
 Mar  5 13:05 libartsc0-dev.list
 Mar  5 13:05 libartsc0.list
 Mar  5 13:05 libglib2.0-0.list
 Mar  5 13:05 libglib2.0-dev.list
 Mar  5 13:05 libart-2.0-2.list
 Mar  5 13:05 libart-2.0-dev.list
 Mar  5 13:05 abook.list
 Mar  5 13:05 texinfo.list
 Mar  5 13:05 python-support.list
 Mar  5 13:05 strace.list
 Mar  5 13:05 openssh-client.list
 Mar  5 13:05 pciutils.list
 Mar  5 13:05 python-central.list
 Mar  5 13:05 openssh-server.list
 Mar  5 13:05 nfs-common.list
 Mar  5 13:05 portmap.list
 Mar  5 13:05 ncurses-term.list
 Mar  5 13:05 mime-support.list
 Mar  5 13:05 mutt.list
 Mar  5 13:05 lsof.list
 Mar  5 13:05 locales.list
 Mar  5 13:05 libpcre3.list
 Mar  5 13:05 libidn11-dev.list
 Mar  5 13:05 libidn11.list
 Mar  5 13:05 libpcre3-dev.list
 Mar  5 13:05 libpcrecpp0.list
 Mar  5 13:05 gettext-base.list
 Mar  5 13:05 less.list
 Mar  5 13:05 libgpmg1.list
 Mar  5 13:05 file.list
 Mar  5 13:05 libmagic1.list
 Mar  5 13:05 doc-linux-text.list
 Mar  5 13:05 dictionaries-common.list
 Mar  5 13:05 dnsutils.list
 Mar  5 13:05 bind9-host.list
 Mar  5 13:05 libbind9-30.list
 Mar  5 13:05 liblwres30.list
 Mar  5 13:05 libdns32.list
 Mar  5 13:05 libisc32.list
 Mar  5 13:05 libisccc30.list
 Mar  5 13:05 libisccfg30.list
 Mar  5 13:05 at.list
 Mar  5 13:05 makedev.list
 Mar  5 13:05 procps.list
 Mar  5 13:05 libattr1-dev.list
 Mar  5 13:05 libattr1.list
 Mar  5 13:05 update-inetd.list
 Mar  5 13:05 traceroute.list
 Mar  5 13:05 tasksel.list
 Mar  5 13:05 manpages.list
 Mar  5 13:05 nano.list
 Mar  5 13:05 tasksel-data.list
 Mar  5 13:05 man-db.list
 Mar  5 13:05 libusb-0.1-4.list
 Mar  5 13:05 libusb-dev.list
 Mar  5 13:05 libsasl2-2.list
 Mar  5 13:05 libtasn1-3-dev.list
 Mar  5 13:05 libtasn1-3.list
 Mar  5 13:05 libdb4.6.list
 Mar  5 13:05 libsasl2-modules.list
 Mar  5 13:05 libssl-dev.list
 Mar  5 13:05 libssl0.9.8.list
 Mar  5 13:05 libsasl2-dev.list
 Mar  5 13:05 libgcrypt11.list
 Mar  5 13:05 libncursesw5.list
 Mar  5 13:05 bzip2.list
 Mar  5 13:05 libbz2-1.0.list
 Mar  5 13:05 libgcrypt11-dev.list
 Mar  5 13:05 iptables.list
 Mar  5 13:05 iputils-ping.list
 Mar  5 13:05 klogd.list
 Mar  5 13:05 laptop-detect.list
 Mar  5 13:05 libbz2-dev.list
 Mar  5 13:05 sysklogd.list
 Mar  5 13:05 info.list
 Mar  5 13:05 cron.list
 Mar  5 13:05 gpgv.list
 Mar  5 13:05 groff-base.list
 Mar  5 13:05 adduser.list
 Mar  5 13:05 cpio.list
 Mar  5 13:05 sysv-rc.list
 Mar  5 13:04 libuuid1.list
 Mar  5 13:04 passwd.list
 Mar  5 13:04 libss2.list
 Mar  5 13:04 libblkid1.list
 Mar  5 13:04 initscripts.list
 Mar  5 13:04 libdevmapper1.02.1.list
 Mar  5 13:04 xserver-xorg.list
 Mar  5 13:04 xserver-xorg-video-all.list
 Mar  5 13:04 xserver-xorg-video-trident.list
 Mar  5 13:04 xserver-xorg-video-mga.list
 Mar  5 13:04 xserver-xorg-video-nv.list
 Mar  5 13:04 xserver-xorg-video-ati.list
 Mar  5 13:04 xserver-xorg-input-all.list
 Mar  5 13:04 xserver-xorg-input-evdev.list
 Mar  5 13:04 xserver-xorg-input-mouse.list
 Mar  5 13:04 xserver-xorg-input-synaptics.list
 Mar  5 13:04 cpp.list
 Mar  5 13:04 xinit.list
 Mar  5 13:04 xkb-data.list
 Mar  5 13:04 libxext-dev.list
 Mar  5 13:04 libxext6.list
 Mar  5 13:04 libxmu-headers.list
 Mar  5 13:04 x11-common.list
 Mar  5 13:04 foomatic-db-engine.list
 Mar  5 13:04 imlib-base.list
 Mar  5 13:04 curl.list
 Mar  5 13:04 libkadm55.list
 Mar  5 13:04 libkrb53.list
 Mar  5 13:04 libkeyutils1.list
 Mar  5 13:04 libkrb5-dev.list
 Mar  5 13:04 comerr-dev.list
 Mar  5 13:04 libcomerr2.list
 Mar  5 13:04 libxml2.list
 Mar  5 13:04 libxml2-dev.list
 Mar  5 13:04 zlib1g-dev.list
 Mar  5 13:04 zlib1g.list
 Mar  5 13:04 foomatic-filters.list
 Mar  5 13:04 ucf.list
 Mar  5 13:04 foomatic-db.list
 Mar  5 13:04 console-common.list
 Mar  5 13:04 flex.list
 Mar  5 13:04 console-data.list
 Mar  5 13:04 sysvinit-utils.list
 Mar  5 13:04 ncurses-base.list
 Mar  5 13:04 libncurses5-dev.list
 Mar  5 13:04 libncurses5.list
 Mar  5 13:04 bsdutils.list
 Mar  5 13:03 base-passwd.list
 Mar  5 13:03 util-linux.list
 Mar  5 13:03 lsb-base.list
 Mar  5 13:03 tar.list
 Mar  5 13:03 sed.list
 Mar  5 13:03 ncurses-bin.list
 Mar  5 13:03 mount.list
 Mar  5 13:02 mktemp.list
 Mar  5 13:02 login.list
 Mar  5 13:02 hostname.list
 Mar  5 13:02 gzip.list
 Mar  5 13:02 grep.list
 Mar  5 13:02 findutils.list
 Mar  5 13:02 e2fsprogs.list
 Mar  5 13:02 e2fslibs.list
 Mar  5 13:02 libc6.list
 Mar  5 13:02 libc6-ppc64.list
 Mar  5 13:02 libc6-dev.list
 Mar  5 13:02 libc6-dev-ppc64.list
 Mar  5 13:02 linux-libc-dev.list
 Mar  5 13:02 tzdata.list
 Mar  5 13:02 debconf-i18n.list
 Mar  5 13:02 debconf.list
 Mar  5 13:02 liblocale-gettext-perl.list
 Mar  5 13:02 libtext-charwidth-perl.list
 Mar  5 13:02 libtext-iconv-perl.list
 Mar  5 13:02 libtext-wrapi18n-perl.list
 Mar  5 13:02 dpkg.list
 Mar  5 13:02 coreutils.list
 Mar  5 13:02 bash.list
 Mar  5 13:01 debianutils.list


Thanks in anticipation

Best Regards
Wolfgang

-- 
http://heelsbroke.blogspot.com/
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
