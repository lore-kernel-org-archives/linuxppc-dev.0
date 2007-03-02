Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc13.comcast.net (rwcrmhc13.comcast.net [204.127.192.83])
	by ozlabs.org (Postfix) with ESMTP id 3E49ADDF16
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 16:25:19 +1100 (EST)
Message-ID: <45E7B53D.6020603@comcast.net>
Date: Fri, 02 Mar 2007 00:25:17 -0500
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	u-boot-users@lists.sourceforge.net,  linuxppc-dev@ozlabs.org
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070302015553.GA1687@localhost.localdomain>
	<45E7A346.5080206@comcast.net>
	<20070302044815.GI1687@localhost.localdomain>
In-Reply-To: <20070302044815.GI1687@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Mar 01, 2007 at 11:08:38PM -0500, Jerry Van Baren wrote:

[snip]

>> to give me a pointer to the node name for node tags and property name 
>> for property tags.  Now that I have it working, it would be trivial to 
>> change the calls to _fdt_next_tag() to instead call fdt_next_tag() 
>> passing NULL for the new fourth parameter **namep. ;-)
>>
>> The reason I need it, I'm printing an unknown tree by stepping through 
>> the tree discovering the node and property names.  I need to have 
>> fdt_next_tag() return the *name* of the node/property as well as the tag 
>> so that I can print and indent for nodes or look up the property value 
>> and print the name=value combination.
> 
> Hrm.  And it returns NULL for tags without a name?

I was unable to generate a tag without a name using dtc (other than the 
root node).  It should/would return null, which would be a problem. :-/

> That might be a useful extension for the next_tag function.  The one
> thing I'm concerned about is who's responsible for verifying the name
> pointer.  I'm trying to keep libfdt robust enough that evern if
> presented with a badly corrupt blob it will fail relatively
> gracefully.  Ideally, no matter what it's presented with, it will
> always return at worst FDT_ERR_BADSTRUCTURE rather than crashing and
> will under no circumstances access memory outside the given blob
> size.

[snip]

>> Oh gaak!  What I hear you saying... if you have node a with subnode b 
>> and property b, subnode b has a property c:
>> /a     => node
>> /a/b   => node
>> /a/b   => property (inside node a)
>> /a/b/c => property (inside node b)
> 
> Well, yes.  Except that in OF and derived terminology, properties are
> *never* referred to by path in this way.  It's always:
> 	"property 'fred' of node /foo/bar/baz"

I'm coming from a human interface syntax point of view and assumed that 
the human interface is paths like linux where the last item is a 
directory or file with the computer guessing what you really meant 
(which _isn't_ ambiguous in file/dir paths).  Is there a better syntax 
for distinguishing between node paths and properties?

>> Where I am right now is I created a new function fdt_fullpath_offset:
>>
>> int fdt_fullpath_offset(const void *fdt, const char *path, char **prop);
>>
>> which will return the _node_ /a/b in the gaak illustration above.  It 
>> looks up nodes until it either runs out of path to look up or there is 
>> an error.  On a lookup error, it tries again with the last part of the 
>> path used as a property name.  As a result, if you pass in /a it will 
>> return the node "a", if you pass in /a/b it will return the _node_ "b". 
>>   This is unchanged behavior compared to fdt_path_offset().  (Getting 
>> property "b" is unchanged: you would have to look up node /a with either 
>> fdt_fullpath_offset(... "/a" ...) or fdt_path_offset(... "/a" ...) and 
>> then use that offset with fdt_property() to get the property "b".)
> 
> I really don't like this idea much.  I don't think it's sufficiently
> useful to justify the increased implementation complexity and semantic
> confusion.

But that is the human notation, or am I making incorrect assumptions? 
I'm new to OF and fdt notation.

[snip]

FWIIW, this is what I have running in u-boot...

----------------------------------------------------------------
gaak.dts
----------------------------------------------------------------
/*
  * Ugly ugly ugly tree for testing.
  */
/ {
         model = "gaak";
         compatible = "notlikely";
         #address-cells = <1>;
         #size-cells = <1>;
         linux,phandle = <100>;

         ugly = "first level property ugly";
         ugly {
                 ugly {
                         ugly = "third level property ugly";
                 };
/**** dtc doesn't allow having a property after a node
                 ugly = "second level property ugly";
****/
         };
/**** dtc doesn't allow an anonymous node other than the root one?
         {
                 ugly = "ugly property in anonymous node";
         };
****/
};
----------------------------------------------------------------
u-boot "fdt" output
----------------------------------------------------------------
=> fdt print /
/ {
         model="gaak"
         compatible="notlikely"
         #address-cells=<00000001>
         #size-cells=<00000001>
         linux,phandle=<00000100>
         ugly="first level property ugly"
         ugly {
                 ugly {
                         ugly="third level property ugly"
                 }
         }
}
=> fdt print /ugly
ugly {
         ugly {
                 ugly="third level property ugly"
         }
}
=> fdt get /ugly
/ugly="first level property ugly"
----------------------------------------------------------------

Oops, I forgot to print the semicolons on the tree dump.  Something to 
fix tomorrow^W later today.

Best regards,
gvb
