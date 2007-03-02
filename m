Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id CB65FDDF13
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 05:38:39 +1100 (EST)
Message-ID: <45E86F20.8000402@smiths-aerospace.com>
Date: Fri, 02 Mar 2007 13:38:24 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@comcast.net>,
	u-boot-users@lists.sourceforge.net,  linuxppc-dev@ozlabs.org
Subject: Re: [U-Boot-Users] RFA & Update: Using libfdt in u-boot for
	fdt	command
References: <45E6DCB4.3080106@smiths-aerospace.com>	<20070302015553.GA1687@localhost.localdomain>	<45E7A346.5080206@comcast.net>	<20070302044815.GI1687@localhost.localdomain>	<45E7B53D.6020603@comcast.net>
	<20070302053640.GJ1687@localhost.localdomain>
In-Reply-To: <20070302053640.GJ1687@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, Mar 02, 2007 at 12:25:17AM -0500, Jerry Van Baren wrote:
>> David Gibson wrote:
>>> On Thu, Mar 01, 2007 at 11:08:38PM -0500, Jerry Van Baren wrote:
>> [snip]
>>
>>>> to give me a pointer to the node name for node tags and property name 
>>>> for property tags.  Now that I have it working, it would be trivial to 
>>>> change the calls to _fdt_next_tag() to instead call fdt_next_tag() 
>>>> passing NULL for the new fourth parameter **namep. ;-)
>>>>
>>>> The reason I need it, I'm printing an unknown tree by stepping through 
>>>> the tree discovering the node and property names.  I need to have 
>>>> fdt_next_tag() return the *name* of the node/property as well as the tag 
>>>> so that I can print and indent for nodes or look up the property value 
>>>> and print the name=value combination.
>>> Hrm.  And it returns NULL for tags without a name?
>> I was unable to generate a tag without a name using dtc (other than the 
>> root node).  It should/would return null, which would be a problem. :-/
> 
> I was thinking more of tag types which don't have a name, to wit,
> FDT_END_NODE and FDT_NOP.

fdt_next_tag() returns the tag, so it returns FDT_END_NODE or FDT_NOP 
and, presumably, the caller would know there is no name associated with 
those tags.  Setting the name pointer *namep to NULL would be good 
paranoia, however.

Best regards,
gvb
