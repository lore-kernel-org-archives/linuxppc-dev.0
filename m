Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <F9102D41F595D311ACA7009027DE2C840527B347@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Failsafe bootloader
Date: Wed, 4 Jun 2003 08:15:08 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We implemented a verification feature to ppcboot for products that performs
a crc32 check before branching to an image. If the crc32 fails to match a
stored checksum, it will check a secondary image, if that one fails too then
we usually default to a tftp from a well known tftp server that we have
accessible. One could take this to as much extreme as desired, but that's up
to the system designers to deem what's reasonable and what's overkill. The
key is the primitives to do such are in place.

Obviously, we put some resources into this for our products. You have to
expect to add some value to your products.

ppcboot allows this to be quite easy since the bootcmd can contain several
commands.




-----Original Message-----
From: Sam Ravnborg [mailto:sam@ravnborg.org]
Sent: Tuesday, June 03, 2003 2:29 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Failsafe bootloader



Hi all.

We are developing an application for an embedded target that will be
located in some rural areas. We foresee a need to update the target
with a new version of the application or a new kernel from time to time.

A few of the added requirements on top of that are:
1) The target shall boot up in the old kernel, if a bogus kernel is loaded
2) The target shall boot up in the old application, if a bogus
	application is loaded
3) On the management side an update shall be handled as a single file,
	the target may decide to 'unpack' it when received.

We have looked all over the net, but none of the bootloaders found
so far could meet the above demands.
The boot loaders usually have an interactive mode used to select
between different configurations - and there are no feedback from
the application side if the reboot actually went well.
The interactiviness does not fit well with an embedded target.

Do you know of a boot loader that partially or fully meets the above
requirements?

Background information
Today we are using VxWorks - for which we have made our own boot loader.
The boot laoder allows the boot loader itself, and the application part
to be upgraded - and if a restart is failed the old version will
be activated on a subsequent build.
I want the same behaviour in the Linux based target.

	Thanks in advance,

	Sam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
