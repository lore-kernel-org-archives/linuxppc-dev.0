Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89FB02BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 16:35:39 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0409201949550.6348@dell.enoriver.com>
References: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
	<E91A9C3A-0B51-11D9-9327-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0409201949550.6348@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B244CFE5-0B98-11D9-97DC-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 21 Sep 2004 02:37:23 -0400
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


On Sep 20, 2004, at 8:15 PM, Robert P. J. Day wrote:

> 1) what does it mean to have two different areas for the microcode
>    patch in DPRAM?

It means that's where the microcode was built to run.

>    and it would be useful to understand to know why the SMC patch
>    writes a little info into offset 0x2e00 and far more into 0x2f00,

You would have to ask the person that wrote it.

> 2) is the cpm_load_patch() routine justified in assuming that,
>    regardless of the patch, there will *always* be a 0x2000 and 0x2f00
>    array to load?

No, it was just done that way because that is the microcode we
had to load and that's where it belonged.

> apart from the underlying magic, are there *any* rules that patches
> have to follow,

You can only run one patch at a time.

> (as an aside, you didn't comment on a couple of other things, so i'm 
> not sure if they had any validity.  that is, what is obviously a bad 
> value for RPBASE,

The only comment I can make is there have been several different 
versions
of CPM roms on the different processor variants, the microcode patches 
are
specific to those, and perhaps the last change was for a specific 
processor
that doesn't match what you have.

Various IIC/SMC relocation patches have been used, and the USB SOF
patch has been used on the various processors.  At the time they were
used, they worked.

> if patches aren't going away any time soon, then it only makes sense 
> to make their selection as simple and as comprehensible as possible, 
> and not require the user to actually edit files to define selection 
> macros for them.

If you have the patches and can test them, go for it.


	-- Dan
