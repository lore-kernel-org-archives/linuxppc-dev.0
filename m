Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 9B665DE056
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 10:20:14 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so306007anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 15:20:13 -0800 (PST)
Message-ID: <fa686aa40801111520m3b9c3ea6rc7ee38519dcc9a4b@mail.gmail.com>
Date: Fri, 11 Jan 2008 16:20:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: StorCenter Help?
In-Reply-To: <E1JDT1Q-0007Bj-1Q@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JDT1Q-0007Bj-1Q@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/08, Jon Loeliger <jdl@jdl.com> wrote:
> Folks,
>
> Anyone out there with an 8241 board such as
> the IoMega StorCenter who would be willing to
> help me debug my arch/powerpc cuImage problems?
>
> I feel like I am missing something very basic in
> my port... like, "Did you map this memory right?"
> or "Did you set _this_ magic bit?"
>
> I have posted the 3 patches that provide the basic
> port and cuImage support as well.  The U-Boot that
> I have is still legacy, so I'd like to get linux
> working first via the cuImage, and then work on U-Boot.
>
> The problem is that as soon as U-Boot uncompresses the
> cuImage and loads it, I get no further console output.
>
> The failing log follows.
>
> And I don't have a BDI-2000 or JTAG thing I can use here.
> Which is sort of why I'm tossing this out for general help.

Since you're getting absolutely no output after uncompression it
probably means that you're failing in the boot wrapper... which means
mmu is off, and the serial port is already set up by u-boot.

You should be able to add direct writes to the uart fifo register from
within the bootwrapper code to see how far you get in the progress.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
