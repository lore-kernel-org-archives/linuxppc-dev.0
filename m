From: flar@allandria.com
Message-Id: <200008301607.JAA24693@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: ak@suse.de (Andi Kleen)
Date: Wed, 30 Aug 2000 09:07:52 -0700 (PDT)
Cc: lord@sgi.com (Steve Lord), ak@suse.de (Andi Kleen),
        matthew@wil.cx (Matthew Wilcox), khalfmann@libra.de (Halfmann Klaus),
        roman@augan.com (Roman Zippel), linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20000830170726.B18398@gruyere.muc.suse.de> from "Andi Kleen" at Aug 30, 2000 05:07:26 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andi Kleen wrote:
> Only 64bit though, which may or may not be enough. If HFS indexes directly
> with names instead of hash values it'll probably not be enough so they
> would need to fall back to the no shrink hack.
> Anyways, you probably cannot ignore telldir of 32bit programs.

Yes, that's the main problem with HFS/HFS+. All catalog entries are keyed
on a combination of parent directory ID and filename, because this is the
data MacOS asks for when a file is opened. These entries have to be sorted
inside the tree, and the sort rules are a little messy, since the string
compares are supposed to be case-insensitive. If you are opening a file,
or doing a lookup() it's very convenient. If you are doing readdir() it's
a massive headache. Basically you have to find the first entry with a
parent ID that matches the directory being read, and then read every
entry in order until you find one with a different parent. Because of
the sorting issue, it's not just a problem with shrinking the directory,
because growing the directory could cause the same problem. In fact,
growing or shrinking ANY directory on the filesystem could theoretically
change the entire tree by forcing the tree to add a new layer of index
nodes and rebalancing the tree. It gets very messy. There's a reason the
HFS filesystem code in the kernel has always had a habit of destroying
disks any time it has to do anything too complex.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
