Message-Id: <s0e01d9a.091@mail.frequentis.com>
Date: Mon, 28 Jun 2004 13:33:22 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <rpjday@mindspring.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

We have the same 'problem' if we startet with linux.
I think the point is:
What do you want to update?
In most cases only project related files like configuration or the
application itself has to be updated, but not the whole distribution.
So look what do you think that is necessayr to update and which files
are not.
We use a compressed filesystem without the possibilty to update it
(easily). Then we mount a jffs2 partition where the project related
files are stored. (In detail: a standard project directory is also
stored in the compressed filesystem, and if the hardware boots the first
time, the flashdisk will be formated and the standard application
copied. So from this point on it could be handled in our system as
usual, and also newer application could be stored, wihout the need to
update everything)

I hope you could see now clear .-)

br
Gerhard

>>> "Robert P. J. Day" <rpjday@mindspring.com> 06/28/04 12:50pm >>>

On Mon, 28 Jun 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain>
you wrote:

>> that it could be read-only).  how hard would it be to automatically
>> have that root FS copied from JFFS2 to RAM and mounted from there?
>
> This makes just no sense to me.

ok, i'm probably getting confused about something fundamental here.
what i'm after is to have my root filesystem in persistent storage and
available for updates on the fly, hence the notion of partitioning off
a part of the system flash for the JFFS2 version of the root
filesystem.  i've done that, so i've solved that problem -- i have a
root filesystem i can mount from a running system and modify.

now, i could just mount that JFFS2 version of the root fs straight out
of flash, but i get the impression that that would cause a performance
hit.  so i was wondering about the feasibility about copying that
entire flash FS into RAM at boot time, and running out of RAM.  this
would mean, of course, that if i wanted to make mods to the root FS,
i'd do them in flash and they'd only take effect at the next reboot,
which is fine with me.

or am i just hopelessly confused about what is and is not a reasonable
option here?  i get the feeling i'm missing something important.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
