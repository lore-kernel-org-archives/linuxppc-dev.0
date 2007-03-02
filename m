Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [216.148.227.155])
	by ozlabs.org (Postfix) with ESMTP id 39EDCDDF0F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 15:08:41 +1100 (EST)
Message-ID: <45E7A346.5080206@comcast.net>
Date: Thu, 01 Mar 2007 23:08:38 -0500
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: u-boot-users@lists.sourceforge.net,  linuxppc-dev@ozlabs.org,
	david@gibson.dropbear.id.au
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070302015553.GA1687@localhost.localdomain>
In-Reply-To: <20070302015553.GA1687@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

David Gibson wrote:
> On Thu, Mar 01, 2007 at 09:01:24AM -0500, Jerry Van Baren wrote:
>> Hi all,
>>
>> This is a Request for Advice.
>>
>> First off, for those on both the u-boot and linuxppc-dev lists, sorry 
>> for cross posting.  :-)
>>
>> Git repo pointers...
>> libfdt hacks:
>> <http://www.cideas.us/cgi-bin/gitweb.cgi?p=linux/libfdt.git;a=summary>
>> u-boot hacks:
>> <http://www.cideas.us/cgi-bin/gitweb.cgi?p=u-boot/u-boot-mpc83xx;a=summary>

[snip]

>> 2) Not capturing libfdt in the u-boot repo makes it more difficult for 
>> integrating it with and maintaining it in u-boot, I'm not sure how to 
>> actually do it in a useful/usable manner.
> 
> I think ultimately, you'll have to pull libfdt into the u-boot
> sources.  libfdt is supposed to run in many possible environments, and
> there's no realistic way it can be compiled independently of thost
> environments.
> 
> That said, any changes to the guts of libfdt that you need should go
> upstream (in the end; right now, there are bureaucratic problems with
> that, more below).  That should reduce things to a one way pull, with
> some trivial tweaks to integrate with the u-boot environment.

OK, I figured as much, but was hoping for a miracle.

>> There are three problem areas with libfdt:
>> 1) The official Makefile is stand-alone which doesn't work well with 
>> u-boot.  I took the expedient route for the PoC of simply replacing it 
>> with a u-boot style Makefile from a different lib* subdirectory.  There 
>> should be a better way.
> 
> I think it might well be necessary to replace the Makefile for
> building libfdt into other packages.  It would be nice to avoid that
> if possible, but a sensible method is not obvious to me.

OK, no surprise.

>> 2) The official libfdt uses two header files that are not in u-boot.  I 
>> "fixed" this by substituting u-boot headers with equivalent functionality.
>> * I need to address this and see what the best compromise for header 
>> files is...
>>    a) If the u-boot headers are acceptable for the stand-alone version
>>         of libfdt, that would be the simplest.
>>    b) It may be more effective to add the necessary linux headers to
>>         u-boot.
>>    c) We could use #ifdefs to conditionally include the right files. (but
>>         does u-boot have a distinctive configuration def?  Probably...)
> 
> Ok, the way this is supposed to work is that the environment into
> which you're building should provide a replacement version of
> libfdt_env.h.  The supplied version of libfdt_env.h is just for
> userland builds.  u-boot's version will obviously use u-boot headers
> instead of standard library headers.
> 
> I should provide a comprehensive list of what libfdt_env.h needs to
> provide, but I haven't gotten around to it.  From memory it's
> basically just the fixed-with integer types, a smallish subset of the
> str*() and mem*() functions, and the endian conversion functions.
> 
> I've really tried to keep libfdt's environment dependencies down, so I
> suggest you just start with an empty libfdt_env.h and add stuff based
> on the error messages until the compiler stops whinging about
> undefined things.  It shouldn't take long.

Yes, all the functionality is in both linux headers and u-boot headers 
that it stole^Winherited from linux.  The problem is, the set is 
disjoint.  If libfdt is willing to change its headers to use 
linux/types.h, asm/byteorder.h, and linux/string.h, the problem would go 
away:

fdt.h:
-#include <stdint.h>
+#include <linux/types.h>

libfdt_env.h:
-#include <stdint.h>
-#include <string.h>
-#include <endian.h>
-#include <byteswap.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+#include <linux/string.h>

Note that asm/byteorder.h provides __be32_to_cpu(x) and friends, which 
can be used directly rather than having to synthesize swap/noswap (i.e. 
bswap_32(x)) based on #if __BYTE_ORDER == __BIG_ENDIAN.  They can be 
used directly, or fdt32_to_cpu and friends can be defined in terms 
of__be32_to_cpu(x) and friends:
+#define fdt32_to_cpu(x)                __be32_to_cpu(x)
+#define cpu_to_fdt32(x)                __cpu_to_be32(x)
+#define fdt64_to_cpu(x)                __be64_to_cpu(x)
+#define cpu_to_fdt64(x)                __cpu_to_be64(x)

When I did the above change and tried to compile it natively under 
linux, there were problems with unresolved types.  I did not pursue the 
resolution of the problem since I am currently concentrating on u-boot 
usage.

>> 3) I added a "fdt_next_tag()" function to fdt_ro.c to allow me to step 
>> through the blob's tags:
>>    uint32_t fdt_next_tag(const void *fdt, int offset,
>>                          int *nextoffset, char **namep);
>>
>> This is similar to "_fdt_next_tag()" (a "private" function, note the 
>> leading underscore) in fdt.c, but with a related but different purpose - 
>>   the "_fdt_next_tag()" steps through _node_ tags (skipping property 
>> tags) where I need to step through all tags sequentially.
> 
> Um... no.  _fdt_next_tag() steps through all tags (how else could it
> be used internally to find properties...?).  If you really need this,
> we can change the function to be exported, which I've considered
> before.  However, what are you using this function for?  I had some
> node and property traversal functions on the drawing board.

Yes, I copied and augmented _fdt_next_tag():

uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset, char 
**namep)

to give me a pointer to the node name for node tags and property name 
for property tags.  Now that I have it working, it would be trivial to 
change the calls to _fdt_next_tag() to instead call fdt_next_tag() 
passing NULL for the new fourth parameter **namep. ;-)

The reason I need it, I'm printing an unknown tree by stepping through 
the tree discovering the node and property names.  I need to have 
fdt_next_tag() return the *name* of the node/property as well as the tag 
so that I can print and indent for nodes or look up the property value 
and print the name=value combination.

>> Usability trivia for David: libfdt distinguishes between nodes and 
>> properties, which makes sense since that is how the fdt is structured. 
>>  From a usability standpoint, however, it is annoying to have to 
>> separate the property name from the node, find the node, then find the 
>> property.  I will probably create Yet Another Function:
>>    int fdt_split(char *path, char **property);
>> Call it with a path string and the function will separate it into the 
>> node portion and the property name.  If the path is invalid, it will 
>> return an error.  If the path is a node, it will set **property to NULL 
>> and return the node's offset.  If the path is a property, it will return 
>> the owning node's offset and set the **property pointer to point to the 
>> start of the property portion of the path (i.e. the next character after 
>> the last '/').
> 
> I don't like combining property and node name into a single path,
> because technically the property names occupy a different namespace
> from subnode names.  Insane though it is, there exist some Apple
> device trees where a node has both a property and a subnode of the
> same name.

Oh gaak!  What I hear you saying... if you have node a with subnode b 
and property b, subnode b has a property c:
/a     => node
/a/b   => node
/a/b   => property (inside node a)
/a/b/c => property (inside node b)

Where I am right now is I created a new function fdt_fullpath_offset:

int fdt_fullpath_offset(const void *fdt, const char *path, char **prop);

which will return the _node_ /a/b in the gaak illustration above.  It 
looks up nodes until it either runs out of path to look up or there is 
an error.  On a lookup error, it tries again with the last part of the 
path used as a property name.  As a result, if you pass in /a it will 
return the node "a", if you pass in /a/b it will return the _node_ "b". 
  This is unchanged behavior compared to fdt_path_offset().  (Getting 
property "b" is unchanged: you would have to look up node /a with either 
fdt_fullpath_offset(... "/a" ...) or fdt_path_offset(... "/a" ...) and 
then use that offset with fdt_property() to get the property "b".)

I've changed the original fdt_path_offset() to simply call 
fdt_fullpath_offset() passing in NULL for **prop and everything (should) 
work the same as before ("should" because I haven't debugged it yet).

For my u-boot commands, I have "fdt get <prop>" and "fdt print <node>" 
and was going to consolidate them into one, but the gaak illustration 
says I should _not_ consolidate them.  (Trivia: my "fdt print" of "/" 
and "/a" will (should anyway ;-) print the gaak tree properly.)

What are the odds that someone will pull an Apple on hardware supported 
by u-boot?  Hmmm... extra code to handle stupidity.

Best regards,
gvb
