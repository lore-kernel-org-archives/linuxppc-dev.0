Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id D5B93DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 03:49:28 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3253520rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Sep 2008 10:49:26 -0700 (PDT)
Date: Wed, 17 Sep 2008 10:49:24 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Martin Kuhnert <marwisbo@gmail.com>
Subject: Re: How to make a simpleImage equivalent in 2.6.24?
Message-ID: <20080917174924.GB7913@secretlab.ca>
References: <loom.20080909T111617-678@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20080909T111617-678@post.gmane.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 11:46:42AM +0000, Martin Kuhnert wrote:
> How to compile a 2.6.24.x kernel to get an equivalent elf file which runs
> out of the ram and includes the kernel, the bootwrapper _AND_ the dtb?
> 
> As I studied the Makefile in arch/powerpc/boot it looks like
> 
>   make zImage.<myboard>
> 
> should work. I tried it this in many ways but Make doesn't find the target.

Yes, you can make this work, but it doesn't work "out of the box".
You'll need to do some poking around the wrapper script to generate the
right stuff in your image.

> Currently, I'm using "make zImage" and arch/powerpc/boot/wrapper
> for this purpose:

BTW, the 'zImage' target isn't a real image target in the Makefile.
Instead, 'zImage' builds the list of targets stored in the image-y
makefile variable.  It might help for you to look at
Documentation/powerpc/bootwrapper.txt.

g.
