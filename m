In-Reply-To: <OFFCEBF3AF.F02EB770-ON85256EDF.005C805F-85256EDF.005D5409@nanometrics.ca>
References: <OFFCEBF3AF.F02EB770-ON85256EDF.005C805F-85256EDF.005D5409@nanometrics.ca>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5E6876D2-E0C5-11D8-8139-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: 8xx block address mapping...
Date: Wed, 28 Jul 2004 14:38:50 -0400
To: David Ho <DavidHo@nanometrics.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 28, 2004, at 12:59 PM, David Ho wrote:

> I am just curious about how the 8xx does a block mapping (e.g. mapping
> a
> video frame buffer) without BATs.

It doesn't.  Everything is mapped with 4K pages.

> - it allocates the smallest possible page size for the block requested.
> i.e. it will have to allocate an 8-Myte page for the 2-Mbyte block,
> very
> wasteful it seems.

Worse than that.  Due to alignment the 8M page will open up lots of
aliases and access problems.

> Could you shed some light on how this works.  It will help me assess
> how
> efficient block mapping is on the 8xx.

On the 860 (or other variants with the large number of TLBs), you can
allocate a few pinned entries for the lower kernel memory and the IMMR
space.

I have some experimental code that would map larger spaces with big
pages, but the complexity of the TLB miss handler badly hurt the
performance
of the typical 4K case.  I haven't found anything that works well, yet.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
