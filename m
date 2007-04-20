Return-Path: <dhuffman@storix.com>
Received: from storix.com (unknown [206.71.178.18])
	by ozlabs.org (Postfix) with ESMTP id E0885DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 07:05:15 +1000 (EST)
Message-ID: <46292B07.3030907@storix.com>
Date: Fri, 20 Apr 2007 14:05:11 -0700
From: David Huffman <dhuffman@storix.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>,  linuxppc-dev@ozlabs.org
Subject: Re: Kernel Panic booting cdrom
References: <46202254.1090606@storix.com> <20070414044529.GE6062@localdomain>
	<4623F574.1030804@storix.com> <20070417054537.GF6062@localdomain>
In-Reply-To: <20070417054537.GF6062@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan,

I think I determined why I received a kernel panic and the numa=off 
argument fixed the problem. When we boot from cdrom we specify maxcpus=1 
as a kernel argument. A system with numa enabled fails.  I plan on 
adding numa=off whenever I use maxcpus=1, but I wonder if you could 
answer a question for me.

I originally was told that in the case where I am booting a basic system 
into an initrd instead of in normal mode, I should use maxcpus=1 because 
there may be power and cooling daemons that are not running and try to 
limit the system resources by limiting the number of cpus. Does this 
sound right? I can successfully boot a cdrom without the maxcpus flag on 
an SMP system but maybe it is typically not a good idea?

I can prevent the kernel panics by removing maxcpus=1 and not adding 
numa=off. I am a little more informed about numa (now), but I am fuzzy 
as to all the implications with allowing more cpus for cdrom install 
media. The maxcpus=1 argument was something we added to our install boot 
media years ago and few here remember why it was such a great idea. The 
power/resource management was the only thing we could come up with.

David Huffman
Storix, Inc


Nathan Lynch wrote:
> David Huffman wrote:
>   
>> Nathan,
>>
>> Thank you very much for the info. This worked to get the system booted 
>> from cdrom. However, in normal mode, the numa=off argument is not in the 
>> yaboo.conf file. Any idea why it works without it in normal mode, but 
>> requires numa=off when using the same kernel and booting from cdrom?
>>     
>
> No, that doesn't make sense to me.  If you'd like to dig deeper into
> it, diff -u the output of dmesg from both boots.  (and please copy the
> list next time, thanks :)
>   
