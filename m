From: Brad Boyer <flar@pants.nu>
Message-Id: <200003060032.TAA10926@marcus.pants.nu>
Subject: Re: HFS+ feature request
To: dan_bethe@yahoo.com (Dan Bethe)
Date: Sun, 5 Mar 2000 16:32:17 -0800 (PST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000303203225.3481.qmail@web1001.mail.yahoo.com> from "Dan Bethe" at Mar 03, 2000 12:32:25 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Bethe wrote:
> > The official format of HFS+ does specify that the strings are
> > compared
> > in a case insensitive way.  In fact, it goes further and specifies a
> > bunch of details about actual Unicode sequences and I really don't
> > want
> > to break all of that.
>
> 	I understand that.  My request was basically just that we have an
> option for that.  Basically, to have something like this:
>
> # mount -t hfsplus -o rw,casesensitive /dev/sda1 /mnt/local/sda1
>
> 	And the default can be case insensitive-but-preserving, like MacOS and
> the official specs state.  I just want the chance to be able to use it
> as a "real" filesystem, sharing the maximum amount of space while I
> still have to deal with the silliness of MacOS  :)  If I could format
> /usr with HFS+, I'd give that a shot.
> 	If any of you have access to a MacOS 10 which installs its root with
> HFS+, let's see how it behaves.  I have MacOS 10 "Server" 1.0 on my
> powerbook, and its root fs is UFS BSD 4.4.

Well, there's a problem with ever writing anything to an HFS+ filesystem that
doesn't use exactly the same comparison routines as the official Apple method.
If you look at the linux code for HFS, it is paranoid about this as well.  The
problem is that the entire structure of the catalog is based on the ability
to sort filenames in a consistent order, and if you ever break that ordering,
it becomes impossible to search the catalog properly.  If we allowed case
sensitivity and wrote out a set of filenames which was illegal, than any
other HFS+ reader could lose files in very interesting ways.  I would absolutely
refuse to deliberately add code that would break the filesystem that badly.  At
the moment, I don't match Apple's string routines, but that's because I haven't
taken the time to fix it, and it's not quite as dangerous when reading.

I'm afraid I don't have any access to an OSX install, so I'll need help from
other people who do in order to support the extra UNIX style usage from there.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
