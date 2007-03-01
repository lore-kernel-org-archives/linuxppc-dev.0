Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 2B7BDDDEE7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 01:01:36 +1100 (EST)
Message-ID: <45E6DCB4.3080106@smiths-aerospace.com>
Date: Thu, 01 Mar 2007 09:01:24 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: u-boot-users@lists.sourceforge.net,  linuxppc-dev@ozlabs.org
Subject: RFA & Update: Using libfdt in u-boot for fdt command
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is a Request for Advice.

First off, for those on both the u-boot and linuxppc-dev lists, sorry 
for cross posting.  :-)

Git repo pointers...
libfdt hacks:
<http://www.cideas.us/cgi-bin/gitweb.cgi?p=linux/libfdt.git;a=summary>
u-boot hacks:
<http://www.cideas.us/cgi-bin/gitweb.cgi?p=u-boot/u-boot-mpc83xx;a=summary>

I have a proof-of-concept (actually, somewhat more than PoC) fdt command 
built using libfdt.  Now I'm looking for advice on the best way to turn 
the PoC into Real Code[tm].

Current commands:
-----------------
fdt address        - set the base address of the blob
fdt get <property> - get a property
fdt print <node>   - print the subtree starting at <node>[1]

Planned commands:
-----------------
fdt set <property> <value> - set a property value (do we want an
                        "=" as in <property> = <value>?)
fdt ?synthesize?   - create the "chosen" branch and optionally the
                        u-boot variables branch.  The OF code/calls
                        currently in bootm would be moved to this
                        command.  I'm open to suggestions for a good
                        subcommand name.

Other commands:
---------------
fdt node <name>    - create a node that can then be populated with 
properties (have not thought about this in any detail yet).

[1] If <node> is actually a <property> (which is a usage error, but I 
expect will happen all the time), "fdt print" actually does a "fdt get 
<property>"  This makes "fdt get" redundant and likely will make it go away.

Philosophy question primarily for David Gibson and Wolfgang Denk:  What 
is the best way to integrate libfdt with u-boot?  Currently it is in its 
own git repository.  Options?
1) Do we want to capture the source in the u-boot git repository?  If 
so, it becomes a snapshot and will require cross pushing/pulling between 
the libfdt repo and the u-boot repo or they will drift apart.  However, 
it makes problems #1 and #2 (below) simpler to solve but causes drift.
2) Not capturing libfdt in the u-boot repo makes it more difficult for 
integrating it with and maintaining it in u-boot, I'm not sure how to 
actually do it in a useful/usable manner.

There are three problem areas with libfdt:
1) The official Makefile is stand-alone which doesn't work well with 
u-boot.  I took the expedient route for the PoC of simply replacing it 
with a u-boot style Makefile from a different lib* subdirectory.  There 
should be a better way.

2) The official libfdt uses two header files that are not in u-boot.  I 
"fixed" this by substituting u-boot headers with equivalent functionality.
* I need to address this and see what the best compromise for header 
files is...
   a) If the u-boot headers are acceptable for the stand-alone version
        of libfdt, that would be the simplest.
   b) It may be more effective to add the necessary linux headers to
        u-boot.
   c) We could use #ifdefs to conditionally include the right files. (but
        does u-boot have a distinctive configuration def?  Probably...)

3) I added a "fdt_next_tag()" function to fdt_ro.c to allow me to step 
through the blob's tags:
   uint32_t fdt_next_tag(const void *fdt, int offset,
                         int *nextoffset, char **namep);

This is similar to "_fdt_next_tag()" (a "private" function, note the 
leading underscore) in fdt.c, but with a related but different purpose - 
  the "_fdt_next_tag()" steps through _node_ tags (skipping property 
tags) where I need to step through all tags sequentially.

Usability trivia for David: libfdt distinguishes between nodes and 
properties, which makes sense since that is how the fdt is structured. 
 From a usability standpoint, however, it is annoying to have to 
separate the property name from the node, find the node, then find the 
property.  I will probably create Yet Another Function:
   int fdt_split(char *path, char **property);
Call it with a path string and the function will separate it into the 
node portion and the property name.  If the path is invalid, it will 
return an error.  If the path is a node, it will set **property to NULL 
and return the node's offset.  If the path is a property, it will return 
the owning node's offset and set the **property pointer to point to the 
start of the property portion of the path (i.e. the next character after 
the last '/').

If you got this far, thank you for your attention.  :-)

Best regards,
gvb
