Return-Path: <dgibson@ozlabs.org>
Date: Sat, 3 Mar 2007 09:31:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [U-Boot-Users] RFA & Update: Using libfdt in u-boot for
	fdt	command
Message-ID: <20070302223140.GA11166@localhost.localdomain>
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070302015553.GA1687@localhost.localdomain>
	<45E7A346.5080206@comcast.net>
	<20070302044815.GI1687@localhost.localdomain>
	<45E7B53D.6020603@comcast.net>
	<20070302053640.GJ1687@localhost.localdomain>
	<45E8192B.8020104@comcast.net>
	<45E86E77.3020305@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E86E77.3020305@smiths-aerospace.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 02, 2007 at 01:35:35PM -0500, Jerry Van Baren wrote:
> Jerry Van Baren wrote:
> > David Gibson wrote:
[snip]
> OK, here is a reference on the OF device tree browsing commands:
> <http://www.firmworks.com/QuickRef.html#Device%20Tree%20Browsing>
> 
> Where I'm coming from is that I've written the "fdt print" command to 
> put out the same text (possibly with data formatting differences) as 
> went into the dtc to create the blob.  This is very useful and intuitive 
> to me.
> 
> The OF device tree browsing is modeled after filesys directory and file 
> browsing (sorta).
>    ".properties" ~ "ls" but only shows files (properties ~ files)
>    "dev" == "cd"
>    "ls" == "ls -d *" (only shows subdirectories)
>    "pwd" == "pwd"
>    "dend" - has no equiv
>    "show-devs" - has no equiv, sounds like it may be my "print" command
>    "words" - has no equiv, does not apply (dir *.exe in DOS :-)
>    "sift-devs ccc" == find . -name "*ccc*"
> 
> Looks a lot more complex with no clear benefit for u-boot.

Sorry, I was unclear.  I wasn't trying to suggest you use the OF
client interface model for device tree commands in general.  Just that
you don't treat properties as having paths.

> I have not found any character that could clearly and cleanly be used to 
> separate the node path from the property name.
> * Comma ',' - used to separate a device name from an argument - one
>       could argue that the property name is an argument to the path.
>       "/foo/bar,baz" is the property baz under the node "/foo/bar".
> * Space ' ' - "/foo/bar/baz" is a node path, "/foo/bar baz" is the
>      property baz under the node "/foo/bar".  Spaces complicate parsing.

Space only complicates parsing if you insist of thinking of these
things as paths-to-properties, which is not really a good idea in the
first place.  Just think of the node-path and the property name as
separate parameters to your commands.

So, getprop takes 2 parameters (node, property), setprop takes 3
(node, property, value).  print, or whatever you end up calling it
takes either 1 or 2 (node, plus optional property name)

> Any strong opinions?  At this point I don't see any reason to change 
> from my current technique and proposed command set for u-boot.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
