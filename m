Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6B93167BBE
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 08:00:53 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 2 May 2006 00:00:35 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Message-ID: <20060501220034.GA22651@iram.es>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
	<20060501150728.04694488.kim.phillips@freescale.com>
	<00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 01, 2006 at 03:28:34PM -0500, Kumar Gala wrote:
> 
> Cool, here's an invocation that seems to work well.  Not sure what  
> causes linux = 1 (thus I need the -U linux).  Also address the line  
> information that is normally spit out.
> 
> cpp -U linux -P -x assembler-with-cpp foo.dts

Try to add the -undef parameter:

`-undef'
     Do not predefine any system-specific or GCC-specific macros.  The
     standard predefined macros remain defined.

On this machine, the number of lines from:

cpp -dM -x assembler-with-cpp /dev/null

drops from 83 (among which linux, unix, PPC, and powerpc do not start
with underscores) to 5(!) when I add the -undef option. The only ones
left are:

#define __linux__ 1
#define __STDC_HOSTED__ 1
#define __unix__ 1
#define __gnu_linux__ 1
#define __ASSEMBLER__ 1

but at least they all have leading and trailing double underscores.

	Regards,
	Gabriel
