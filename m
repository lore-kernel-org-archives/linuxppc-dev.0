Date: Thu, 5 Jun 2003 23:16:00 +0200 (CEST)
From: Mich Lanners <mlan@cpu.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
Subject: Re: new ATI sleep code freezes
To: mutex@kerneli.org
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <E19O25a-0000Ej-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Jun, this message from Benjamin Herrenschmidt echoed through
cyberspace:
>> from my XF86Config file...
>>
>> (WW) Open APM failed (/dev/apm_bios) (No such file or directory)
>>
>> But my kernel config says...
>> CONFIG_PMAC_APM_EMU=y
>>
>> The only thing unusual is I am running devfs..
>
> Poor boy... ;)

Na. I run devfs on my Powerbook, and I am very happy. Never had any
problem. I am absolutely certain (even if it may not be true :-) that
using devfs saves me quite a number of HD spinups.

>> so i checked /dev
>>
>> heliosphan dev # find . -name *apm*
>> ./misc/apm_bios
>> ./apm_bios
>>
>> /dev/misc/apm_bios has perms:
>>
>> crw-------    1 mutex    root      10, 134 Dec 31  1969 apm_bios

Mine show this:

mlan@pooh:~$ ll /dev/apm_bios  /dev/misc/apm_bios
lr-xr-xr-x    1 root     root           13 2003-05-14 22:42 /dev/apm_bios -> misc/apm_bios
crw-rw----    1 root     root      10, 134 1970-01-01 01:00 /dev/misc/apm_bios

This is with the Debian devfs package, which _may_ fix up a few things.
My devfs config says this:

mlan@pooh:/etc/devfs$ find . -type f |xargs grep apm
/conf.d/apm:REGISTER ^misc/apm_bios$   PERMISSIONS root.root 0660
/conf.d/pmud:REGISTER ^misc/apm_bios$   PERMISSIONS root.root 0660
/perms:REGISTER ^misc/apm_bios         PERMISSIONS root.root   0660

plus this one for setting up symlinks:

mlan@pooh:/etc/devfs$ head compat_symlinks
# Enable full compatibility mode for old device names. You may comment these
# out if you don't use the old device names. Make sure you know what you're
# doing!
REGISTER        .*              MKOLDCOMPAT
UNREGISTER      .*              RMOLDCOMPAT

>> are those normal permissions ?  Also, I'm running an enlightenment
>> battery applet which afaik uses apm layer to report battery level.
>> So something has to be working. Dave
>
> I don't know wtf with devfs & perms, but the problem is here, once you
> fix that, it should work much better ;)

I'm tempted to say: install Debian :-)

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
