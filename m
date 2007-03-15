Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.152])
	by ozlabs.org (Postfix) with ESMTP id 42D8FDDD09
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 13:49:24 +1100 (EST)
Message-ID: <45F8B432.9010702@comcast.net>
Date: Wed, 14 Mar 2007 22:49:22 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [dtc] Add support for flat device tree format version 17
References: <20070313062240.GA22737@localhost.localdomain>	<45F863DF.5050709@freescale.com>	<45F864E8.40501@smiths-aerospace.com>
	<45F86C25.1070301@freescale.com> <45F8A229.7040602@comcast.net>
	<45F8A374.9090200@freescale.com>
In-Reply-To: <45F8A374.9090200@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Jerry Van Baren wrote:
> 
>> Actually, I believe that is how the existing code works: it opens the 
>> original blob and copies it to a newly created dft.  It then augments 
>> the new dft with a "chosen" node and optionally additional nodes 
>> (bd_t, env variables) and passes the new dft blob to linux.  
>> Theoretically, the existing code will read a v17 blob and create a new 
>> v16 blob from it (without the additional v17 length field - the header 
>> would be created, not copied).
> 
> I'll check out the code and see what it does, since I'm not really 
> familiar with it.
> 
>>
>> Trivia: the current code is kinda dumb about it: if the original blob 
>> had a "chosen" node, the code *adds another* "chosen" node.
> 
> Yes, I have this bug on my to-do list to fix.

That is close to the top of my list.  My intent with the "fdt" command 
is to have a subcommand that creates the "chosen" node.  This will 
replace the auto-generation (with no opportunity to review or revise) 
the "chosen" node as part of the "bootm" command.

Downside: "bootm" becomes more than one command.  So script it.
Upside: MUCH cleaner, allows the user to review and revise the blob 
before booting linux.

These are my current thoughts for the "fdt" command:
=> help fdt
fdt addr   <addr>                  - Set the fdt location to <addr>
fdt get    <node> <property>       - Get the value of <node> <property>
fdt set    <node> <property> <val> - Set the value of <property> to <val>
     (creates a new property if necessary)
fdt mknode <node>                  - Create a new node <node>
     (the path must exist except for the last node name)
fdt rmnode <node>                  - Deletes the node <node>
     (the last node name in the path)
fdt print  <node> [<property>]     - Recursive print starting at <node>
     (if <property> is specified, prints only that property)
fdt chosen - Add/update the "chosen" branch to the tree
Hints:
  * "fdt print /" prints the whole tree.
  * If the property you are setting/printing has a '#' character,
      you MUST escape it with a \ character or quote it with " or
      it will be ignored as a comment.
  * If the value has spaces in it, you MUST escape the spaces with
      \ characters or quote it with "
Examples: fdt p /cpus "#address-cells"
           fdt s /cpus "#address-cells" "[00 00 00 01]"

I've actually implemented addr, set, and print (get is an alias for print).

>> Back to libdft: with a v16 blob, libdft has to either modify in place 
>> (no size change) or you have to create a new blob and copy the 
>> original data over (like the existing code).  With the v17 blob, 
>> libdft is able to expand and contract the contents of the blob (with 
>> limitations, I'm sure).
> 
> I agree that it would be nice if U-Boot had a robust DTB parser, but I 
> don't have the time to do that work.

libfdt.

David already did the work, I'm working on the integration (works but 
needs some cleanup).

gvb
