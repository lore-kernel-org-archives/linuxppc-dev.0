Message-ID: <3BF1D0B7.3040208@embeddededge.com>
Date: Tue, 13 Nov 2001 21:02:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Mueller <diffusor@ugcs.caltech.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc 405 floating point math emulation
References: <20011113155956.B7553@spew.ugcs.caltech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Mueller wrote:

> ..... When I try this with an old Monta Vista kernel from April
> 12th (used in an a HardHat pre-release, but no longer available), the
> compile eventually fails while linking and mentions some 8xx specific
> symbols.

The MontaVista kernel, tools, libraries and applications are all created
as a cohesive distribution.  In the case of processors that don't have
floating point hardware, everything is created to use the in-line software
floating point.  You can't mix tools, libraries, and applications with
different floating point implementations within the same distribution.

Since the kernel never had to support floating point emulation, the 4xx
processors never had a proper kernel emulation interface for that.  This
was recently changed in the public source trees, which is what you should
be using if you want this feature.

> .....  I assume this is leftovers from 2 years ago when there
> appear to have been efforts to add math emulation support for the 8xx
> chips?

No, it is just that the 8xx was the only PowerPC that ever supported
the kernel floating point emulation traps, so when you select that option
it tries to hook into 8xx functions that don't exist when 8xx isn't configured.


Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
