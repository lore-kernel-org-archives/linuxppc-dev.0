Message-ID: <3A8AF5DC.BD4CCB70@mvista.com>
Date: Wed, 14 Feb 2001 16:17:16 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Zheng, Haifei" <haifei.zheng@intel.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'greyham@research.canon.com.au'" <greyham@research.canon.com.au>
Subject: Re: initrd problems on CLLF860T, please help.
References: <5D2136DF3DD5D311AE89009027C67FB003138BA8@fmsmsx96.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Zheng, Haifei" wrote:

> Kernel panic: No init found.  Try passing init= option to kernel.

Well, this kind of tells you something, doesn't it?  Either you
don't have an init program of some type (even /bin/sh), or you don't
have enough shared libraries on the ram disk and the program can't
be loaded properly (although you often get messages about not able
to load some .so).

To start up /bin/sh, which is a good thing to try initially, you
need the entire glibc RPM from the CDK and libtermcap.so.  You also
need that funky sym link:
	/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux -> /
in the target filesystem.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
