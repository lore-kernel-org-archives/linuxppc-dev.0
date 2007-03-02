Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id B32B9DDF13
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 05:35:55 +1100 (EST)
Message-ID: <45E86E77.3020305@smiths-aerospace.com>
Date: Fri, 02 Mar 2007 13:35:35 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [U-Boot-Users] RFA & Update: Using libfdt in u-boot for
	fdt	command
References: <45E6DCB4.3080106@smiths-aerospace.com>	<20070302015553.GA1687@localhost.localdomain>	<45E7A346.5080206@comcast.net>	<20070302044815.GI1687@localhost.localdomain>	<45E7B53D.6020603@comcast.net>	<20070302053640.GJ1687@localhost.localdomain>
	<45E8192B.8020104@comcast.net>
In-Reply-To: <45E8192B.8020104@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:
> David Gibson wrote:

[lots of snipping]

>>> I'm coming from a human interface syntax point of view and assumed that 
>>> the human interface is paths like linux where the last item is a 
>>> directory or file with the computer guessing what you really meant 
>>> (which _isn't_ ambiguous in file/dir paths).  Is there a better syntax 
>>> for distinguishing between node paths and properties?
>> You assumed incorrectly.  Well, unless you count /proc/device-tree as
>> a human interface to the device tree, which isn't entirely
>> unreasonable.  OF certainly doesn't use that approach, it uses state
>> instead, first "dev /foo/bar/baz" then ".properties" or "setprop ....".
> 
> OF is a programming language that has some crude elements of interaction 
> (wouldn't that be "/foo/bar/baz" dev in Forthspeak? ;-).  Making user 
> interface commands have state, where you do "fdt dev /foo/bar/baz" 
> (remembering the offset of the node) and then "fdt .properties" 
> implicitly working on /foo/bar/baz is ugly ugly ugly.
> 
> We need a usable human interface syntax, replacing the last "/" with 
> some other character that is not a legal character for a name and thus 
> won't cause confusion.  I am not familiar enough with OF to know if 
> there is a unique character that can be used for the node path vs. 
> property separator.  If someone has a good one, hollar, otherwise I'll 
> do some more research when I have time.
> 
> Lacking a good property separator character, I will be sticking with the 
> convention that the stuff after the last "/" is a node unless that 
> assumption is wrong, in which case it is a property.
> 
> Best regards,
> gvb

OK, here is a reference on the OF device tree browsing commands:
<http://www.firmworks.com/QuickRef.html#Device%20Tree%20Browsing>

Where I'm coming from is that I've written the "fdt print" command to 
put out the same text (possibly with data formatting differences) as 
went into the dtc to create the blob.  This is very useful and intuitive 
to me.

The OF device tree browsing is modeled after filesys directory and file 
browsing (sorta).
   ".properties" ~ "ls" but only shows files (properties ~ files)
   "dev" == "cd"
   "ls" == "ls -d *" (only shows subdirectories)
   "pwd" == "pwd"
   "dend" - has no equiv
   "show-devs" - has no equiv, sounds like it may be my "print" command
   "words" - has no equiv, does not apply (dir *.exe in DOS :-)
   "sift-devs ccc" == find . -name "*ccc*"

Looks a lot more complex with no clear benefit for u-boot.

I have not found any character that could clearly and cleanly be used to 
separate the node path from the property name.
* Comma ',' - used to separate a device name from an argument - one
      could argue that the property name is an argument to the path.
      "/foo/bar,baz" is the property baz under the node "/foo/bar".
* Space ' ' - "/foo/bar/baz" is a node path, "/foo/bar baz" is the
     property baz under the node "/foo/bar".  Spaces complicate parsing.

Any strong opinions?  At this point I don't see any reason to change 
from my current technique and proposed command set for u-boot.

Best regards,
gvb
