Return-Path: <chris.friesen@genband.com>
Received: from exprod7og128.obsmtp.com (exprod7og128.obsmtp.com [64.18.2.121])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA9AF2C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 02:03:01 +1100 (EST)
Message-ID: <5159A180.90000@genband.com>
Date: Mon, 01 Apr 2013 09:02:24 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: weird elf header issues, is it binutils or my linker script?
References: <51545BF3.2090204@genband.com>
 <1AEA14BF-7AFA-43F4-8082-F0D3031C60A8@kernel.crashing.org>
In-Reply-To: <1AEA14BF-7AFA-43F4-8082-F0D3031C60A8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2013 06:01 AM, Segher Boessenkool wrote:
>> PHDRS
>> {
>> headers PT_PHDR PHDRS ;
>> interp PT_INTERP ;
>> <snip>
>> }
>>
>> SECTIONS
>> {
>> /* Read-only sections, merged into text segment: */
>> PROVIDE (__executable_start = 0xf2000000); . = 0xf2000000 +
>> SIZEOF_HEADERS;
>> .interp : { *(.interp) } :text :interp
>> <snip>
>> }
>>
>> So I'm wondering...is this something wrong with our linker script,
>> or is there a bug in our binutils? I'm no linker expert, but the
>> interpreter sections in the script seem to match the binutils
>> documentation that I found and I don't see anything that would be
>> messing with the length.
>>
>> Any suggestions on where to look?
>
> It looks like your .interp input section lacks the required
> zero-termination.

That's the weird thing....the actual interpreter string "/lib/ld.so.1" 
is in fact null-terminated, but the length in the elf headers is 
incorrect (0x30 instead of 0xd) and so when the kernel checks the last 
character in the array it sees a nonzero value.

What I don't understand is where the "/lib/ld.so.1" string is coming 
from and how the length gets set to the invalid value.

Chris
