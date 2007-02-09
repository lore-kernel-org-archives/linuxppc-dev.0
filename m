Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <45CCFE49.9010406@am.sony.com>
Date: Fri, 09 Feb 2007 15:05:45 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Okay to change default zImage link/load address?
References: <20070209184345.GA28127@mag.az.mvista.com>
	<20070209185107.GA12703@aepfle.de>
	<20070209185528.GB28127@mag.az.mvista.com>
	<45CCCCAD.2040507@am.sony.com>
	<20070209224010.GB7339@localhost.localdomain>
In-Reply-To: <20070209224010.GB7339@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, Feb 09, 2007 at 11:34:05AM -0800, Geoff Levand wrote:
>> Mark A. Greer wrote:
>> > On Fri, Feb 09, 2007 at 07:51:07PM +0100, Olaf Hering wrote:
>> >> On Fri, Feb 09, Mark A. Greer wrote:
>> >> 
>> >> > Does anyone know of a problem downloading to 8MB instead of 4MB in
>> >> > arch/powerpc?  If not, would you object if it changed to 8MB?
>> >> 
>> >> IBM chrp 32 and 64bit has a free and usable memory range from 64k to
>> >> 12M.
>> >> Changing the link address from 4 to 8 MB will reduce the max zImage size
>> >> to 3MB on these systems.
>> > 
>> > Hmm, not good.
>> > 
>> > Paul, may we may this configurable (i.e., a CONFIG option)?
>>  
>> To have zImage.lds.S use a config option you'll need to run it through
>> the preprocessor, which in general seems like a good thing.  Now we just
>> have this:
>> 
>> $(obj)/zImage.lds $(obj)/zImage.coff.lds: $(obj)/%: $(srctree)/$(src)/%.S
>> 	@cp $< $@
> 
> No.  Well, at that, running zImage.lds.S through the preprocessor
> might not be a bad idea, but we definitely want to avoid using the
> config anywhere in the bootwrapper, except in the Makefile for
> choosing the platform passed to the wrapper script.  The idea is that
> it should always be possible to wrap a given vmlinux using the wrapper
> script and wrapper library, outside the context of the kernel source
> tree that built that vmlinux.
> 
> Note that the zImage is already build -fPIC and capable of relocating
> itself if loaded at an address other than 4MB...
> 

That line is from the makefile, not the wrapper, so the preprocessing,
and the use of the config file would be prior to running the wrapper.

It seems though that you are talking about something other than using
a config option to change the hard coded output location in the linker
script, which I thought was Mark's proposal.

-Geoff
