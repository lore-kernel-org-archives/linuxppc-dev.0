Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id A59C667AC7
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 00:39:05 +1000 (EST)
To: surendra.yadav@softdel.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Apr 2005 18:35:47 +0530."
	<BPEMKMADCCCPHPEDDKOOCEDLCEAA.surendra.yadav@softdel.com>
Date: Tue, 26 Apr 2005 16:38:37 +0200
Sender: wd@denx.de
Message-Id: <20050426143842.A1FFFC1510@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: gdbserver problem on powerpc. 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <BPEMKMADCCCPHPEDDKOOCEDLCEAA.surendra.yadav@softdel.com> you wrote:
> 
> I downloaded gdb-6.0 and cross compiled gdbserver for powerpc platform.
> 
> When gdbserver I tried to run gdbserver it gives "No such file or
> directory".

Did you link gdbserver statically, or are you using shared libraries?
Is any other application using the same  libraries  working  on  your
target?

> But I can see this file is present in the bin directory. Even I tried
> precompiled binary from ELDK but that also does not work and gives the same
> message. Can any one suggest what is the wrong?

The ELDK's gdbserver is dynamically linked:

-> ppc_8xx-ldd /opt/eldk/ppc_8xx/usr/bin/gdbserver
        libthread_db.so.1 => /opt/eldk-3.1/ppc_8xx/lib/libthread_db.so.1
	libc.so.6 => /opt/eldk-3.1/ppc_8xx/lib/libc.so.6
	ld.so.1 => /opt/eldk-3.1/ppc_8xx/lib/ld.so.1

Make sure to include the required libraries and /lib/ld.so.1 in  your
target filesystem.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
Precisely Where This Product Is and How Fast It Is Moving.
