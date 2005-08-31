Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 356A468109
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 10:10:45 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 0F3B3A4026
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 02:10:43 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 31 Aug 2005 02:10:51 +0200
References: <431496FC.3090208@icarus.com>
In-Reply-To: <431496FC.3090208@icarus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508310210.51561.roger.larsson@norran.net>
Subject: Re: Mapping huge user buffers for DMA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 30 August 2005 19.27, Stephen Williams wrote:
> I have a PPC405GPr system with an image processing device, that
> is creating potentially huge amounts of data. In one setup I
> have a 256Meg system, and I'm trying to map a 192Meg destination
> buffer using map_user_kiovec and an array of kiobufs.

Never tried to map that amount at once. Our code looks, or looked, like this.
Found some code...
/usr/src/linuxppc_2_4_devel/arch/cris/drivers/examples/kiobuftest.c 

>
> I'm finding, however, that I'm getting an Oops in map_user_kiovec
> when it tries this, and I'm wondering where I need to look for
> any limits I might be overrunning.

What does the Oops say??
Hmm... How much space will the vector itself require?

>
> Also, I've been considering skipping kiobufs all together and
> instead using code like this (lifted from map_user_kiobuf)
>
> 	/* Try to fault in all of the necessary pages */
> 	down_read(&mm->mmap_sem);
> 	/* rw==READ means read from disk, write into memory area */
> 	err = get_user_pages(current, mm, va, pgcount,
> 			(rw==READ), 0, iobuf->maplist, NULL);
> 	up_read(&mm->mmap_sem);
>
> to get the user pages directly. This is really what I want, and
> I do not need the other functionality of kiobufs. Is the
> get_user_pages function kosher for use by drivers? Is there
> a limit to what get_user_pages may map?

Isn't this the way it is done in 2.6 anyway?

/RogerL
