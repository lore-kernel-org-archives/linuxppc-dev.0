Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20030603154752.034f0e78@falcon.si.com>
Date: Tue, 3 Jun 2003 16:10:28 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Failsafe bootloader
In-Reply-To: <00047C13.C22236@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check out U-Boot
   http://sourceforge.net/projects/u-boot
The project page on sourceforge is pretty much non-existant other than the
CVS link.  Pull down the source -- there _is_ a good README file in it that
explains a lot about u-boot.
   http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/u-boot/u-boot/README?rev=1.30
Wolfgang Denk of Denx Computer Systems runs the project.  He doesn't appear
to have anything on U-Boot on his web site either.
   http://www.denx.de/

The predecessor was ppcboot, which at least has a home page on sourceforge
   http://ppcboot.sourceforge.net/
Pretty much everything said for ppcboot goes for u-boot as well, only
better :-).

U-boot has some scripting capabilities as well as variables that can be
used for rudimentary decision making.  I'm sure Wolfgang will welcome
improvements to the scripting :-).

The scripts can be accessed remotely or via your application (assuming your
application's "failure" mode is sufficient to allow it to write to
flash/eeprom to change the script to a backup mode).  You don't tell us
_how_ the application fails and how it and/or the boot loader is expected
to recover from that failure, so I cannot give you and direct suggestions.

gvb


At 09:28 PM 6/3/2003 -0400, sam@ravnborg.org wrote:

>Hi all.
>
>We are developing an application for an embedded target that will be
>located in some rural areas. We foresee a need to update the target
>with a new version of the application or a new kernel from time to time.
>
>A few of the added requirements on top of that are:
>1) The target shall boot up in the old kernel, if a bogus kernel is loaded
>2) The target shall boot up in the old application, if a bogus
>         application is loaded
>3) On the management side an update shall be handled as a single file,
>         the target may decide to 'unpack' it when received.
>
>We have looked all over the net, but none of the bootloaders found
>so far could meet the above demands.
>The boot loaders usually have an interactive mode used to select
>between different configurations - and there are no feedback from
>the application side if the reboot actually went well.
>The interactiviness does not fit well with an embedded target.
>
>Do you know of a boot loader that partially or fully meets the above
>requirements?
>
>Background information
>Today we are using VxWorks - for which we have made our own boot loader.
>The boot laoder allows the boot loader itself, and the application part
>to be upgraded - and if a restart is failed the old version will
>be activated on a subsequent build.
>I want the same behaviour in the Linux based target.
>
>         Thanks in advance,
>
>         Sam
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
