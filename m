Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C29A2BDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 08:08:39 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
References: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E91A9C3A-0B51-11D9-9327-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 20 Sep 2004 18:10:41 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 20, 2004, at 4:05 PM, Robert P. J. Day wrote:

> 1) am i to assume that the two chunks of microcode written to these
>    two different addresses are run independently?

Nope.  Don't ever assume anything.  Read the microcode patch
instructions, load the code where it says, set registers as it says.

> 2) in cpm_load_patch(), before writing microcode into dpmem, the
>    RCCR register is set to disable microcode:
>
>    commproc->cp_rccr = 0;
>
>    and is reactivated later.  is this necessary while you're
>    installing ucode?

Some boot roms install versions of microcode patches that
we know nothing about.  This is the way to remove them and
install what our Linux drivers know.

> 3) next, in micropatch.c, microcode is directly copied from the
>    patch arrays patch_2000[] and patch_2f00[] into the respective
>    addresses in dpmem.  but who's to say that these arrays are
>    always guaranteed to exist?

Those were the locations used for the microcode patches known
at the time.  Again, it's where the instructions said to load the
patches.  We know nothing more about it.

>   .....notice above that there could very
>    well exist a patch that writes to 2000 and 2e00 instead.

When that happens, we'll have to adjust for it.

> ...... i'm not even going to ask what that
>    does, but it will come up later.  i'm just going to accept it as
>    magic and move on.

Don't ask later.  It's all magic.  Just follow the instructions.

>    thoughts?

Stop trying to understand the undocumented details of the CPM :-)
There have been many patches over the years, some may not
be available anymore, some we may have never used.  The
current Linux drivers may not be up to date with the more recent
versions of microcode patches.

At one time, we had a bunch of little patches.  IIC only, SMC only,
USB SOF.  Then, some of them were combined so you could do
multiple relocations at once, like IIC and SMCs.  I don't know if
we have ever done that.  I know Wolfgang has been keeping
more up to date with his development trees, so it wouldn't hurt
to look there.


	-- Dan
