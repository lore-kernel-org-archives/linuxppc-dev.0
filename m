Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B5F62C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 23:01:23 +1100 (EST)
In-Reply-To: <51545BF3.2090204@genband.com>
References: <51545BF3.2090204@genband.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1AEA14BF-7AFA-43F4-8082-F0D3031C60A8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: weird elf header issues, is it binutils or my linker script?
Date: Fri, 29 Mar 2013 13:01:15 +0100
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

> PHDRS
> {
>   headers PT_PHDR PHDRS ;
>   interp PT_INTERP ;
> <snip>
> }
>
> SECTIONS
> {
>   /* Read-only sections, merged into text segment: */
>   PROVIDE (__executable_start = 0xf2000000); . = 0xf2000000 +  
> SIZEOF_HEADERS;
>   .interp         : { *(.interp) } :text :interp
> <snip>
> }
>
> So I'm wondering...is this something wrong with our linker script,  
> or is there a bug
> in our binutils?  I'm no linker expert, but the interpreter  
> sections in the script
> seem to match the binutils documentation that I found and I don't  
> see anything that
> would be messing with the length.
>
> Any suggestions on where to look?

It looks like your .interp input section lacks the required zero- 
termination.


Segher
