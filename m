Return-Path: <SRS0+d99126679a6468e47a3e+1563+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: Merge dtc
From: David Woodhouse <dwmw2@infradead.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071204031027.GJ32577@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<20071204031027.GJ32577@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 17:22:39 +0000
Message-Id: <1196788959.13978.358.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-04 at 14:10 +1100, David Gibson wrote:
> We've been back and forth on this several times, Paul and I finally
> concluded this was the better option.

As long as I can just ignore it and use the separately-shipped dtc, I
suppose it doesn't have to bother me too much.

> It means we can feel free to use dtc for whatever new platforms we
> wish to without people whinging about having to install a new tool.

I think we're overestimating this 'problem'; really.

But anyway, if we have to go ahead with it, can we make sure we keep in
sync with the 'real' dtc?  One way of doing that is as follows...

It's not hard to make a git repository which is a simple 'transform' of
another tree -- I have a couple, at
http://git.infradead.org/?p=users/dwmw2/jffs2-ecos-core.git and 
http://git.kernel.org/?p=linux/kernel/git/dwmw2/kernel-headers.git

The scripts to generate those are at 
	http://david.woodhou.se/extract-jffs2-git.sh
	http://david.woodhou.se/extract-khdrs-git.sh 
	http://david.woodhou.se/extract-khdrs-stage2.sh

(The kernel headers one is in two stages because it has to mangle the
files through unifdef too).

I'm sure there are better ways of doing it, but the scripts I have work,
and should hopefully serve as a vaguely useful example.

I'd recommend making such a 'transform' which tracks the upstream dtc
tree but with the files you want moved into the correct places. Then all
we have to do to update the kernel's copy is pull from that transformed
tree.

Of course, it's possible that git has matured to the point where it can
handle the 'renames' and you can just pull from the upstream dtc
repository directly. I don't think that's the case though.

-- 
dwmw2
