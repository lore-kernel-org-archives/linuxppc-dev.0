Return-Path: <paul@burly.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 7839ADDF05
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 06:51:25 +1000 (EST)
From: Paul Collins <paul@burly.ondioline.org>
To: michael@ellerman.id.au
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
References: <87tze38vzt.fsf@burly.wgtn.ondioline.org>
	<20080802184554.GB715@fieldses.org>
	<87abfvm4cc.fsf@burly.wgtn.ondioline.org>
	<877iayy4qc.fsf@burly.wgtn.ondioline.org>
	<18581.40960.737792.454035@notabene.brown>
	<87r696l1yo.fsf@burly.wgtn.ondioline.org>
	<18582.32935.501672.689845@notabene.brown>
	<87fxpll5zq.fsf@burly.wgtn.ondioline.org>
	<87y73dcd60.fsf@burly.wgtn.ondioline.org>
	<1217860597.12535.2.camel@localhost>
Date: Tue, 05 Aug 2008 08:51:23 +1200
In-Reply-To: <1217860597.12535.2.camel@localhost> (Michael Ellerman's message
	of "Tue, 05 Aug 2008 00:36:37 +1000")
Message-ID: <87hca05ws4.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Brown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Mon, 2008-08-04 at 22:00 +1200, Paul Collins wrote:
>> Paul Collins <paul@burly.ondioline.org> writes:
>> 
>> > Neil Brown <neilb@suse.de> writes:
>> >> Could you try removing the 'static' declaration for nfsd_acceptable
>> >> and recompile?
>> >> Or maybe try a different compiler?
>> >
>> > I will give these a try this evening.
>> 
>> I built myself a nice new cross compiler:
>> 
>>         powerpc-linux-gnu-gcc-4.1 (GCC) 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)
>> 
>> and rebuilt 94ad374a0751f40d25e22e036c37f7263569d24c.  Running that on
>> the server and 2.6.26 on the client, I got yet another Oops.  This one
>> locked the machine up pretty good, so all I have is a picture:
>> 
>> http://ondioline.org/~paul/DSCN1608.JPG
>
> Wow.
>
> Can you try building a kernel on the server? ie. not over NFS.

Built kernels on the server with native gcc 4.2.4 and 4.3.1 and repeated
the build test.  Both of them threw an Oops with traces like the ones
we've seen before.  Also, because now's about time to start shooting in
the dark, I tried a cross-built kernel with CC_OPTIMIZE_FOR_SIZE
disabled.  That one Oopses too.  Also I reseated the server's memory.

Although I've been able to build kernels over NFS with 2.6.26 on the
server, I've just realized I haven't tried to stress it much.  I'll try
a build loop when the server's running 2.6.26 this evening.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
