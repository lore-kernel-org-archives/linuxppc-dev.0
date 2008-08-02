Return-Path: <paul@burly.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 0EE3EDDDD8
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Aug 2008 08:36:52 +1000 (EST)
From: Paul Collins <paul@burly.ondioline.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
References: <87tze38vzt.fsf@burly.wgtn.ondioline.org>
	<20080802184554.GB715@fieldses.org>
Date: Sun, 03 Aug 2008 10:36:51 +1200
In-Reply-To: <20080802184554.GB715@fieldses.org> (J. Bruce Fields's message of
	"Sat, 2 Aug 2008 14:45:54 -0400")
Message-ID: <87abfvm4cc.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Brown <neilb@suse.de>, linuxppc-dev@ozlabs.org, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Sun, Aug 03, 2008 at 12:03:18AM +1200, Paul Collins wrote:
>> I just got the oops below on a ppc32 NFS4 server.  I was cross-compiling
>> Linux with an amd64 client at the time.  The server is running Linus's
>> tree as of 94ad374a0751f40d25e22e036c37f7263569d24c, the client is
>> running 2.6.26.
>> 
>> The server's kernel was cross-compiled with gcc 4.2.4-3 and binutils
>> 2.18.50.20080610-1, both built from the Debian sources following their
>> toolchain-building procedures.
>
> Without having really thought about this,
>
> 	496d6c32d4d057cb44272d9bd587ff97d023ee92 "nfsd: fix spurious
> 	EACCESS in reconnect_path()"
>
> is one suspect; it might be worth checking whether the problem's
> reproduceable with that reverted.  But I assume we're not so lucky as to
> have a 100% reproduceable problem here?

Unknown.  I've kicked off a fresh build.  Here's hoping!

> What do your export options look like?

  $ cat /etc/exports
  /srv/nfsv4            *(sec=krb5:krb5i:krb5p,rw,fsid=0,crossmnt,insecure,no_subtree_check)
  /srv/nfsv4/home/paul  *(sec=krb5:krb5i:krb5p,rw,insecure,no_subtree_check)
  $ mount | grep bind
  /home/paul on /srv/nfsv4/home/paul type none (rw,bind)

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
