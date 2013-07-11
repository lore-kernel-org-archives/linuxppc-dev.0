Return-Path: <cbf123@mail.usask.ca>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 951A52C031D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 08:46:31 +1000 (EST)
Message-ID: <51DF35B8.1060502@mail.usask.ca>
Date: Thu, 11 Jul 2013 16:46:16 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>,
 <kexec@lists.infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
In-Reply-To: <51DF2229.5010604@mail.usask.ca>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 03:22 PM, Chris Friesen wrote:
> On 07/11/2013 02:55 PM, Chris Friesen wrote:
>> Hi,
>>
>> I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
>> with 8GB of memory. (It's an embedded system and I can't do much
>> about the fact that it's using older software.)
>
> I should probably clarify this...I may be able to update kexec, I can't
> update the kernel but I can backport more recent code if necessary.
>
> Looking at the version of kexec that I have, it seems like where x86
> uses "memmap=" to specify the memory map usable by the capture kernel,
> powerpc does something different.

After some experimenting, it looks like in the capture kernel 
/dev/oldmem might actually refer to the memory owned by the old kernel.

However, there doesn't seem to be anything preventing me from trampling 
it from within the capture kernel--I can create a tmpfs filesystem in 
memory and write gigs of data to it even though the capture kernel is 
only supposed to have 224MB.

I think I got it to work properly once, but since then I haven't been 
able to get uncorrupted data out of /dev/oldmem.  (My original kernel 
reserves a chunk of memory for logging and passes the offset/size to the 
capture kernel via kexec kernel args.)

Chris
