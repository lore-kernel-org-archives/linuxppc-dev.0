Message-ID: <37EBFC1B.E97CCC9E@tiac.net>
Date: Fri, 24 Sep 1999 18:33:21 -0400
From: Patrick Callahan <pac1@tiac.net>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        mklinux-setup@public.lists.apple.com
Subject: Re: XFree86 3.3.5
Content-Type: multipart/mixed;
 boundary="------------473E2ACF9D70E2CF6F7F073A"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------473E2ACF9D70E2CF6F7F073A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

To: yellowdog-general@lists.yellowdoglinux.com,
rshaw@inficad.com,rafial@well.com, khendricks@admin.ivey.uwo.ca

With Xfree 3.3.5, Kernel 2.2.10 from 8/22/99, JDK1.2 is now working ok.  That
was what I set out to get working this weekend.

Later in this message there's a shell script for gathering info about X
and X
crashes.  Let me know what you think of it and where you think it can be
improved.

Linux boots but the USB contour UniMouse still needs to be disconnected if
I'm rebooting or booting from MacOS and not cold starting from a powered down
state. Otherwise X keeps crashing.    I suspect   Something in USB needs to
be reset before the shutdown, or maybe after a reboot and its not getting
done.  There's something missing most likely.

maybe the old kernal I have from 22 aug is the problem.  Maybe its time for
me to learn to build the kernal.

I think this particular mouse problem is probably known but maybe the detail
below can shed some light on it.  If its known and solved bug, you can
skip a
lot of this message and just take a look at the shell script for
diagnosing X
crashes

If anyone knows why we write to the USB mouse, clue me in.

- Pat

Here's the anecdote in detail so far.  Hope this is useful to someone.

Time t0.  Rev 1 Blue G3
     Rage 128 16MB card
     Adaptec 4930U (apple issue $49 SCSI card)
     Somebody's 8.4G SCSI internally attached with a found scsi cable
                      (internal scsi with this card is unsupported according
to Apple but it works)
     Zip100 externally attached
     Contour Unimouse  3 button USB mouse

   Apple Studio Display 17"
   June 1999 LinuxPPC
   R. Shaw's Kernel dated Aug 22, 1999 2.2.10

ftp://fraggle.i-sites.com/pub/rshaw/kernels/v2.2.10/vmlinux-2.2.10-rev1.gz
    ftp://fraggle.i-sites.com/pub/rshaw/kernels/v2.2.10/System.map-2.2.10.gz
   ftp://fraggle.i-sites.com/pub/rshaw/kernels/v2.2.10/modules-2.2.10.tar.gz

Time t0 = recently - maybe since switching to 2.2.10 from 2.2.6

 Problems:

After booting from MacOS, X writes a message about being unable to write to
the mouse.  and crashes.(I thought mice were read only devices but what
do I
know.  Maybe there's some write only memory in there!). Anyway X crashes
repeatedly until it runs out of retries or I unplug the mouse from the left
keyboard usb slot and plug it back in.  Then X boots normally.

After Shutdown from Gnome menu or shutdown -r now from an xterm, re-booting
into MacOS, the Mouse movements are not recognized until I unplug and re-plug
in the mouse similarly to what happens when going from MacOS to X under
LinuxPPC

Rebooting MacOS to MacOS

Shutdown -r now from a terminal window in X, logged in as root results
in a
reboot sometimes and recently hangs on messages about shutting down sound.
And yes I know its not a good idea to log in as root.

Shutdown -h now and restart with power switch seems to work.  Something is
not being reset in USB during Shutdown -r now, that resets when you power
off.  R. Shaw has warnings about this in his FAQ

JDK 1.2 does not work - Fails on Metal Look and Feel module (known problem,
fixed)


Time t1.= last weekend  Downloaded from
ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5

  XFree86-100dpi-fonts-3.3.5-1.6....

  XFree86-3.3.5-1.6.0a.ppc.rpm
  XFree86-FBDev-3.3.5-1.6.0a.ppc.rpm
  XFree86-Xbh-3.3.5-1.6.0a.ppc.rpm
  Xautoconfig-0.3-1.ppc.rpm
  Xconfigurator-4.2.4-1a.ppc.rpm
  mouseconfig-4.0-1a.ppc.rpm
  pam-0.68-2.ppc.rpm

After installing these and  trying out Mouseconfig and Xconfigurator, I found
that the only way to get the system to boot into X was to change my MACOS
monitor settings from millions of colors to thousands of colors.   This did
not work the first time so I changed a few more things, and changed the
resolution settings to use 1064 x 768 at 85 Hz instead of 75 Hz.  Hack Hack
Hack... Munge Munge Munge....  It worked... At least partially.  I don't
think I have the right driver working and don't know enough yet to be sure.
I'm reading all I can get my hands on for docs, and poking around in various
files to get a better handle on what's going on.

Time t2. Write diagnostic shell script for gathering info about X and X
crashes into a single file.

Here's the situation at time t3 = this e-mail being written

Time t3.  MacOS monitor settings now at 1064x768 @85 Hz and thousands of
colors
              Linux Boots to X  from MacOS but X crashes & restarts
              these crashes are identical to the ones mentioned under
Time t0




Here's the Diagnostic routine

XFDiag.sh
#! bash
#!    XFDiag.sh
#!
#!    purpose          gather materials for diagnosing X window configuration
problems
#!
#!    reason           Didn't have time to look for similar software.
#!                     I'm too busy learning linux.
#!
#!    inputs           various directory entries for files related to X
window
#!                     XF86Config
#!                     /var/gdm/:0.log
#!                     /var/log/dmesg
#!
#!    outputs          1  recommended redirection:  /exchange/XFDiag.log
#!
#!    pre-conditions   X installed & running or crashed
#!
#!    post-conditions  output on 1 contains
#!
#!                     1. directory listings of files related to X window
#!                        interspersed with copies of the file contents
#!                        where relevant.
#!                     2. a partial listing of /var/log/dmesg showing
#!                        log entries related to USB mouse and keyboard
#!
#!    Notes:  I wrote this program from scratch.
#!
#!            This software program is public domain
#!
#!            You are free to use, charge for, give away, copy, erase
#!            modify, expunge, delete, mangle, break, repair, correct,
rewrite
#!            expand, contract, compress, backup, restore,  store on your
hard drive, copier, printer
#!            output tray,  wastebasket, file cabinet or any other
information
#!            retrieval device this software or any part thereof as you see
fit.
#!
#!            P. Callahan Sept 22, 1999
#!
echo -e " use a bash command like this to execute"
echo -e " this bash script and place its output in a file:\n\n"
echo -e "(. XFDiag.sh )>/exchange/XFDiag.log"
echo -e  "\n\n"
echo $0
for x in `find /etc -name X`             \
         `find /etc -name XF68_FBDev`    \
  `find /usr -name XF68_FBDev`    \
  `find /usr -name XConfigurator` \
         `find /usr -name mouseconfig`   \
         `find /usr -name Xautoconfig`   \
         `find /usr -name XF86Config`    \
         `find /etc -name XF86Config`    \
         /var/gdm/:0.log
do
    ls -lah $x
    if       test -f $x \
        && ! test -L $x \
        && ! test -x $x
    then
 echo -e "\n\nlisting of file: $x \n"
 cat  $x
 echo -e "\n\n"
    fi
done
echo -e "\n\nExtracted from file: /var/log/dmesg\n"
grep 'depth=\|Console:\|display\|USB\|usb\|hub:
\|\OHCI\|ohci\|mouse\|keyboard\|UniMouse\|Manufacturer\Product\|Found
\|Expected descriptor\|parsed = \|unable to set' \
 /var/log/dmesg
return


log files is an attachment.  Hope this doesn't create problems for some...
Where's my copy of bbedit when I need it!
--------------473E2ACF9D70E2CF6F7F073A
Content-Type: application/x-director; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="XFDiag.log"
Content-Disposition: inline;
 filename="XFDiag.log"
Content-Transfer-Encoding: x-uuencode

begin 644 XFDiag.log
%8F%S: H 
end



--------------473E2ACF9D70E2CF6F7F073A--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
