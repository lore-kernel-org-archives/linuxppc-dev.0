From: Chris Mason <mason@suse.com>
Date: Wed, 30 Aug 2000 14:25:46 GMT
Message-ID: <20000830.14254600@coffee.suse.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: Matthew Wilcox <matthew@wil.cx>
CC: "Halfmann, Klaus" <khalfmann@libra.de>, Roman Zippel <roman@augan.com>,
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20000829181851.D6395@parcelfarce.linux.theplanet.co.uk>
References: <F14441D40E5AD3118886005004607AD10BDD7F@MAIL1> <20000829181851.D6395@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 8/29/00, 1:18:51 PM, Matthew Wilcox <matthew@wil.cx> wrote regarding
Btree directories (Re: Status of HFS+ support):

[ 32 bit directory offsets ]

> Hmmm.. now the LFS patches have gone in and f_pos is now a 64-bit
quantity,
> this sounds more plausible.  I'd be curious to hear from the ReiserFS
> people how they solved this problem.

In reiserfs, the offset in the directory is a hash of the file name.  The
directories are sparse, so we could have a directory with 4 items,
offsets 1, 2, 32458, 2million.  The hash of a given item never changes,
new items can be inserted or removed from either side of any existing
item (except . and ..)

-chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
