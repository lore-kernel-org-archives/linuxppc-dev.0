Date: Fri, 22 Mar 2002 09:53:37 +0100
Message-Id: <200203220853.g2M8rbv23457@mailgate5.cinetic.de>
MIME-Version: 1.0
From: Frank Haverkamp <f.haverkamp@web.de>
To: linuxppc-embedded@lists.linuxppc.org, "OliverAmft" <oam@oamx.net>
Subject: Re: initial shell respawning too fast
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have seen that behaviour when I used a kernel without math
emulation on a filesystem which had binaries not compiled with
-mcpu=403 having floating point instructions in them.

The missbehavior was caused because sh/bash crashed due an invalid
instruction and init was trying to respawn it of course without
success.

#! /bin/bash
#
# Here's a useful little one-liner that lets you find out if there are any
# floating point instructions in an object file.
#

OBJDUMP=/opt/fsp/i586-pc-linux-gnu/local/bin/powerpc-linux-objdump

function usage()
{
    echo "Here's a useful little one-liner that lets you find out if there"
    echo "are any floating point instructions in an object file."
    echo
    echo "Usage: $(basename $0) ppc-objfile"
}

if [ -z $1 ]; then
        usage
        exit
else
        $OBJDUMP -S $1 | egrep \
        'mtfsf|lfd|lfs|stfd|stflwx|stfs|:[ \t]*(fc|fd|fe|ff|ec|ed|ee|ef) ';
fi

exit 0

I found this script which finds out if there are any floating point
instructions in you binaries/libraries. I copied it somewhere and
hope that the one you originally wrote it is ok with seeing this
published ;-)

Frank

Oliver Amft <oam@oamx.net> schrieb am 20.03.02:
> I am trying to boot Linux (linuxppc_2_4_devel 2.4.19-pre1) from a
> Walnut,
> 405GP Rev D board - All works fine till INIT starts (see screen
> printout below). The root fs (nfs boot) is an older version of the
> HardHat filesystem. bash crashes somehow, but unforunatly it prints no
> report. An old HHL 2.4.0-test2 kernel still works with this root fs.
>
> INIT: version 2.77 booting
> INIT: Entering runlevel: 3
> INIT: Id "sh" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel
> INIT: Id "sh" respawning too fast: disabled for 5 minutes
> INIT: Id "sh" respawning too fast: disabled for 5 minutes
> INIT: Id "sh" respawning too fast: disabled for 5 minutes
> INIT: Id "sh" respawning too fast: disabled for 5 minutes
>
>
> Probably I am missing some trivial thing - any ideas welcome!
>
> Oliver
>
>

--
Frank Haverkamp
f.haverkamp@web.de
______________________________________________________________________________
Die Nummer, die sich jeder merkt: Ihre 01212 Wunschrufnummer von WEB.DE!
Jetzt sichern: http://freemail.web.de/?mc=990001


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
