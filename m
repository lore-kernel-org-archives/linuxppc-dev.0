From: flar@allandria.com
Message-Id: <200009011740.KAA01445@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: khalfmann@libra.de (Halfmann, Klaus)
Date: Fri, 1 Sep 2000 10:40:07 -0700 (PDT)
Cc: viro@math.psu.edu ('viro@math.psu.edu '),
        dgatwood@deepspace.mklinux.org ('dgatwood@deepspace.mklinux.org '),
        ak@suse.de ('ak@suse.de '), lord@sgi.com ('lord@sgi.com '),
        matthew@wil.cx ('matthew@wil.cx '),
        khalfmann@libra.de (Halfmann Klaus),
        roman@augan.com ('roman@augan.com '),
        linuxppc-dev@lists.linuxppc.org ('linuxppc-dev@lists.linuxppc.org '),
        linux-fsdevel@vger.kernel.org ('linux-fsdevel@vger.kernel.org ')
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDD90@MAIL1> from "Halfmann, Klaus" at Sep 01, 2000 07:05:50 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Halfmann, Klaus wrote:
> Brad, Im sure you are wrong on this one, try the following in MacOS:
> create an alias to a folder and then renam it, the alias will stiil work
> So Im sure the CNIDs will not change ..

Alias files in the MacOS aren't that simple. The MacOS stores quite a bit
of info in an alias record, and tries to find the file even if a bunch of
stuff has changed. Take a look at

http://developer.apple.com/techpubs/mac/Files/Files-340.html

Note that it mentions that even files restored from backups can be easily
found by alias.

I went searching, and found a description of the funcions FSpExchangeFiles
and PBExchangeFiles in

http://developer.apple.com/technotes/tn/tn1041.html

which specifically states that when files are moved, the CNID is what is
changed effectively, because the disk block allocation data is what is
really moved around, not the filename. This allows them to not have to
do any major changes to a catalog record. All they have to do is change
a few particular fields in the entry. (Note this info is for HFS...)

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
