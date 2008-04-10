Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18429.31390.141903.1442@cargo.ozlabs.ibm.com>
Date: Thu, 10 Apr 2008 12:25:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
In-Reply-To: <C91EF39E-9776-4D7C-883E-F560A671E221@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
	<0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
	<18420.31327.633359.619200@cargo.ozlabs.ibm.com>
	<C91EF39E-9776-4D7C-883E-F560A671E221@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> So now we can look at the vmlinux and determine the physical offset.   
> The question is how best to do that.  Here are the options I see:
> * readelf, grep and parse output
> * objdump grep and parse output
> * simple C program that read's the elf and reports back

Either readelf or objdump for now, and if that proves to be fragile we
can look at a C program.  You could do:

readelf -l $vmlinux | grep -m 1 LOAD | awk '{print $4}'

or

objdump -p $vmlinux | grep -m 1 LOAD | awk '{print $7}'

There's not a lot of difference.  Since the wrapper already uses
objdump, I think we should use objdump rather than making the wrapper
depend on an additional program (readelf).

> The other questions is if we'd ever have a vmlinux with more than one  
> PT_LOAD PHDR.  If so which one do we use (the one with the lowest  
> physical address)?

I think we would take the first one.

Paul.
