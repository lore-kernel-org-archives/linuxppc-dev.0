Date: Wed, 30 Aug 2000 17:07:26 +0200
From: "Andi Kleen" <ak@suse.de>
To: Steve Lord <lord@sgi.com>
Cc: "Andi Kleen" <ak@suse.de>, flar@allandria.com,
        matthew@wil.cx (Matthew Wilcox), khalfmann@libra.de (Halfmann Klaus),
        roman@augan.com (Roman Zippel), linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
Message-ID: <20000830170726.B18398@gruyere.muc.suse.de>
References: <200008301206.HAA24978@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200008301206.HAA24978@jen.americas.sgi.com>; from lord@sgi.com on Wed, Aug 30, 2000 at 07:06:36AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 30, 2000 at 07:06:36AM -0500, Steve Lord wrote:
> >
> > In theory you could put as much state as you want into a private field
> > of the file structure of the directory. This just ignores two ugly things:
> > NFS and telldir. Both basically require you to generate stateless 32bit
> > cookies that safely walk your directory.
>
> Can't we at least pass the cookie generation and intepretation down to
> the filesystem layer, since at least NFS V3 allows bigger handles.

Only 64bit though, which may or may not be enough. If HFS indexes directly
with names instead of hash values it'll probably not be enough so they
would need to fall back to the no shrink hack.
Anyways, you probably cannot ignore telldir of 32bit programs.


-Andi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
