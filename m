Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92C3E2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 01:35:06 +1000 (EST)
Subject: Re: [REGRESSION] nfsd crashing with 3.6.0-rc7 on PowerPC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120928151043.GA19102@fieldses.org>
Date: Fri, 28 Sep 2012 17:34:50 +0200
Message-Id: <3EC6FEEF-33B0-4B8B-83E6-64A5E50AB731@suse.de>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
 <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
 <DC545CD9-8745-47DD-B13B-3385C0EB5B27@suse.de>
 <20120928151043.GA19102@fieldses.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML List <linux-kernel@vger.kernel.org>, skinsbursky@parallels.com,
 bfields@redhat.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.09.2012, at 17:10, J. Bruce Fields wrote:

> On Fri, Sep 28, 2012 at 04:19:55AM +0200, Alexander Graf wrote:
>>=20
>> On 28.09.2012, at 04:04, Linus Torvalds wrote:
>>=20
>>> On Thu, Sep 27, 2012 at 6:55 PM, Alexander Graf <agraf@suse.de> =
wrote:
>>>>=20
>>>> Below are OOPS excerpts from different rc's I tried. All of them =
crashed - all the way up to current Linus' master branch. I haven't =
cross-checked, but I don't remember any such behavior from pre-3.6 =
releases.
>>>=20
>>> Since you seem to be able to reproduce it easily (and apparently
>>> reliably), any chance you could just bisect it?
>>>=20
>>> Since I assume v3.5 is fine, and apparently -rc1 is already busted, =
a simple
>>>=20
>>>  git bisect start
>>>  git bisect good v3.5
>>>  git bisect bad v3.6-rc1
>>>=20
>>> will get you started on your adventure..
>>=20
>> Heh, will give it a try :). The thing really does look quite =
bisectable.
>>=20
>>=20
>> It might take a few hours though - the machine isn't exactly fast by =
today's standards and it's getting late here. But I'll keep you updated.
>=20
> I doubt it's anything special about that workload, but just for kicks =
I
> tried a "git clone -ls" (cloning my linux tree to another directory on
> the same nfs filesystem), with server on 3.6.0-rc7, and didn't see
> anything interesting (just an xfs lockdep warning that looks like this
> one jlayton already reported:
> http://oss.sgi.com/archives/xfs/2012-09/msg00088.html
> )
>=20
> Any (even partial) bisection results would certainly be useful, =
thanks.

Yeah, still trying. Running the same workload in a PPC VM didn't show =
any badness. Then I tried again to bisect on the machine it broken on, =
and that commit failed even more badly on me than the previous ones, =
destroying my local git tree.

Trying to narrow down now in a slightly more contained environment :).


Alex
