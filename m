Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 19 Jul 2004 18:12:10 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <20040719220430.C64FCC109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0407191803330.26356@dell.enoriver.com>
References: <20040719220430.C64FCC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 20 Jul 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0407191731390.24783@dell.enoriver.com> you wrote:
>>
>> sadly for me, the version floating around doesn't build FIFOs (even
>> though the command-line options suggest it does).  and i need FIFOs to
>> support minit.  so i merged a couple different versions to get one
>> that handles the extended device file format (erik andersen's??), and
>> a small patch to handle FIFOs.
>
> I thought Erik Anderse's version _is_ the standard version these days ;-)

it is, except as i mentioned, it doesn't support FIFOs, although it
does handle the extended device file format that i needed.  i got
another version that didn't support the extended file format, but
handled FIFOs.  quick merge, and i had what i wanted.

> And I thought you were using the ELDK?

i am.  not sure what that has to do with genext2fs.  what's a big deal
for me is to make sure the entire build and test process can be done
without any access to the root account on the development system.

>> i most likely wouldn't use it for the final build, but it would still
>> be more efficient for testing, rather than reflashing the root
>> filesystem on the unit every time.  once the image is finalized, then
>> i can flash the kernel and rootFS separately.
>
> I can't follow. Why would you flash the  root  filesystem  if  you're
> still  testing  it? Just TFTP the test image and use it from RAM (the
> kernel may be stored in flash if you like).

but the whole idea is that using genext2fs required me to make a
couple small changes to allow non-root users to do the entire process.
IIRC, the ability to mount and umount.  initramfs looks like an easier
way to just let regular users do all this.  and when we have the final
image, then burn *that* to flash.

sorry, i didn't mean to drag this out so much.  i just see initramfs
as a cheap and easy way to let non-root users build and test.  and if
i can reduce my dependency on tools additional (i.e., genext2fs), so
much the better.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
