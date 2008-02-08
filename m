Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 949A7DDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 01:07:06 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1032420anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Feb 2008 06:07:05 -0800 (PST)
Message-ID: <fa686aa40802080607h299811devc15af33d0fa8bd90@mail.gmail.com>
Date: Fri, 8 Feb 2008 07:07:04 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	jwboyer@gmail.com, scottwood@freescale.com,
	stephen.neuendorffer@xilinx.com
Subject: Re: [RFC][POWERPC] bootwrapper: Add a firmware-independent simpleboot
	target.
In-Reply-To: <20080208110219.GC27955@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
	<20080208110219.GC27955@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 8, 2008 4:02 AM, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Feb 01, 2008 at 11:55:42PM -0700, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > +     /* Make sure FDT blob is sane */
> > +     if (fdt_check_header(_dtb_start) != 0)
> > +             fatal("Invalid device tree blob\n");
>
> I think most of these fatal()s are pretty pointless.  This is
> platform_init(), so the console won't even have been initialized to
> actually print any of the messages.  Precisely because this is
> simpleboot, in which every bit of information the wrapper has comes
> from teh device tree, if the provided blob is so bad as to fail these
> basic tests, we're totally stuffed anyway.  It'll take a hardware
> debugger to track down, and I don't think the fatal()s will actually
> help much at that point.

heh; very true.  I'll kill them.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
