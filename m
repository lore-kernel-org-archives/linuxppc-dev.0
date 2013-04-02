Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EBA172C0156
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 02:23:18 +1100 (EST)
In-Reply-To: <5159A180.90000@genband.com>
References: <51545BF3.2090204@genband.com>
 <1AEA14BF-7AFA-43F4-8082-F0D3031C60A8@kernel.crashing.org>
 <5159A180.90000@genband.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BFFF4F77-FA45-40B6-8836-EFF3A23A9480@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: weird elf header issues, is it binutils or my linker script?
Date: Tue, 2 Apr 2013 17:07:11 +0200
To: Chris Friesen <chris.friesen@genband.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> SECTIONS
>>> {
>>> /* Read-only sections, merged into text segment: */
>>> PROVIDE (__executable_start = 0xf2000000); . = 0xf2000000 +
>>> SIZEOF_HEADERS;
>>> .interp : { *(.interp) } :text :interp
>>> <snip>
>>> }
>>>
>>> So I'm wondering...is this something wrong with our linker script,
>>> or is there a bug in our binutils? I'm no linker expert, but the
>>> interpreter sections in the script seem to match the binutils
>>> documentation that I found and I don't see anything that would be
>>> messing with the length.
>>>
>>> Any suggestions on where to look?
>>
>> It looks like your .interp input section lacks the required
>> zero-termination.
>
> That's the weird thing....the actual interpreter string "/lib/ld.so. 
> 1" is in fact null-terminated, but the length in the elf headers is  
> incorrect (0x30 instead of 0xd) and so when the kernel checks the  
> last character in the array it sees a nonzero value.
>
> What I don't understand is where the "/lib/ld.so.1" string is  
> coming from and how the length gets set to the invalid value.

It comes from the .interp input sections, i.e. the .interp sections in
the .o files you linked together.  Perhaps you have more than one of
those?

Run ld with the -M option to tell you what it does; run readelf -xN
where N is the section number of .interp to figure out what is actually
in there.

Your PT_INTERP has a memsz < filesz, which is curious to say the least.
I suspect there are multiple zero bytes in there; this is not valid in
an ELF file.  It would be good if the linker complained about that.
The kernel loader is correct in refusing it (if that is what it is
doing :-) )


Segher
