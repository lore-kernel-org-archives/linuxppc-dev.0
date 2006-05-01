Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4A53067BB4
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 05:46:13 +1000 (EST)
Subject: Re: DTC/dts modifications
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1146512732.24239.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 01 May 2006 14:45:33 -0500
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-01 at 14:39, Kumar Gala wrote:

> 
> Comment aren't the issue.

Ah, ok.


> > I think to get CPP to be usable, it will need to handle
> > the # emitted line-location markers, "# <line> <file> <level>".
> 
> Don't follow you here.

The pre-processor emits crap like this:

# 1 "cmd_load.c"
# 1 "/proj/ppc/sysperf/sw/u/jdl/86xx/u-boot-86xx/common//"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "cmd_load.c"
# 27 "cmd_load.c"
# 1 "/proj/ppc/sysperf/sw/u/jdl/86xx/u-boot-86xx/include/common.h" 1
# 30 "/proj/ppc/sysperf/sw/u/jdl/86xx/u-boot-86xx/include/common.h"
typedef unsigned char uchar;
typedef volatile unsigned long vu_long;
typedef volatile unsigned short vu_short;
typedef volatile unsigned char vu_char;

> Try running a current .dts through cpp today.  You will get errors like:
> 
> oftree.dts:15:3: error: invalid preprocessing directive #address

> Because of props like:
> 
>        #cpus = <1>;
>        #address-cells = <1>;
>        #size-cells = <0>;
> 
> If these used some other symbol instead of '#' cpp will be happy and  
> we can use it to create macros for us.

Yeah, we're not going to be able to change those; they
are "By The Book".

Instead, we'll have to make the lexical analysis conscious
of something like a <newline> context sensitive token or so.
Or throw some flag to cpp to not emit location markers.

Or something.

jdl
