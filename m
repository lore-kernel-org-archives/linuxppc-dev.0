Date: Fri, 15 Feb 2002 09:06:53 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215090653.B8353@work.bitmover.com>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com> <3C6D3ED2.19A93322@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C6D3ED2.19A93322@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 15, 2002 at 12:01:06PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> FWIW, I prefer to export as a patch, and then 'bk citool' to check in.

Groovy.  I love it when people use citool, we get better comments.

> If you are going to edit the comments anyway, then re-importing a patch
> is best done IMHO with
>
> 	patch -sp1 -g1 < ~/tmp/patch

The only problem with this is that it doesn't catch renames, so you'll be
adding and deleting files instead of renaming them.  Buried in the import
-tpatch code, you'll find (it's a shell script):

bk patch -g1 -f -p1 -ZsE \
    -z '=-PaTcH_BaCkUp!' --forcetime --lognames > ${TMP}plog$$ 2>&1

and then

grep '^Creating file ' ${TMP}plog$$ | sed 's/Creating file //' > ${TMP}creates$$
grep '^Removing file ' ${TMP}plog$$ | sed 's/Removing file //' > ${TMP}deletes$$
if [ -s ${TMP}deletes$$ -a -s ${TMP}creates$$ ]
then    (
	cat ${TMP}deletes$$
	echo ""
	cat ${TMP}creates$$
	) | bk renametool $Q
fi

which you really want to do, the repository will bloat up with duplicate files
if you don't.

Jeff, aside from the fact it's some unknown black box, what don't you like
about "import -tpatch"?  Is there something we could fix?
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
