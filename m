Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EDCFB6C.4040102@mvista.com>
Date: Tue, 03 Jun 2003 14:47:56 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader
References: <20030603192851.GA1921@mars.ravnborg.org>
In-Reply-To: <20030603192851.GA1921@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A bit off topic, but I'll jump in.  (The comments are based on experience
designing items for myself, and also information from looking at commercial
product designs. i.e. hacking things like my TiVo.)

Sam Ravnborg wrote:
> Hi all.
>
> We are developing an application for an embedded target that will be
> located in some rural areas. We foresee a need to update the target
> with a new version of the application or a new kernel from time to time.
>

First thing, make sure you have some mechanism for checksuming and possibly
signing updates.  The first assumption is the update made it over properly if
that stuff passes.. (and your company did QA it..)  ;)

> A few of the added requirements on top of that are:
> 1) The target shall boot up in the old kernel, if a bogus kernel is loaded

This will require a watchdog timer, and modification to a bootloader to do
counting and other items to instruct it to go to the backup kernel.

> 2) The target shall boot up in the old application, if a bogus
> 	application is loaded

A simple application daemon (init?) can do similar.

> 3) On the management side an update shall be handled as a single file,
> 	the target may decide to 'unpack' it when received.
>

cpio, tar, even RPM have been used for this.  These are standard field-upgrade
techniques..  the key is that every product is unique.

What _I_ personally would do is have two sets of "partitions" (memory, disk
doesn't matter) one set for two kernels, current and "updates" and one set for
userspace current and "updates".  Then you have magic values that tell the
bootloader what matches with what.  On an initial update, you make this magic
value "temporary" until the boot (application run) has succeeded and then you
make it perminant.

But all in all this will require you to make changes to an existing bootloader
or write your own.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
